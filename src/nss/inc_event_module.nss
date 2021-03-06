//:://////////////////////////////////////////////
//::
//:: Created By: Scott Milliorn
//:: Created On: March 22, 2020
//::
//:://////////////////////////////////////////////
#include "inc_discord"
#include "nwnx_admin"
#include "nwnx_redis"
#include "nwnx_redis_save"
#include "x2_inc_itemprop"
#include "x3_inc_string"

//  CD Verification for Staff
int GetIsGM(object oPC);

//  Checks for the local int 'NPCTHIEF'  this is set in the onspawn script for
//  NPC's who can pickpocket
int IsThiefNPC(object oThief); // Check to see if thief is spec, quickling, etc

//  Run DM Verification code
int VerifyDM(object oPC);

//  Set the Gold Piece value in the items Description
void PrintGPValue(object oItem);

//  Fix Barter Exploit that clones items
void FixBarterExploit(object oFrom, object oPC);

//  Display Custom Message to Party to notify what loot was acquired.
void LootMessage(string sItem, string sPlayer, object oFrom, object oPC);

//  Send Faction Message
void SendMessageToFactionWithinDistance(object oPC, string sMessage, float fDist);

//  Purge item by its tagname
void PurgeItem(object oPC, object oItem, string s);

//  Strip all buffs
void RemoveAllEffects(object oCreature);

// * Applies an XP and GP penalty
// * to the player respawning
void ApplyPenalty(object oDead);

//  Used on newly created PC's to strip inventory and gold then assign default
//  inventory and gold
void StripPC(object oPC);

//  Reset Hitpoints to what they were when PC logged out (same server session)
void HitPointsAntiCheatOnEnter(object oPC);

//  Set a variable to the PC's hitpoints so that it's persistant (same server session)
void HitPointsAntiCheatOnExit(object oPC);

//  Apply penalty if we logout in combat
void DeathLog(object oPC);

//  If you logout with 0 or less HP you are penalized
void DrowCorpseLoot(object oPC);

//  Boot all clients
void BootAllPC(object oPC);

//  Raise a PC with full HP, Spells, Feats
void Raise(object oPlayer);

// Reset Faction Reputation to PC
void SetFactionsFriendly(object oPlayer);

//  Wrapper to export bic file and send client a message
void SaveClient(object oPC);

//  Check for Traps being set in NO PvP area
void CheckForTraps(object oArea, object oPC);

//  Check if we have immortal gear and unequip it
void TakeOffCrown(object oItem, object oPC);


int GetIsGM(object oPC)
{
    string sCDKEY = GetPCPublicCDKey(oPC, TRUE);

    if (sCDKEY == "QR4JFL9A")
    {
        return TRUE;
    }

    else
        return FALSE;
}

int IsThiefNPC(object oThief)
{
    if (!GetIsObjectValid(oThief))
        return 0;

    return GetLocalInt(oThief, "NPCThief");
}

void PrintGPValue(object oItem)
{
    string sDescribe = GetDescription(oItem, TRUE, TRUE),
           sGoldValue = IntToString(GetGoldPieceValue(oItem));

    if (GetPlotFlag(oItem) == FALSE)
    {
        string sOutput = StringToRGBString("Gold Piece Value: ", "770") + sGoldValue;
        sOutput += "\n";
        sOutput += "\n";
        sOutput += sDescribe;
        SetDescription(oItem, sOutput, TRUE);
    }
}

void FixBarterExploit(object oFrom, object oPC)
{
    if (GetIsPC(oFrom) && GetIsPC(oPC))
    {
        ExportSingleCharacter(oFrom);
        SaveClient(oPC);
        ExecuteScript("ws_saveall_sub", oFrom);
        return;
    }
}

void SendMessageToFactionWithinDistance(object oPC, string sMessage, float fDist)
{
    object oFaction = GetFirstFactionMember(oPC), oArea = GetArea(oPC);
    while (GetIsObjectValid(oFaction))
    {
        if (GetArea(oFaction) == oArea && GetDistanceBetween(oPC, oFaction) <= fDist)
        {
            DelayCommand(0.3, FloatingTextStringOnCreature(sMessage, oFaction));
        }

        oFaction = GetNextFactionMember(oPC);
    }
}

void LootMessage(string sItem, string sPlayer, object oFrom, object oPC)
{
    if (sItem == "")
    {
         SendMessageToFactionWithinDistance(oPC, StringToRGBString(sPlayer, "777")
         + " accquired "
         + StringToRGBString("Gold Pieces", "777"), 25.0);
         return;
    }
    else
    {
        if (oFrom == OBJECT_INVALID) return;

        SendMessageToFactionWithinDistance(oPC, StringToRGBString(sPlayer, "777")
        + " accquired "
        + StringToRGBString(sItem, "777"), 25.0);
    }
}

void ApplyPenalty(object oDead)
{
    int nXP = GetXP(oDead);
    int nPenalty = 75 * GetHitDice(oDead);
    int nHD = GetHitDice(oDead);
    // * You can not lose a level with this respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
        nNewXP = nMin;
    SetXP(oDead, nNewXP);
    int nGoldToTake = FloatToInt(0.15 * GetGold(oDead));
    // * a cap of 10 000gp taken from you
    /*if (nGoldToTake > 1000000)
    {
        nGoldToTake = 1000000;
    }
    */

    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));

    if (GetXP(oDead) < 2)
    {
        SetXP(oDead, 2);
    }
}

void PurgeItem(object oPC, object oItem, string s)
{
    if (GetTag(oItem) == s)
    {
        GiveGoldToCreature(oPC, GetGoldPieceValue(oItem));
        DestroyObject(oItem);
        SendMessageToPC(oPC, GetName(oItem) + " has been purged.  Refund given.");
    }
}

void RemoveAllEffects(object oCreature)
{
    effect eCurrentEffect = GetFirstEffect(oCreature);
    while (GetIsEffectValid(eCurrentEffect))
    {
        RemoveEffect(oCreature, eCurrentEffect);
        eCurrentEffect = GetNextEffect(oCreature);
    }
}

int VerifyDM(object oPC)
{
    string sName = GetName(oPC);
    string sAccount = GetPCPlayerName(oPC);
    string sCDKey = GetPCPublicCDKey(oPC);
    string sIP = GetPCIPAddress(oPC);

    if (GetIsDM(oPC))
    {
        if (GetIsGM(oPC))
        {
            SendMessageToAllDMs("Entering DM's CD Key "+ StringToRGBString("VERIFIED:", "070")
            + "\nName: " + StringToRGBString(sName, "777")
            + "\nAccount: " + StringToRGBString(sAccount, "777")
            + "\nKey: " + StringToRGBString(sCDKey, "777")
            + "\nIP: " + StringToRGBString(sIP, "777"));

            ModMiscWebhook("DM VERIFIED - Player: " + sName + " Account: " + sAccount + " - Key: " + sCDKey + " IP: " + sIP);
            return FALSE;
        }

        else
        {
            SendMessageToAllDMs("Entering DM's CD Key " + StringToRGBString("DENIED:", "700")
            + "\nName: " + StringToRGBString(sName, "777")
            + "\nAccount: " + StringToRGBString(sAccount, "777")
            + "\nKey: " + StringToRGBString(sCDKey, "777")
            + "\nIP: " + StringToRGBString(sIP, "777"));

            ModMiscWebhook("DM DENIED - Player: " + sName + " Account: " + sAccount + " - Key: " + sCDKey + " IP: " + sIP);

            BootPC(oPC, "DM Entry Denied");
            return TRUE;
        }
    }

    else if (GetIsPC(oPC))
        return FALSE;

    else
        return FALSE;
}

void StripPC(object oPC)
{
    object oItem = GetFirstItemInInventory(oPC);
    object oValid = GetItemPossessedBy(oPC, "itm_teleport");

    while (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oPC);
    }

    ClearAllActions(FALSE);
    AssignCommand(oPC, TakeGoldFromCreature(GetGold(oPC), oPC, TRUE));
}

void HitPointsAntiCheatOnEnter(object oPC)
{
    object oModule = GetModule();
    string sID = GetName(oPC) + "_" + IntToString(GetXP(oPC));

    if (GetLocalInt(oModule, "PC_LOGGED_" + sID))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetMaxHitPoints(oPC) - GetLocalInt(oModule, "PC_HP_" + sID), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY), oPC);
    }
}


void HitPointsAntiCheatOnExit(object oPC)
{
    object oModule = GetModule();
    string sID = GetName(oPC) + "_" + IntToString(GetXP(oPC));

    SetLocalInt(oModule, "PC_LOGGED_" + sID, TRUE);
    SetLocalInt(oModule, "PC_HP_" + sID, GetCurrentHitPoints(oPC));
}

void DeathLog(object oPC)
{
    if (GetIsInCombat(oPC))
    {
        SpeakString(StringToRGBString("AUTOKILLED\n", "700")
        + StringToRGBString(GetName(oPC), "777")
        + "\nLogging out in combat.", TALKVOLUME_SHOUT);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oPC) + 20, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY), oPC);
    }
}

void DrowCorpseLoot(object oPC)
{
    DestroyObject(GetItemInSlot(Random(13), oPC));
    AssignCommand(oPC, TakeGoldFromCreature(GetGold(oPC) / 15, oPC, TRUE));
}

void BootAllPC(object oPC)
{
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC) == TRUE)
    {
        BootPC(oPC, "SERVER RESET. You may log back in now.");
        oPC = GetNextPC();
    }
}

void Raise(object oPlayer)
{
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION),
           eBad = GetFirstEffect(oPlayer);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPlayer);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);
    //ApplyHaste(oPlayer);

    //Search for negative effects
    while (GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
        {
            //Remove effect if it is negative.
            RemoveEffect(oPlayer, eBad);
        }
        eBad = GetNextEffect(oPlayer);
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oPlayer, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
}

void SetFactionsFriendly(object oPlayer)
{
    // * make friendly to Each of the 3 common factions
    AssignCommand(oPlayer, ClearAllActions());

    // * Note: waiting for Sophia to make SetStandardFactionReptuation to clear all personal reputation
    if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPlayer) <= 10)
    {
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPlayer);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPlayer) <= 10)
    {
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPlayer);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPlayer) <= 10)
    {
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPlayer);
    }
}

void SaveClient(object oPC)
{
    ExportSingleCharacter(oPC);
    FloatingTextStringOnCreature(StringToRGBString("Character Saved", "777"), oPC, FALSE);
    ExecuteScript("ws_saveall_sub", oPC);
}

void CheckForTraps(object oArea, object oPC)
{
    object oTrap = GetNearestTrapToObject(oPC, FALSE);

    if (GetIsObjectValid(oTrap) && GetTrapCreator(oTrap) == oPC)
    {
        SetTrapActive(oTrap, FALSE);
        SetTrapDetectable(oTrap, FALSE);
        SetTrapDetectDC(oTrap, 0);
        SetTrapDisabled(oTrap);
        SetTrapDisarmable(oTrap, TRUE);
        SetTrapDisarmDC(oTrap, 0);
        SetTrapRecoverable(oTrap, TRUE);

        ModMiscWebhook("Player: " + GetName(oPC) +
                        " - Account: " + GetPCPlayerName(oPC) +
                        " - CDKEY: " + GetPCPublicCDKey(oPC, TRUE) +
                        " has set a trap in NO PVP area!");

        SpeakString("Player: " + StringToRGBString(GetName(oPC), "777")
        + "\n- Account: " + StringToRGBString(GetPCPlayerName(oPC), "777")
        + "\n- CDKEY: " + StringToRGBString(GetPCPublicCDKey(oPC, TRUE), "777")
        + StringToRGBString("\nhas set a trap in NO PVP area!", "700"), TALKVOLUME_SHOUT);

        ClearAllActions(FALSE);
    }
}

void TakeOffCrown(object oItem, object oPC)
{
   object oDagger = GetItemPossessedBy(oPC, "immortaldagger1");
   object target = (GetNearestObject(OBJECT_TYPE_CREATURE, oPC, 1));
   object target2 = (GetNearestObject(OBJECT_TYPE_CREATURE, oPC, 2));
   object target3 = (GetNearestObject(OBJECT_TYPE_CREATURE, oPC, 3));
   object target4 = (GetNearestObject(OBJECT_TYPE_CREATURE, oPC, 4));
   effect eBeam = EffectBeam(VFX_BEAM_EVIL, oPC, BODY_NODE_CHEST);
   effect eDamage = EffectDamage(60 + d20(5), DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL);

   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, target, 2.0f);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, target2, 2.0f);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, target3, 2.0f);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, target4, 2.0f);

   ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, target);
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, target2);
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, target3);
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, target4);

   if (GetIsObjectValid(oItem))
      AssignCommand(oPC, ActionUnequipItem(oItem));

   if (GetIsObjectValid(oDagger))
   {
      AssignCommand(oPC, ActionUnequipItem(oDagger));
      AssignCommand(oPC, DestroyObject(oDagger));
   }

   oDagger = GetItemPossessedBy(oPC, "immortaldagger2");

   if (GetIsObjectValid(oDagger))
   {
      AssignCommand(oPC, ActionUnequipItem(oDagger));
      AssignCommand(oPC, DestroyObject(oDagger));
   }
}


//void main(){}
