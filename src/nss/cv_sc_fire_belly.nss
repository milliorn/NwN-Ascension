//:://////////////////////////////////////////////
//:: Created By: Scott Milliorn
//:: Created On: 2020-04-014
//:://////////////////////////////////////////////
//::///////////////////////////////////////////////
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/13/2002 12:14:41 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    return GetItemPossessedBy(GetPCSpeaker(), "NW_IT_MSMLMISC08") != OBJECT_INVALID;
}
