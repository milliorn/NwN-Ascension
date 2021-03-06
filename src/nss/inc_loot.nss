//  Common Loot Generator Script
//  Created By: Scott Milliorn
//  Module - A Carpathian Nightmare & Ascension
//  Date: June 13th, 2018

//  Additional help with donation of code from Dorrian of Trials of Newcastle

//  If any code is used from this script please give credit to both -
//  Milliorn of A Carpathian Nightmare
//  Dorrian of Trials of Newcastle

#include "x2_inc_itemprop"

//  Custom Code to generate common equippable loot and to randomize Item Properties
void GenerateRandomLoot();

//  Custom Color Armor
void ColorArmor(object oItem);

//  Custom Code to make random weapon appearances.
void ChangeApprWeapon(object oItem, int iBottom, int iMiddle, int iTop);


void ColorArmor(object oItem)
{
    object oCopyBox = IPGetIPWorkContainer();

    object oCopy = CopyItem(oItem, oCopyBox, TRUE);
    DestroyObject(oItem); // remove old item
    object oCopy1 = CopyItemAndModify(oCopy, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH1, Random(175), TRUE);
    DestroyObject(oCopy); // remove old item
    object oCopy2 = CopyItemAndModify(oCopy1, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2, Random(175), TRUE);
    DestroyObject(oCopy1); // remove old item
    object oCopy3 = CopyItemAndModify(oCopy2, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER1, Random(175), TRUE);
    DestroyObject(oCopy2); // remove old item
    object oCopy4 = CopyItemAndModify(oCopy3, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER2, Random(175), TRUE);
    DestroyObject(oCopy3); // remove old item
    object oCopy5 = CopyItemAndModify(oCopy4, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL1, Random(175), TRUE);
    DestroyObject(oCopy4); // remove old item
    object oCopy6 = CopyItemAndModify(oCopy5, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL2, Random(175), TRUE);
    DestroyObject(oCopy5); // remove old item
    object oCopy7 = CopyItem(oCopy6, OBJECT_SELF, TRUE);
    DestroyObject(oCopy6); // remove old item
}

void ChangeApprWeapon(object oItem, int iBottom, int iMiddle, int iTop)
{
    object oCopyBox = IPGetIPWorkContainer();

    object oCopy = CopyItem(oItem, oCopyBox, TRUE);
    DestroyObject(oItem); // remove old item
    object oCopy1 = CopyItemAndModify(oCopy, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_BOTTOM, iBottom, TRUE);
    DestroyObject(oCopy); // remove old item
    object oCopy2 = CopyItemAndModify(oCopy1, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_MIDDLE, iMiddle, TRUE);
    DestroyObject(oCopy1); // remove old item
    object oCopy3 = CopyItemAndModify(oCopy2, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_TOP, iTop, TRUE);
    DestroyObject(oCopy2); // remove old item

    object oCopy4 = CopyItemAndModify(oCopy3, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_BOTTOM, d4(), TRUE);
    DestroyObject(oCopy3); // remove old item
    object oCopy5 = CopyItemAndModify(oCopy4, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_MIDDLE, d4(), TRUE);
    DestroyObject(oCopy4); // remove old item
    object oCopy6 = CopyItemAndModify(oCopy5, ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_TOP, d4(), TRUE);
    DestroyObject(oCopy5); // remove old item
    object oCopy7 = CopyItem(oCopy6, OBJECT_SELF, TRUE);
    DestroyObject(oCopy6); // remove old item
}

void GenerateRandomLoot()
{
    // Vars
    object oPC = OBJECT_SELF,
           oChest,
           oItem,
           oCopy,
           oCopyBox = IPGetIPWorkContainer();

    int iRoll = d100(),
        nCount = GetLocalInt(oChest, "GenerateRandomLootTreature"),
        nPick;

    switch (iRoll)
    {
    case 1:
        oChest = GetObjectByTag("LOOT_AMMO_ARROWS");
        break;
    case 2:
        oChest = GetObjectByTag("LOOT_AMMO_BOLTS");
        break;
    case 3:
        oChest = GetObjectByTag("LOOT_AMMO_BULLETS");
        break;
    case 4:
        oChest = GetObjectByTag("LOOT_AMMO_CLOTHING");
        break;
    case 5:
        oChest = GetObjectByTag("LOOT_AMMO_HEAVY");
        break;
    case 6:
        oChest = GetObjectByTag("LOOT_AMMO_HELMET");
        break;
    case 7:
        oChest = GetObjectByTag("LOOT_ARMOR_LIGHT");
        break;
    case 8:
        oChest = GetObjectByTag("LOOT_ARMOR_MEDIUM");
        break;
    case 9:
        oChest = GetObjectByTag("LOOT_ARMOR_NPC_CLOTHING");
        break;
    case 10:
        oChest = GetObjectByTag("LOOT_AXES_GREAT");
        break;

    case 11:
        oChest = GetObjectByTag("LOOT_AXES_ONE");
        break;
    case 12:
        oChest = GetObjectByTag("LOOT_AXES_TWO");
        break;
    case 13:
        oChest = GetObjectByTag("LOOT_BLADED_BASTARD");
        break;
    case 14:
        oChest = GetObjectByTag("LOOT_BLADED_DAGGERS");
        break;
    case 15:
        oChest = GetObjectByTag("LOOT_BLADED_GREAT");
        break;
    case 16:
        oChest = GetObjectByTag("LOOT_BLADED_LONGSWORD");
        break;
    case 17:
        oChest = GetObjectByTag("LOOT_BLADED_OTHER");
        break;
    case 18:
        oChest = GetObjectByTag("LOOT_BLADED_SHORT");
        break;
    case 19:
        oChest = GetObjectByTag("LOOT_BLUNTS_CLUBS");
        break;
    case 20:
        oChest = GetObjectByTag("LOOT_BLUNTS_FLAILS");
        break;

    case 21:
        oChest = GetObjectByTag("LOOT_BLUNTS_HAMMERS");
        break;
    case 22:
        oChest = GetObjectByTag("LOOT_BLUNTS_MACES");
        break;
    case 23:
        oChest = GetObjectByTag("LOOT_BLUNTS_MORNINGSTARS");
        break;
    case 24:
        oChest = GetObjectByTag("LOOT_BOOKS");
        break;
    case 25:
        oChest = GetObjectByTag("LOOT_BOOTS");
        break;
    case 26:
        oChest = GetObjectByTag("LOOT_BRACERS");
        break;
    case 27:
        oChest = GetObjectByTag("LOOT_CLOAKS");
        break;
    case 28:
        oChest = GetObjectByTag("LOOT_DOUBLE_SIDED");
        break;
    case 29:
        oChest = GetObjectByTag("LOOT_EXOTIC");
        break;
    case 30:
        oChest = GetObjectByTag("LOOT_GAUNTLET");
        break;

    case 31:
        oChest = GetObjectByTag("LOOT_GEMS");
        break;
    case 32:
        oChest = GetObjectByTag("LOOT_JEWELRY_AMULET");
        break;
    case 33:
        oChest = GetObjectByTag("LOOT_JEWELRY_RINGS");
        break;
    case 34:
        oChest = GetObjectByTag("LOOT_MAGE_SPECIFIC");
        break;
    case 35:
        oChest = GetObjectByTag("LOOT_POLEARMS");
        break;
    case 36:
        oChest = GetObjectByTag("LOOT_POTIONS");
        break;
    case 37:
        oChest = GetObjectByTag("LOOT_RANGED_CROSSBOWS");
        break;
    case 38:
        oChest = GetObjectByTag("LOOT_RANGED_LONGBOWS");
        break;
    case 39:
        oChest = GetObjectByTag("LOOT_RANGED_SHORTBOWS");
        break;
    case 40:
        oChest = GetObjectByTag("LOOT_SCROLLS");
        break;

    case 41:
        oChest = GetObjectByTag("LOOT_SHIELD_LARGE");
        break;
    case 42:
        oChest = GetObjectByTag("LOOT_SHIELD_SMALL");
        break;
    case 43:
        oChest = GetObjectByTag("LOOT_SHIELD_TOWER");
        break;
    case 44:
        oChest = GetObjectByTag("LOOT_THROWING");
        break;
    default:
        CreateItemOnObject("nw_it_gold001", oPC, d100(GetHitDice(OBJECT_SELF)));
        return;
    }

    //  Do a numeric count of all items in the placeables inventory
    if (!nCount)
    {
        oItem = GetFirstItemInInventory(oChest);
        do
        {
            nCount++;
            oItem = GetNextItemInInventory(oChest);
        } while (GetIsObjectValid(oItem));

        SetLocalInt(oChest, "GenerateRandomLootTreature", nCount);
    }

    //  After we do a count of the placeables inventory we select a random item to copy
    nPick = Random(nCount);
    oItem = GetFirstItemInInventory(oChest);
    while (nPick)
    {
        nPick--;
        oItem = GetNextItemInInventory(oChest);
    }

    switch (GetBaseItemType(oItem))
    {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_HELMET:
    {
        ColorArmor(oItem);
        return;
    }
    case BASE_ITEM_ARROW:
    case BASE_ITEM_DOUBLEAXE:
    case BASE_ITEM_TWOBLADEDSWORD:
    case BASE_ITEM_SCYTHE:
    {
        ChangeApprWeapon(oItem, d3(), d3(), d3());
        return;
    }

    case BASE_ITEM_BOLT:
    {
        ChangeApprWeapon(oItem, d3(), Random(4) + 1, d3());
        return;
    }
    case BASE_ITEM_GREATAXE:
    case BASE_ITEM_HANDAXE:
    case BASE_ITEM_KATANA:
    case BASE_ITEM_RAPIER:
    case BASE_ITEM_HEAVYFLAIL:
    case BASE_ITEM_LIGHTHAMMER:
    case BASE_ITEM_LIGHTMACE:
    case BASE_ITEM_MORNINGSTAR:
    case BASE_ITEM_DIREMACE:
    case BASE_ITEM_HALBERD:
    case BASE_ITEM_SHORTSPEAR:
    case BASE_ITEM_TRIDENT:
    case BASE_ITEM_HEAVYCROSSBOW:
    case BASE_ITEM_LIGHTCROSSBOW:
    case BASE_ITEM_THROWINGAXE:
    {
        ChangeApprWeapon(oItem, d4(), d4(), d4());
        return;
    }

    case BASE_ITEM_DWARVENWARAXE:
    case BASE_ITEM_BATTLEAXE:
    {
        ChangeApprWeapon(oItem, d8(), d6(), d6());
        return;
    }

    case BASE_ITEM_BASTARDSWORD:
    case BASE_ITEM_DAGGER:
    case BASE_ITEM_SHORTSWORD:
    case BASE_ITEM_CLUB:
    case BASE_ITEM_SHORTBOW:
    {
        ChangeApprWeapon(oItem, d6(), d6(), d6());
        return;
    }

    case BASE_ITEM_GREATSWORD:
    case BASE_ITEM_WARHAMMER:
    case BASE_ITEM_MAGICSTAFF:
    {
        ChangeApprWeapon(oItem, Random(6) + 1, Random(6) + 1, Random(6) + 1);
        return;
    }

    case BASE_ITEM_LONGSWORD:
    case BASE_ITEM_LONGBOW:
    {
        ChangeApprWeapon(oItem, d8(), d8(), d8());
        return;
    }

    case BASE_ITEM_SCIMITAR:
    case BASE_ITEM_LIGHTFLAIL:
    case BASE_ITEM_QUARTERSTAFF:
    {
        ChangeApprWeapon(oItem, Random(4) + 1, Random(4) + 1, Random(4) + 1);
        return;
    }

    default:
        oCopy = CopyItem(oItem, oPC, TRUE);
    }
}

/*void main () {}
