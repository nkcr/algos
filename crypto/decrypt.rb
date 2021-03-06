#! /usr/bin/ruby

require_relative 'frequency'
require_relative 'mono_alpha'

# Purpose
# -------
# Decrypt or at least find some informations about a
# given crypted string

# Outputs statistics about the given string
# by calcultating kullback coef we should be
# able to find the key length. If the value is near 0.07 it's good
# params :
# - max (Integer) the max shift
# - string (String) the string
# return :
# - nothing, just outputs infos
def key_length(max,string)
	(1..max).each do |i|
		sub_str = ""
		string.chars.each_with_index do |char,j|
			sub_str = sub_str.concat(char) if j%i == 0
		end
		coeff = Frequency.kullback(sub_str)
		p "For each #{i}, coef : #{coeff}" 
	end
end
# @test
# expected 15
key_length(40,"LMYOINFHVBIPBSYDWEPYUUSVLSXFAVPXLDYUQHVVIIGTYWXCPAEZHVLYMQUAAOLCKOZVLQGKMSFWBWTVCASECHHEOADWEPTLQWZMIWMIGNMXZVTQHYMDVMFRIUPPBAHFZBXUAUIALLCBASSRVQDUTEAMYQQNPJJMWHEPEEBDLTODXKWYWQNYQQQLQSMSKKSPBRRJLCPYUQQRXSOUCRLWFCZAUYSQIQXUVBITCMUZRRCZDUSCWZETXOGWRDSLDEGAKSPZCTJIYYHDEYHMLFVGDFELWHUGAACCNIRMQRDMVPEYDWEPTIZHFVRXZECKCGLQTQYIMUXGNTNIYOAEULEMYUULYALPEMRYNEIQDXGEAALQIINQVAWHMSRHMGPZEFFTWRWUNHAZDZVCTJDQRGMRGWOYLVAYTZBMHMBNOWFCLIEFEATRGRCKQYEMTXFKMXHFOHPMXXIIXQFBIHPEYEVRPASQQVDEGANPABAZCSEJGIVOTOGAKZXUEZHRLIGQSPAVOCMMMNJMRDDRVRIYEILMHLQWLZEYWXCPUIQWVKLREEDQQWLXEDHLBJXFSBJXCZDOOFKMYUCUVYIFDIIFYIIRTGIYHMXPVTMZDIVFTECEMOOCNXTLZHFMREKADPITFJCMHHPEHTOCZACTJMIYAZOEIIYOASASZVXHDLBYCECQCQIFVXOMTRPMLAXADFZAWDUTRJKLOZEQURZPDBOEPQPCMEFFZBYQQFRIUPOMVUSXBEYUNTPLPFFAZXEWYVMVBJAOPRAPNKIZHOQHATWPZABNUQXHPIARMDEQGMYZWRGMRGWOYLVEYGIIWVMIGPWFEMUZJGPCVUOAKUTPQLHNKLSQODHLZPXQEDHFCTGAEVHYFPTARJDUIHFAVPRPFVEQYSMPOQOEYMEEMBQFLBIOQFEWXALLAGYRVXSXUFMCPWTEQYRQXSMRSWQEPUEZYVBVDZGRNMLFFPMDJUIUUDVKVLFFQGJACWTGEYWLLCBASSRVEYMIGDIMTBEEHVBELFUAAXLWMEFGCWRGQPRNAZYVEMZOTSQSSPDMGPCXNTLKPHETBIJLYBSGWJMWHBAHHMDLCXSWRVHVKEHTJWPCSXFEOYLESNJBDLCXXJMZIVDOFAMDPBAGCDIMQEDNHJLEZEQQCMGDGSNEBECMSHNMMQHZTNRMNWQNOTEVY")
# expected 5
key_length(40,"DOJBELAILTLMAVMOXPPXVRQRVTPYGMSPRHCFPMYIZXRKWVVBTTHVYVNSEALWKYAVUBGFTRLFELGBRRPIAXRIZJFJPIUECGISILNIDOIZVHXKLVAINLFQIQLRAWRKZFXMXFHRGRDFGSYFYYVKYVMDLMAXEVUCPCCPLTNMMTSLEISIIVAQEPFRLVBLMRYCWIHYQLBPVPPRAJNZBNSSGSPVJBKIEAFRKIPVANEPEIHYKWICVGBYLGURYVIHZYYNREMTEGDGVQOZMOHCXMSPVVZTHCNPVYFNSDIQZRAHRJRFYLPWMMYCMTJPLMJLRJMUNMWMLWDLQQVCDIUXREBBYVNSBTFUMDIQXEYXRRCYILZVTIFCMTTCEMAWZFZDIYFBKISVZRYGDSUXERXJHCXIUXGIIOWDZVTIFVVDPMFWDOPVBSETLMSWVICEICYEWTNIMOGCPWAYAUMDISIUBMRKWORCYXSICCCTPCGSFETVCSUSTTLRRKZFTMFVSECIMNMCCIMSVJLBRQWIZQBEBBKLPWXYVJMQEPPRAPNWZBRAPHLPUVTWIRTIDOJBELAI")
# expected 26
key_length(40,"CQUDDCHMMWKTALJHBOJCPOLMHHZPFGSEMAJKQVKPZLACOWZHESPTLHXPJERAGGBXCKQSIZBRRKFWPTUYBEKDOHPDGTMTIHVQFAWUITBVHUQCOTLUTIGRPKODVGEXTNPHSNWKKGXEZDTNRERHPLWBUQDUEJEEJCXKYIVMKVVKDHHOCDSNMXCWPAJKOGJECMBWNJQHZHCFTGZRMPGHWJLWZEMQIORDSSPLBIENZNEWRWFYQFKPEUHGRDYAEQFOYKWWMGRGTCYTKDOOTNUFLUAWMGDDQCPMBZWUIQZTKUTIGUCZHHXCJWSXFBSNWTBXGNDXTBERLKZHOFFMTJLDEBXGRGRQEQHPAJKLIHITGRQGLAIGYQSQORZMHNRCYUQLBSOCQUGWVLIUICMRKZSZCFPAASWISNSLPKYKXTBPZRODAZFGPLILMFTGZRMPGEFVLWRECQEVVJQPOVIWUJSIFLQHRUKVKTMABHRLLLADCEVRCYASWLJILPTIFQPPPFKTAQKOJCZGZFXXWBBNUNQPTNZLPZWVMBGUDLLMXHZHAGYPSXXZEJYKAEWFENQMFJPXXUKVGBVQBZAKQZQUTSTLNLYAGAJIPWXLOEPKCLGZZHATFWDNCWWLZHQQATOEAZFJYPHOQSTMDFLJGANJBEZUBQHPEKMBOOMGSNKCPXWWJBXUIUVBIPEVVHTEFQBDRMTDEZJDBNOMZMIDREALHHVBVRKUWAFXWJBFANTAJMQVAFJLAAFNSXPXSENUIGYQEQGZYCCZMXQSDUZNLAIGYQQQATZDDKBJNVQUCBDXTXPHSBSJRQAUXEDPYZCYBHZFFUZZLLMZZUAWTEVACBHVYAPHVHFMNHYSMXSJBNRECPTENSGLJDDOOCKBPMVXTKIGYAWNPNFRBLQUARFEZCPFXTWHFXKREZPXPVLAWLOFFNSUXWVTQQZNGMOGGYRTCWAXXZFNMZPJQXJCYQOTOBGZFJCMKXTSFCNOQXIQFNYZIOXZTIGVLKWLBEVNOFLARMJIBVOMZDTXNKGVJVKCOCQYWWWYQQJCTDCXTKEVTVPGMGNJQWSSRWXBBEGRNUCVYUCIKXZPPWKYMSMEQYAWVAVMXNZRBHIHUOSPTYCAXXIQRVXIMTTGRJQLNJMBUBZPPJKXQUCTUINXTXURSKHHUOVEZCDLIFUIIGBEAGTYRGYYEVTSQJOYOWWYTKPNKSZUADRIQSAVAHBCTYDUIMYUMQXTORTMZVCJAWBSGNMYEJIHZLBTZEVQIJHKYBCUIBEJLODWQXSJAGYBKZSZFUCJKOQSSBDNOWPTVKXKYDSEHZZZLLAVLOOBKUXSWLJGRKSEVMXZAKYAKXBQFVDWZFXXSJBOKNDXTPEJRHMXQBFAHYDWXEJKOUSAVURZFVRWETCOJNMNAGYKFYKUODSDTVPFSWOGMDJWFFPDEFFKSCOSOTJHRLPNAQMFBUDRLPFQHYIAGVKUIZAKPLWXBFFBTHRJSNUUAGIECVDTRLVKAPWBTZTCLHVXXQSQORNQUJATCSAYQHSJFYOMRXKUKGZROETONZROWULWNNMNLKWBXIRTREXFPWYVKLJWMHENKUADSGLUXKZTYGGVGFSYOHAFFPZLOKIMXUPTGIVXTMVVQHQGMRBWRYESYWJXLTYDKZHGNWMBHHLSMJRUWDIXYTXPYLKRDPYVBLHDXZBLDRLPFQHQIGARCSTNGVQKASIFPMHYLDINWIOKXECQRGNKYUPVIIYJOJPDWZTWRGTABPHLHZJZAFPOOPDUTWRMIKKDUUDMAVHKPLZHTOTJKFPSZXHBBWXSMMBVERBLOLTSUJHNLAWXIUGWMEBCJZPVQQAXVSTLKYCUWGJFXTZAQQPDRERWWVTSOWTCPLPTKQQKMUOPJMRJRLZHAOTBHMESRMXUQSAIVEHVIRGLJWNCSCACPFTHZHIGARZXPDFZPWWUBWDDKCPJIQYHXKXENQRZDLGSODDOJNMNDGYLQUPAKUHGCNCVAAWFTSRDHFPMVYFYPCOTKFIZAUPLLDBWFVLYYLPTZJOGDAHNMXKRVITF")