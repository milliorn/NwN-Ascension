//::///////////////////////////////////////////////
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Scott Milliorn
//:: Created On: 2020-04-24
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetLastUsedBy();
    int iGold = GetGold(oPC);
    int iSlot = GetLocalInt(OBJECT_SELF, "iSlot");
    int iRoll = d100();

    if (iSlot > 0)
    {
        SendMessageToPC(oPC, "You must wait a moment to try again.");
        return;
    }

    SetLocalInt(OBJECT_SELF, "iSlot", 1);
    DelayCommand(3.5, SetLocalInt(OBJECT_SELF, "iSlot", 0));

    if (iGold < 500)
    {
        SendMessageToPC(oPC, "You do not have enough gold to play this slot machine.");
        return;
    }

    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);

    AssignCommand(oPC, TakeGoldFromCreature(500, oPC, TRUE));

    if (iRoll == 1)
    {
        if (d10() == 1)
        {
            DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oPC));
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won The Jackpot!!!"));
            CreateItemOnObject("nw_it_gem014", oPC, 1);
            CreateItemOnObject("nw_it_gem004", oPC, 1);
            CreateItemOnObject("nw_it_gem002", oPC, 1);
            CreateItemOnObject("nw_it_gem007", oPC, 1);
            CreateItemOnObject("nw_it_gem001", oPC, 1);
            CreateItemOnObject("brillianttopaz", oPC, 1);
            CreateItemOnObject("nw_it_gem011", oPC, 1);
            CreateItemOnObject("nw_it_gem015", oPC, 1);
            CreateItemOnObject("nw_it_gem003", oPC, 1);
            CreateItemOnObject("nw_it_gem013", oPC, 1);
            CreateItemOnObject("brilliantruby", oPC, 1);
            CreateItemOnObject("nw_it_gem005", oPC, 1);
            CreateItemOnObject("nw_it_gem008", oPC, 1);
            CreateItemOnObject("nw_it_gem010", oPC, 1);
            CreateItemOnObject("nw_it_gem006", oPC, 1);
            CreateItemOnObject("nw_it_gem012", oPC, 1);
            CreateItemOnObject("brilliantruby001", oPC, 1);
            return;
        }
        else
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Brilliant Ruby!!!"));
            CreateItemOnObject("brilliantruby", oPC, 1);
            return;
        }
    }
    else if (iRoll >= 2 && iRoll <= 18)
    {
        DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_HOLY_10), oPC));

        if (iRoll == 2)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won an Adventurine!"));
            CreateItemOnObject("nw_it_gem014", oPC, 1);
            return;
        }
        if (iRoll == 3)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Phenalope!"));
            CreateItemOnObject("nw_it_gem004", oPC, 1);
            return;
        }
        if (iRoll == 4)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Fire Agate!"));
            CreateItemOnObject("nw_it_gem002", oPC, 1);
            return;
        }
        if (iRoll == 5)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Malachite!"));
            CreateItemOnObject("nw_it_gem007", oPC, 1);
            return;
        }
        if (iRoll == 6)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Greenstone!"));
            CreateItemOnObject("nw_it_gem001", oPC, 1);
            return;
        }
        if (iRoll == 8)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won an Alexandrite!"));
            CreateItemOnObject("nw_it_gem013", oPC, 1);
            return;
        }
        if (iRoll == 9)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won an Amethyst!"));
            CreateItemOnObject("nw_it_gem003", oPC, 1);
            return;
        }
        if (iRoll == 10)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Flourospar!"));
            CreateItemOnObject("nw_it_gem015", oPC, 1);
            return;
        }
        if (iRoll == 11)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Garnet!"));
            CreateItemOnObject("nw_it_gem011", oPC, 1);
            return;
        }
        if (iRoll == 12)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Brilliant Ruby!"));
            CreateItemOnObject("brilliantruby", oPC, 1);
            return;
        }
        if (iRoll == 13)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Diamond!"));
            CreateItemOnObject("nw_it_gem005", oPC, 1);
            return;
        }
        if (iRoll == 14)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Saphire!"));
            CreateItemOnObject("nw_it_gem008", oPC, 1);
            return;
        }
        if (iRoll == 15)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Topaz!"));
            CreateItemOnObject("nw_it_gem010", oPC, 1);
            return;
        }
        if (iRoll == 16)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Brilliant Emerald!"));
            CreateItemOnObject("brilliantruby001", oPC, 1);
            return;
        }
        if (iRoll == 17)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won an Emerald!"));
            CreateItemOnObject("nw_it_gem012", oPC, 1);
            return;
        }
        if (iRoll == 18)
        {
            DelayCommand(3.0, SendMessageToPC(oPC, "You have won a Ruby!"));
            CreateItemOnObject("nw_it_gem006", oPC, 1);
            return;
        }
    }
    else
    {
        DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_10), oPC));
        DelayCommand(3.0, SendMessageToPC(oPC, "You have won nothing, please try again."));
    }
}

