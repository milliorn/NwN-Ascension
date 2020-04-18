//:://////////////////////////////////////////////
//::
//:: Created By: Scott Milliorn
//:: Created On: 2020-04-17
//::
//::///////////////////////////////////////////////
//:: FileName weapshop
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/11/2002 5:36:05 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "NW_WSWMLS013");
    object oStore = GetNearestObjectByTag("lowweapons");

    if (GetIsObjectValid(oItem) != 0)
    {
        DestroyObject(oItem);
    }

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore, oPC);
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
