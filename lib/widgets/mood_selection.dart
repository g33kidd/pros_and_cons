import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

class MoodSelection extends StatefulWidget {
  final Function onChanged;

  MoodSelection({Key key, this.onChanged}) : super(key: key);

  @override
  _MoodSelectionState createState() => _MoodSelectionState();
}

class _MoodSelectionState extends State<MoodSelection> {
  Mood selectedMood;

  //   final Map<String, String> _smileys = new Map.fromIterables(
  //     ['Grinning Face', 'Grinning Face With Big Eyes', 'Grinning Face With Smiling Eyes', 'Beaming Face With Smiling Eyes', 'Grinning Squinting Face', 'Grinning Face With Sweat', 'Rolling on the Floor Laughing', 'Face With Tears of Joy', 'Slightly Smiling Face', 'Upside-Down Face', 'Winking Face', 'Smiling Face With Smiling Eyes', 'Smiling Face With Halo', 'Smiling Face With Hearts', 'Smiling Face With Heart-Eyes', 'Star-Struck', 'Face Blowing a Kiss', 'Kissing Face', 'Smiling Face', 'Kissing Face With Closed Eyes', 'Kissing Face With Smiling Eyes', 'Face Savoring Food', 'Face With Tongue', 'Winking Face With Tongue', 'Zany Face', 'Squinting Face With Tongue', 'Money-Mouth Face', 'Hugging Face', 'Face With Hand Over Mouth', 'Shushing Face', 'Thinking Face', 'Zipper-Mouth Face', 'Face With Raised Eyebrow', 'Neutral Face', 'Expressionless Face', 'Face Without Mouth', 'Smirking Face', 'Unamused Face', 'Face With Rolling Eyes', 'Grimacing Face', 'Lying Face', 'Relieved Face', 'Pensive Face', 'Sleepy Face', 'Drooling Face', 'Sleeping Face', 'Face With Medical Mask', 'Face With Thermometer', 'Face With Head-Bandage', 'Nauseated Face', 'Face Vomiting', 'Sneezing Face', 'Hot Face', 'Cold Face', 'Woozy Face', 'Dizzy Face', 'Exploding Head', 'Cowboy Hat Face', 'Partying Face', 'Smiling Face With Sunglasses', 'Nerd Face', 'Face With Monocle', 'Confused Face', 'Worried Face', 'Slightly Frowning Face', 'Frowning Face', 'Face With Open Mouth', 'Hushed Face', 'Astonished Face', 'Flushed Face', 'Pleading Face', 'Frowning Face With Open Mouth', 'Anguished Face', 'Fearful Face', 'Anxious Face With Sweat', 'Sad but Relieved Face', 'Crying Face', 'Loudly Crying Face', 'Face Screaming in Fear', 'Confounded Face', 'Persevering Face', 'Disappointed Face', 'Downcast Face With Sweat', 'Weary Face', 'Tired Face', 'Face With Steam From Nose', 'Pouting Face', 'Angry Face', 'Face With Symbols on Mouth', 'Smiling Face With Horns', 'Angry Face With Horns', 'Skull', 'Skull and Crossbones', 'Pile of Poo', 'Clown Face', 'Ogre', 'Goblin', 'Ghost', 'Alien', 'Alien Monster', 'Robot Face', 'Grinning Cat Face', 'Grinning Cat Face With Smiling Eyes', 'Cat Face With Tears of Joy', 'Smiling Cat Face With Heart-Eyes', 'Cat Face With Wry Smile', 'Kissing Cat Face', 'Weary Cat Face', 'Crying Cat Face', 'Pouting Cat Face', 'Kiss Mark', 'Waving Hand', 'Raised Back of Hand', 'Hand With Fingers Splayed', 'Raised Hand', 'Vulcan Salute', 'OK Hand', 'Victory Hand', 'Crossed Fingers', 'Love-You Gesture', 'Sign of the Horns', 'Call Me Hand', 'Backhand Index Pointing Left', 'Backhand Index Pointing Right', 'Backhand Index Pointing Up', 'Middle Finger', 'Backhand Index Pointing Down', 'Index Pointing Up', 'Thumbs Up', 'Thumbs Down', 'Raised Fist', 'Oncoming Fist', 'Left-Facing Fist', 'Right-Facing Fist', 'Clapping Hands', 'Raising Hands', 'Open Hands', 'Palms Up Together', 'Handshake', 'Folded Hands', 'Writing Hand', 'Nail Polish', 'Selfie', 'Flexed Biceps', 'Leg', 'Foot', 'Ear', 'Nose', 'Brain', 'Tooth', 'Bone', 'Eyes', 'Eye', 'Tongue', 'Mouth', 'Baby', 'Child', 'Boy', 'Girl', 'Person', 'Man', 'Man: Beard', 'Man: Blond Hair', 'Man: Red Hair', 'Man: Curly Hair', 'Man: White Hair', 'Man: Bald', 'Woman', 'Woman: Blond Hair', 'Woman: Red Hair', 'Woman: Curly Hair', 'Woman: White Hair', 'Woman: Bald', 'Older Person', 'Old Man', 'Old Woman', 'Man Frowning', 'Woman Frowning', 'Man Pouting', 'Woman Pouting', 'Man Gesturing No', 'Woman Gesturing No', 'Man Gesturing OK', 'Woman Gesturing OK', 'Man Tipping Hand', 'Woman Tipping Hand', 'Man Raising Hand', 'Woman Raising Hand', 'Man Bowing', 'Woman Bowing', 'Man Facepalming', 'Woman Facepalming', 'Man Shrugging', 'Woman Shrugging', 'Man Health Worker', 'Woman Health Worker', 'Man Student', 'Woman Student', 'Man Teacher', 'Woman Teacher', 'Man Judge', 'Woman Judge', 'Man Farmer', 'Woman Farmer', 'Man Cook', 'Woman Cook', 'Man Mechanic', 'Woman Mechanic', 'Man Factory Worker', 'Woman Factory Worker', 'Man Office Worker', 'Woman Office Worker', 'Man Scientist', 'Woman Scientist', 'Man Technologist', 'Woman Technologist', 'Man Singer', 'Woman Singer', 'Man Artist', 'Woman Artist', 'Man Pilot', 'Woman Pilot', 'Man Astronaut', 'Woman Astronaut', 'Man Firefighter', 'Woman Firefighter', 'Man Police Officer', 'Woman Police Officer', 'Man Detective', 'Woman Detective', 'Man Guard', 'Woman Guard', 'Man Construction Worker', 'Woman Construction Worker', 'Prince', 'Princess', 'Man Wearing Turban', 'Woman Wearing Turban', 'Man With Chinese Cap', 'Woman With Headscarf', 'Man in Tuxedo', 'Bride With Veil', 'Pregnant Woman', 'Breast-Feeding', 'Baby Angel', 'Santa Claus', 'Mrs. Claus', 'Man Superhero', 'Woman Superhero', 'Man Supervillain', 'Woman Supervillain', 'Man Mage', 'Woman Mage', 'Man Fairy', 'Woman Fairy', 'Man Vampire', 'Woman Vampire', 'Merman', 'Mermaid', 'Man Elf', 'Woman Elf', 'Man Genie', 'Woman Genie', 'Man Zombie', 'Woman Zombie', 'Man Getting Massage', 'Woman Getting Massage', 'Man Getting Haircut', 'Woman Getting Haircut', 'Man Walking', 'Woman Walking', 'Man Running', 'Woman Running', 'Woman Dancing', 'Man Dancing', 'Man in Suit Levitating', 'Men With Bunny Ears', 'Women With Bunny Ears', 'Man in Steamy Room', 'Woman in Steamy Room', 'Person in Lotus Position', 'Women Holding Hands', 'Woman and Man Holding Hands', 'Men Holding Hands', 'Kiss', 'Kiss: Man, Man', 'Kiss: Woman, Woman', 'Couple With Heart', 'Couple With Heart: Man, Man', 'Couple With Heart: Woman, Woman', 'Family', 'Family: Man, Woman, Boy', 'Family: Man, Woman, Girl', 'Family: Man, Woman, Girl, Boy', 'Family: Man, Woman, Boy, Boy', 'Family: Man, Woman, Girl, Girl', 'Family: Man, Man, Boy', 'Family: Man, Man, Girl', 'Family: Man, Man, Girl, Boy', 'Family: Man, Man, Boy, Boy', 'Family: Man, Man, Girl, Girl', 'Family: Woman, Woman, Boy', 'Family: Woman, Woman, Girl', 'Family: Woman, Woman, Girl, Boy', 'Family: Woman, Woman, Boy, Boy', 'Family: Woman, Woman, Girl, Girl', 'Family: Man, Boy', 'Family: Man, Boy, Boy', 'Family: Man, Girl', 'Family: Man, Girl, Boy', 'Family: Man, Girl, Girl', 'Family: Woman, Boy', 'Family: Woman, Boy, Boy', 'Family: Woman, Girl', 'Family: Woman, Girl, Boy', 'Family: Woman, Girl, Girl', 'Speaking Head', 'Bust in Silhouette', 'Busts in Silhouette', 'Footprints', 'Luggage', 'Closed Umbrella', 'Umbrella', 'Thread', 'Yarn', 'Glasses', 'Sunglasses', 'Goggles', 'Lab Coat', 'Necktie', 'T-Shirt', 'Jeans', 'Scarf', 'Gloves', 'Coat', 'Socks', 'Dress', 'Kimono', 'Bikini', 'Woman’s Clothes', 'Purse', 'Handbag', 'Clutch Bag', 'Backpack', 'Man’s Shoe', 'Running Shoe', 'Hiking Boot', 'Flat Shoe', 'High-Heeled Shoe', 'Woman’s Sandal', 'Woman’s Boot', 'Crown', 'Woman’s Hat', 'Top Hat', 'Graduation Cap', 'Billed Cap', 'Rescue Worker’s Helmet', 'Lipstick', 'Ring', 'Briefcase'],
  //     ['😀', '😃', '😄', '😁', '😆', '😅', '🤣', '😂', '🙂', '🙃', '😉', '😊', '😇', '🥰', '😍', '🤩', '😘', '😗', '☺', '😚', '😙', '😋', '😛', '😜', '🤪', '😝', '🤑', '🤗', '🤭', '🤫', '🤔', '🤐', '🤨', '😐', '😑', '😶', '😏', '😒', '🙄', '😬', '🤥', '😌', '😔', '😪', '🤤', '😴', '😷', '🤒', '🤕', '🤢', '🤮', '🤧', '🥵', '🥶', '🥴', '😵', '🤯', '🤠', '🥳', '😎', '🤓', '🧐', '😕', '😟', '🙁', '☹', '😮', '😯', '😲', '😳', '🥺', '😦', '😧', '😨', '😰', '😥', '😢', '😭', '😱', '😖', '😣', '😞', '😓', '😩', '😫', '😤', '😡', '😠', '🤬', '😈', '👿', '💀', '☠', '💩', '🤡', '👹', '👺', '👻', '👽', '👾', '🤖', '😺', '😸', '😹', '😻', '😼', '😽', '🙀', '😿', '😾', '💋', '👋', '🤚', '🖐', '✋', '🖖', '👌', '✌', '🤞', '🤟', '🤘', '🤙', '👈', '👉', '👆', '🖕', '👇', '☝', '👍', '👎', '✊', '👊', '🤛', '🤜', '👏', '🙌', '👐', '🤲', '🤝', '🙏', '✍', '💅', '🤳', '💪', '🦵', '🦶', '👂', '👃', '🧠', '🦷', '🦴', '👀', '👁', '👅', '👄', '👶', '🧒', '👦', '👧', '🧑', '👨', '🧔', '👱\u200d♂️', '👨\u200d🦰', '👨\u200d🦱', '👨\u200d🦳', '👨\u200d🦲', '👩', '👱\u200d♀️', '👩\u200d🦰', '👩\u200d🦱', '👩\u200d🦳', '👩\u200d🦲', '🧓', '👴', '👵', '🙍\u200d♂️', '🙍\u200d♀️', '🙎\u200d♂️', '🙎\u200d♀️', '🙅\u200d♂️', '🙅\u200d♀️', '🙆\u200d♂️', '🙆\u200d♀️', '💁\u200d♂️', '💁\u200d♀️', '🙋\u200d♂️', '🙋\u200d♀️', '🙇\u200d♂️', '🙇\u200d♀️', '🤦\u200d♂️', '🤦\u200d♀️', '🤷\u200d♂️', '🤷\u200d♀️', '👨\u200d⚕️', '👩\u200d⚕️', '👨\u200d🎓', '👩\u200d🎓', '👨\u200d🏫', '👩\u200d🏫', '👨\u200d⚖️', '👩\u200d⚖️', '👨\u200d🌾', '👩\u200d🌾', '👨\u200d🍳', '👩\u200d🍳', '👨\u200d🔧', '👩\u200d🔧', '👨\u200d🏭', '👩\u200d🏭', '👨\u200d💼', '👩\u200d💼', '👨\u200d🔬', '👩\u200d🔬', '👨\u200d💻', '👩\u200d💻', '👨\u200d🎤', '👩\u200d🎤', '👨\u200d🎨', '👩\u200d🎨', '👨\u200d✈️', '👩\u200d✈️', '👨\u200d🚀', '👩\u200d🚀', '👨\u200d🚒', '👩\u200d🚒', '👮\u200d♂️', '👮\u200d♀️', '🕵️\u200d♂️', '🕵️\u200d♀️', '💂\u200d♂️', '💂\u200d♀️', '👷\u200d♂️', '👷\u200d♀️', '🤴', '👸', '👳\u200d♂️', '👳\u200d♀️', '👲', '🧕', '🤵', '👰', '🤰', '🤱', '👼', '🎅', '🤶', '🦸\u200d♂️', '🦸\u200d♀️', '🦹\u200d♂️', '🦹\u200d♀️', '🧙\u200d♂️', '🧙\u200d♀️', '🧚\u200d♂️', '🧚\u200d♀️', '🧛\u200d♂️', '🧛\u200d♀️', '🧜\u200d♂️', '🧜\u200d♀️', '🧝\u200d♂️', '🧝\u200d♀️', '🧞\u200d♂️', '🧞\u200d♀️', '🧟\u200d♂️', '🧟\u200d♀️', '💆\u200d♂️', '💆\u200d♀️', '💇\u200d♂️', '💇\u200d♀️', '🚶\u200d♂️', '🚶\u200d♀️', '🏃\u200d♂️', '🏃\u200d♀️', '💃', '🕺', '🕴', '👯\u200d♂️', '👯\u200d♀️', '🧖\u200d♂️', '🧖\u200d♀️', '🧘', '👭', '👫', '👬', '💏', '👨\u200d❤️\u200d💋\u200d👨', '👩\u200d❤️\u200d💋\u200d👩', '💑', '👨\u200d❤️\u200d👨', '👩\u200d❤️\u200d👩', '👪', '👨\u200d👩\u200d👦', '👨\u200d👩\u200d👧', '👨\u200d👩\u200d👧\u200d👦', '👨\u200d👩\u200d👦\u200d👦', '👨\u200d👩\u200d👧\u200d👧', '👨\u200d👨\u200d👦', '👨\u200d👨\u200d👧', '👨\u200d👨\u200d👧\u200d👦', '👨\u200d👨\u200d👦\u200d👦', '👨\u200d👨\u200d👧\u200d👧', '👩\u200d👩\u200d👦', '👩\u200d👩\u200d👧', '👩\u200d👩\u200d👧\u200d👦', '👩\u200d👩\u200d👦\u200d👦', '👩\u200d👩\u200d👧\u200d👧', '👨\u200d👦', '👨\u200d👦\u200d👦', '👨\u200d👧', '👨\u200d👧\u200d👦', '👨\u200d👧\u200d👧', '👩\u200d👦', '👩\u200d👦\u200d👦', '👩\u200d👧', '👩\u200d👧\u200d👦', '👩\u200d👧\u200d👧', '🗣', '👤', '👥', '👣', '🧳', '🌂', '☂', '🧵', '🧶', '👓', '🕶', '🥽', '🥼', '👔', '👕', '👖', '🧣', '🧤', '🧥', '🧦', '👗', '👘', '👙', '👚', '👛', '👜', '👝', '🎒', '👞', '👟', '🥾', '🥿', '👠', '👡', '👢', '👑', '👒', '🎩', '🎓', '🧢', '⛑', '💄', '💍', '💼']
  // );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            iconSize: 80.0,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.sentiment_very_satisfied,
              color: (selectedMood == Mood.HAPPY ? Colors.green : Colors.grey),
            ),
            onPressed: () => switchSentiment(Mood.HAPPY),
          ),
          IconButton(
            iconSize: 80.0,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.sentiment_neutral,
              color: (selectedMood == Mood.MEH ? Colors.orange : Colors.grey),
            ),
            onPressed: () => switchSentiment(Mood.MEH),
          ),
          IconButton(
            iconSize: 80.0,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.sentiment_very_dissatisfied,
              color: (selectedMood == Mood.SAD ? Colors.red : Colors.grey),
            ),
            onPressed: () => switchSentiment(Mood.SAD),
          )
        ],
      ),
    );
  }

  void switchSentiment(Mood mood) {
    setState(() {
      selectedMood = mood;
    });

    widget.onChanged(mood);
  }
}
