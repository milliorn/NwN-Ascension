//::///////////////////////////////////////////////
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Scott Milliorn
//:: Created On: 2020-04-29
//::///////////////////////////////////////////////
//:://////////////////////////////////////////////////
//::///////////////////////////////////////////////
//:: FileName rareshop
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/11/2002 6:29:12 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    object o11 = GetItemPossessedBy(oPC, "NW_WSWMLS013");
    object oStore = GetNearestObjectByTag("rareitems002");

    if (GetIsObjectValid(o11) != 0)
    {
        DestroyObject(o11);
    }

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore, oPC);
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
