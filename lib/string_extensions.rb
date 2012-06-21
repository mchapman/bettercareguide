class String

    SoundexChars = 'BPFVCSKGJQXZDTLMNR'
    SoundexNums  = '111122222222334556'
    SoundexCharsEx = '^' + SoundexChars
    SoundexCharsDel = '^A-Z'

    # desc: http://en.wikipedia.org/wiki/Soundex
    def soundex(census = true)
        str = upcase.delete(SoundexCharsDel).squeeze

        str[0 .. 0] + str[1 .. -1].
            delete(SoundexCharsEx).
            tr(SoundexChars, SoundexNums).squeeze[0 .. (census ? 2 : -1)].
            ljust(3, '0') rescue ''
    end

    def sounds_quite_like(other)
        soundex == other.soundex
    end

    def sounds_like(other)
        soundex(false) == other.soundex(false)
    end

    def stripped
      split(//).map {|a| a =~ /[a-zA-Z0-9]/ ? a.upcase : nil}.compact.join
    end

    def numbers
      split(//).map {|a| a =~ /[0-9]/ ? a : nil}.compact.join
    end

    def censored
        # naughty word list comes from http://urbanoalvarez.es/blog/2008/04/04/bad-words-list/
     gsub(/(\s|^)(ahole|anus|ash0le|ash0les|asholes|ass|Ass Monkey|Assface|assh0le|assh0lez|asshole|assholes|assholz|asswipe|azzhole|bassterds|bastard|bastards|bastardz|\
            basterds|basterdz|Biatch|bitch|bitches|Blow Job|boffing|butthole|buttwipe|c0ck|c0cks|c0k|Carpet Muncher|cawk|cawks|Clit|cnts|cntz|cock|cockhead|cock-head|cocks|\
            CockSucker|cock-sucker|crap|cum|cunt|cunts|cuntz|dick|dild0|dild0s|dildo|dildos|dilld0|dilld0s|dominatricks|dominatrics|dominatrix|dyke|enema|f u c k|f u c k e r|\
            fag|fag1t|faget|fagg1t|faggit|faggot|fagit|fags|fagz|faig|faigs|fart|flipping the bird|fuck|fucker|fuckin|fucking|fucks|Fudge Packer|fuk|Fukah|Fuken|fuker|Fukin|\
            Fukk|Fukkah|Fukken|Fukker|Fukkin|g00k|gay|gayboy|gaygirl|gays|gayz|God-damned|h00r|h0ar|h0re|hells|hoar|hoor|hoore|jackoff|jap|japs|jerk-off|jisim|jiss|jizm|\
            jizz|knob|knobs|knobz|kunt|kunts|kuntz|Lesbian|Lezzian|Lipshits|Lipshitz|masochist|masokist|massterbait|masstrbait|masstrbate|masterbaiter|masterbate|masterbates|\
            Motha Fucker|Motha Fuker|Motha Fukkah|Motha Fukker|Mother Fucker|Mother Fukah|Mother Fuker|Mother Fukkah|Mother Fukker|mother-fucker|Mutha Fucker|Mutha Fukah|Mutha Fuker|\
            Mutha Fukkah|Mutha Fukker|n1gr|nastt|nigger|nigur|niiger|niigr|orafis|orgasim|orgasm|orgasum|oriface|orifice|orifiss|packi|packie|packy|paki|pakie|paky|pecker|\
            peeenus|peeenusss|peenus|peinus|pen1s|penas|penis|penis-breath|penus|penuus|Phuc|Phuck|Phuk|Phuker|Phukker|polac|polack|polak|Poonani|pr1c|pr1ck|pr1k|pusse|\
            pussee|pussy|puuke|puuker|queer|queers|queerz|qweers|qweerz|qweir|recktum|rectum|retard|sadist|scank|schlong|screwing|semen|sex|sexy|Sh!t|sh1t|sh1ter|sh1ts|\
            sh1tter|sh1tz|shit|shits|shitter|Shitty|Shity|shitz|Shyt|Shyte|Shytty|Shyty|skanck|skank|skankee|skankey|skanks|Skanky|slut|sluts|Slutty|slutz|son-of-a-bitch|\
            tit|turd|va1jina|vag1na|vagiina|vagina|vaj1na|vajina|vullva|vulva|w0p|wh00r|wh0re|whore|xrated|xxx|b!+ch|bitch|blowjob|clit|arschloch|\
            b!tch|b17ch|b1tch|bastard|bi+ch|boiolas|buceta|c0ck|cawk|chink|cipa|clits|cock|dirsa|ejakulate|fatass|fcuk|fuk|fux0r|hoer|hore|jism|kawk|l3itch|l3i+ch|\
            masturbate|masterbat.*?|masterbat3|motherfucker|s.o.b.|mofo|nazi|nigga|nigger|nutsack|phuck|pimpis|pusse|pussy|scrotum|shemale|smut|teets|\
            tits|boobs|b00bs|teez|testical|testicle|titt|w00se|jackoff|wank|whoar|whore|.*?damn|.*?dyke|fucked|@$$|amcik|andskota|arse.*?|assrammer|ayir|\
            bi7ch|bitch.*?|bollock.*?|breasts|butt-pirate|cabron|cazzo|chraa|chuj|Cock.*?|cunt.*?|d4mn|daygo|dego|dick.*?|dike.*?|dupa|dziwka|ejackulate|Ekrem.*?|Ekto|\
            enculer|faen|fag.*?|fanculo|fanny|feces|feg|Felcher|ficken|fitt.*?|Flikker|foreskin|Fotze|Fu\(.*?|fuk.*?|futkretzn|gay|gook|guiena|h0r|h4x0r|hell|helvete|\
            hoer.*?|honkey|Huevon|hui|injun|jizz|kanker.*?|kike|klootzak|kraut|knulle|kuk|kuksuger|Kurac|kurwa|kusi.*?|kyrpa.*?|lesbo|mamhoon|masturbat.*?|merd.*?|mibun|\
            monkleigh|mouliewop|muie|mulkku|muschi|nazis|nepesaurio|nigger.*?|orospu|paska.*?|perse|picka|pierdol.*?|pillu.*?|pimmel|piss.*?|pizda|poontsee|poop|porn|p0rn|\
            pr0n|preteen|pula|pule|puta|puto|qahbeh|queef.*?|rautenberg|schaffer|scheiss.*?|schlampe|schmuck|screw|sh!t.*?|sharmuta|sharmute|shipal|shiz|skribz|skurwysyn|\
            sphencter|spic|spierdalaj|splooge|suka|b00b.*?|testicle.*?|titt.*?|twat|vittu|wank.*?|wetback.*?|wichser|wop.*?|yed|zabourah)(\s|$)/i,' [censored] ')
    end

end
