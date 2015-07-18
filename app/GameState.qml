import QtQuick 2.4
import Qt.labs.settings 1.0
import Ubuntu.Components 1.2


Settings {
    property string book
    property string pageId

    property int endurance
    property int maxendurance
    property int combatskill
    property int gold
    property int meals
    property int quiver

    property string notes

    property string kaiskill1
    property string kaiskill2
    property string kaiskill3
    property string kaiskill4
    property string kaiskill5
    property string kaiskill6
    property string kaiskill7
    property string kaiskill8
    property string kaiskill9
    property string kaiskill10

    property string magnakaiskill1
    property string magnakaiskill2
    property string magnakaiskill3
    property string magnakaiskill4
    property string magnakaiskill5
    property string magnakaiskill6
    property string magnakaiskill7
    property string magnakaiskill8
    property string magnakaiskill9
    property string magnakaiskill10

    property bool weaponmastery_spear
    property bool weaponmastery_dagger
    property bool weaponmastery_mace
    property bool weaponmastery_shortsword
    property bool weaponmastery_warhammer
    property bool weaponmastery_bow
    property bool weaponmastery_axe
    property bool weaponmastery_sword
    property bool weaponmastery_quarterstaff
    property bool weaponmastery_broadsword

    property string weapon1
    property string weapon2

    property string backpack1
    property string backpack2
    property string backpack3
    property string backpack4
    property string backpack5
    property string backpack6
    property string backpack7
    property string backpack8

    property string special1
    property string special2
    property string special3
    property string special4
    property string special5
    property string special6
    property string special7
    property string special8
    property string special9
    property string special10
    property string special11
    property string special12

    function copyTo(other) {
        other.book = book;
        other.pageId = pageId;
        other.endurance = endurance;
        other.maxendurance = maxendurance;
        other.combatskill = combatskill;
        other.gold = gold;
        other.meals = meals;
        other.quiver = quiver;
        other.notes = notes;

        other.kaiskill1 = kaiskill1;
        other.kaiskill2 = kaiskill2;
        other.kaiskill3 = kaiskill3;
        other.kaiskill4 = kaiskill4;
        other.kaiskill5 = kaiskill5;
        other.kaiskill6 = kaiskill6;
        other.kaiskill7 = kaiskill7;
        other.kaiskill8 = kaiskill8;
        other.kaiskill9 = kaiskill9;
        other.kaiskill10 = kaiskill10;

        other.magnakaiskill1 = magnakaiskill1;
        other.magnakaiskill2 = magnakaiskill2;
        other.magnakaiskill3 = magnakaiskill3;
        other.magnakaiskill4 = magnakaiskill4;
        other.magnakaiskill5 = magnakaiskill5;
        other.magnakaiskill6 = magnakaiskill6;
        other.magnakaiskill7 = magnakaiskill7;
        other.magnakaiskill8 = magnakaiskill8;
        other.magnakaiskill9 = magnakaiskill9;
        other.magnakaiskill10 = magnakaiskill10;

        other.weaponmastery_spear = weaponmastery_spear;
        other.weaponmastery_dagger = weaponmastery_dagger;
        other.weaponmastery_mace = weaponmastery_mace;
        other.weaponmastery_shortsword = weaponmastery_shortsword;
        other.weaponmastery_warhammer = weaponmastery_warhammer;
        other.weaponmastery_bow = weaponmastery_bow;
        other.weaponmastery_axe = weaponmastery_axe;
        other.weaponmastery_sword = weaponmastery_sword;
        other.weaponmastery_quarterstaff = weaponmastery_quarterstaff;
        other.weaponmastery_broadsword = weaponmastery_broadsword;

        other.weapon1 = weapon1;
        other.weapon2 = weapon2;

        other.backpack1 = backpack1;
        other.backpack2 = backpack2;
        other.backpack3 = backpack3;
        other.backpack4 = backpack4;
        other.backpack5 = backpack5;
        other.backpack6 = backpack6;
        other.backpack7 = backpack7;
        other.backpack8 = backpack8;

        other.special1 = special1;
        other.special2 = special2;
        other.special3 = special3;
        other.special4 = special4;
        other.special5 = special5;
        other.special6 = special6;
        other.special7 = special7;
        other.special8 = special8;
        other.special9 = special9;
        other.special10 = special10;
        other.special11 = special11;
        other.special12 = special12;
    }
}
