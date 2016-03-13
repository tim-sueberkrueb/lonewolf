import QtQuick 2.4
import Qt.labs.settings 1.0
import Ubuntu.Components 1.3


Settings {
    property string book
    property string pageId

    property int endurance
    property int maxendurance
    property int combatskill
    property int gold
    property int meals
    property int quiver

    property int neworder_endurance
    property int neworder_maxendurance
    property int neworder_combatskill
    property int neworder_gold
    property int neworder_meals
    property int neworder_quiver

    property string notes
    property string neworder_notes

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

    property bool neworder_grandweaponmastery
    property bool neworder_animalmastery
    property bool neworder_deliverance
    property bool neworder_assimilance
    property bool neworder_grandhuntmastery
    property bool neworder_grandpathsmanship
    property bool neworder_kaisurge
    property bool neworder_kaiscreen
    property bool neworder_grandnexus
    property bool neworder_telegnosis
    property bool neworder_magimagic
    property bool neworder_kaialchemy
    property bool neworder_astrology
    property bool neworder_herbmastery
    property bool neworder_elementalism
    property bool neworder_bardsmanship

    property string weaponskill_weapon

    property string neworder_kaiweapon

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

    property bool neworder_grandweaponmastery_spear
    property bool neworder_grandweaponmastery_dagger
    property bool neworder_grandweaponmastery_mace
    property bool neworder_grandweaponmastery_shortsword
    property bool neworder_grandweaponmastery_warhammer
    property bool neworder_grandweaponmastery_bow
    property bool neworder_grandweaponmastery_axe
    property bool neworder_grandweaponmastery_sword
    property bool neworder_grandweaponmastery_quarterstaff
    property bool neworder_grandweaponmastery_broadsword

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

    property string neworder_weapon1
    property string neworder_weapon2

    property string neworder_backpack1
    property string neworder_backpack2
    property string neworder_backpack3
    property string neworder_backpack4
    property string neworder_backpack5
    property string neworder_backpack6
    property string neworder_backpack7
    property string neworder_backpack8
    property string neworder_backpack9
    property string neworder_backpack10

    property string neworder_special1
    property string neworder_special2
    property string neworder_special3
    property string neworder_special4
    property string neworder_special5
    property string neworder_special6
    property string neworder_special7
    property string neworder_special8
    property string neworder_special9
    property string neworder_special10
    property string neworder_special11
    property string neworder_special12

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

        other.neworder_endurance = neworder_endurance;
        other.neworder_maxendurance = neworder_maxendurance;
        other.neworder_combatskill = neworder_combatskill;
        other.neworder_gold = neworder_gold;
        other.neworder_meals = neworder_meals;
        other.neworder_quiver = neworder_quiver;
        other.neworder_notes = neworder_notes;

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

        other.neworder_grandweaponmastery = neworder_grandweaponmastery;
        other.neworder_animalmastery = neworder_animalmastery;
        other.neworder_deliverance = neworder_deliverance;
        other.neworder_assimilance = neworder_assimilance;
        other.neworder_grandhuntmastery = neworder_grandhuntmastery;
        other.neworder_grandpathsmanship = neworder_grandpathsmanship;
        other.neworder_kaisurge = neworder_kaisurge;
        other.neworder_kaiscreen = neworder_kaiscreen;
        other.neworder_grandnexus = neworder_grandnexus;
        other.neworder_telegnosis = neworder_telegnosis;
        other.neworder_magimagic = neworder_magimagic;
        other.neworder_kaialchemy = neworder_kaialchemy;
        other.neworder_astrology = neworder_astrology;
        other.neworder_herbmastery = neworder_herbmastery;
        other.neworder_elementalism = neworder_elementalism;
        other.neworder_bardsmanship = neworder_bardsmanship;

        other.neworder_kaiweapon = neworder_kaiweapon;

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

        other.neworder_grandweaponmastery_spear = neworder_grandweaponmastery_spear;
        other.neworder_grandweaponmastery_dagger = neworder_grandweaponmastery_dagger;
        other.neworder_grandweaponmastery_mace = neworder_grandweaponmastery_mace;
        other.neworder_grandweaponmastery_shortsword = neworder_grandweaponmastery_shortsword;
        other.neworder_grandweaponmastery_warhammer = neworder_grandweaponmastery_warhammer;
        other.neworder_grandweaponmastery_bow = neworder_grandweaponmastery_bow;
        other.neworder_grandweaponmastery_axe = neworder_grandweaponmastery_axe;
        other.neworder_grandweaponmastery_sword = neworder_grandweaponmastery_sword;
        other.neworder_grandweaponmastery_quarterstaff = neworder_grandweaponmastery_quarterstaff;
        other.neworder_grandweaponmastery_broadsword = neworder_grandweaponmastery_broadsword;

        other.weapon1 = weapon1;
        other.weapon2 = weapon2;
        other.neworder_weapon1 = neworder_weapon1;
        other.neworder_weapon2 = neworder_weapon2;

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
        other.neworder_backpack1 = neworder_backpack1;
        other.neworder_backpack2 = neworder_backpack2;
        other.neworder_backpack3 = neworder_backpack3;
        other.neworder_backpack4 = neworder_backpack4;
        other.neworder_backpack5 = neworder_backpack5;
        other.neworder_backpack6 = neworder_backpack6;
        other.neworder_backpack7 = neworder_backpack7;
        other.neworder_backpack8 = neworder_backpack8;
        other.neworder_backpack9 = neworder_backpack9;
        other.neworder_backpack10 = neworder_backpack10;

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
        other.neworder_special1 = neworder_special1;
        other.neworder_special2 = neworder_special2;
        other.neworder_special3 = neworder_special3;
        other.neworder_special4 = neworder_special4;
        other.neworder_special5 = neworder_special5;
        other.neworder_special6 = neworder_special6;
        other.neworder_special7 = neworder_special7;
        other.neworder_special8 = neworder_special8;
        other.neworder_special9 = neworder_special9;
        other.neworder_special10 = neworder_special10;
        other.neworder_special11 = neworder_special11;
        other.neworder_special12 = neworder_special12;
    }
}
