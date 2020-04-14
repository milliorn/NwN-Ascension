//:://////////////////////////////////////////////
//:: Created By: Scott Milliorn
//:: Created On: 2020-04-03
//  Modified by AW Olorin 1-12-2004
//  Anti-GS Looting

void RespawnObject(string sTag, int iType, location lLoc)
{

    // ResRef must be derivable from Tag
    string sResRef = GetStringLowerCase(GetStringLeft(sTag, 16));

    CreateObject(iType, sResRef, lLoc);
}

void main()
{
    SetPlotFlag(OBJECT_SELF, FALSE);
    float fDelay2 = 0.0;
    DestroyObject(OBJECT_SELF, fDelay2);
    string sTag = GetTag(OBJECT_SELF);
    int iType = GetObjectType(OBJECT_SELF);
    object oLastOpener = GetLastOpenedBy();

    // For creatures, save the location at spawn-time as a local location and
    // use it instead. Otherwise, the creature will respawn where it died.
    location lLoc = GetLocation(OBJECT_SELF);

    float fDelay = 1800.0; // 1000 second delay

    AssignCommand(GetArea(OBJECT_SELF), DelayCommand(fDelay, RespawnObject(sTag, iType, lLoc)));
}

