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

    property bool kai_camouflage
    property bool kai_hunting
    property bool kai_sixthsense
    property bool kai_tracking
    property bool kai_healing
    property bool kai_weaponskill
    property bool kai_mindshield
    property bool kai_mindblast
    property bool kai_animalkinship
    property bool kai_mindovermatter

    property bool magnakai_weaponmastery
    property bool magnakai_animalcontrol
    property bool magnakai_curing
    property bool magnakai_invisibility
    property bool magnakai_huntmastery
    property bool magnakai_pathsmanship
    property bool magnakai_psisurge
    property bool magnakai_psiscreen
    property bool magnakai_nexus
    property bool magnakai_divination

    property bool grandmaster_grandweaponmastery
    property bool grandmaster_animalmastery
    property bool grandmaster_deliverance
    property bool grandmaster_assimilance
    property bool grandmaster_grandhuntmastery
    property bool grandmaster_grandpathsmanship
    property bool grandmaster_kaisurge
    property bool grandmaster_kaiscreen
    property bool grandmaster_grandnexus
    property bool grandmaster_telegnosis
    property bool grandmaster_magimagic
    property bool grandmaster_kaialchemy

    property string weaponskill_weapon

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

    property bool grandweaponmastery_spear
    property bool grandweaponmastery_dagger
    property bool grandweaponmastery_mace
    property bool grandweaponmastery_shortsword
    property bool grandweaponmastery_warhammer
    property bool grandweaponmastery_bow
    property bool grandweaponmastery_axe
    property bool grandweaponmastery_sword
    property bool grandweaponmastery_quarterstaff
    property bool grandweaponmastery_broadsword

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
    property string backpack9
    property string backpack10

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

        other.kai_camouflage = kai_camouflage;
        other.kai_hunting = kai_hunting;
        other.kai_sixthsense = kai_sixthsense;
        other.kai_tracking = kai_tracking;
        other.kai_healing = kai_healing;
        other.kai_weaponskill = kai_weaponskill;
        other.kai_mindshield = kai_mindshield;
        other.kai_mindblast = kai_mindblast;
        other.kai_animalkinship = kai_animalkinship;
        other.kai_mindovermatter = kai_mindovermatter;

        other.magnakai_weaponmastery = magnakai_weaponmastery;
        other.magnakai_animalcontrol = magnakai_animalcontrol;
        other.magnakai_curing = magnakai_curing;
        other.magnakai_invisibility = magnakai_invisibility;
        other.magnakai_huntmastery = magnakai_huntmastery;
        other.magnakai_pathsmanship = magnakai_pathsmanship;
        other.magnakai_psisurge = magnakai_psisurge;
        other.magnakai_psiscreen = magnakai_psiscreen;
        other.magnakai_nexus = magnakai_nexus;
        other.magnakai_divination = magnakai_divination;

        other.grandmaster_grandweaponmastery = grandmaster_grandweaponmastery;
        other.grandmaster_animalmastery = grandmaster_animalmastery;
        other.grandmaster_deliverance = grandmaster_deliverance;
        other.grandmaster_assimilance = grandmaster_assimilance;
        other.grandmaster_grandhuntmastery = grandmaster_grandhuntmastery;
        other.grandmaster_grandpathsmanship = grandmaster_grandpathsmanship;
        other.grandmaster_kaisurge = grandmaster_kaisurge;
        other.grandmaster_kaiscreen = grandmaster_kaiscreen;
        other.grandmaster_grandnexus = grandmaster_grandnexus;
        other.grandmaster_telegnosis = grandmaster_telegnosis;
        other.grandmaster_magimagic = grandmaster_magimagic;
        other.grandmaster_kaialchemy = grandmaster_kaialchemy;

        other.weaponskill_weapon = weaponskill_weapon;

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

        other.grandweaponmastery_spear = grandweaponmastery_spear;
        other.grandweaponmastery_dagger = grandweaponmastery_dagger;
        other.grandweaponmastery_mace = grandweaponmastery_mace;
        other.grandweaponmastery_shortsword = grandweaponmastery_shortsword;
        other.grandweaponmastery_warhammer = grandweaponmastery_warhammer;
        other.grandweaponmastery_bow = grandweaponmastery_bow;
        other.grandweaponmastery_axe = grandweaponmastery_axe;
        other.grandweaponmastery_sword = grandweaponmastery_sword;
        other.grandweaponmastery_quarterstaff = grandweaponmastery_quarterstaff;
        other.grandweaponmastery_broadsword = grandweaponmastery_broadsword;

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
        other.backpack9 = backpack9;
        other.backpack10 = backpack10;

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
