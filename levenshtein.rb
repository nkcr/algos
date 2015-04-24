#! /usr/bin/ruby

require 'benchmark'

# Purpose
# -------
# Compute levenstein distance

# This is a standard way to compute lenvenstein distance over
# two words
# Params:
# - word1 (string) first word
# - word2 (strong) second word
def lev_distance(word1, word2)
	# Note : i for row, j for colomn
	# init 2D array with default (0,1,2,...)
	a = Hash.new
	(0..word1.length).each do |j|
		a[[0,j]] = j
	end
	(0..word2.length).each do |i|
		a[[i,0]] = i
	end
	(1..word2.length).each do |i|
		(1..word1.length).each do |j|
			if word1[j-1] == word2[i-1]
				diago = a[ [i-1,j-1] ]
			else
				diago = a[ [i-1,j-1] ] + 1
			end
			a[ [i,j] ] = [diago, a[ [i-1,j] ]+1, a[ [i,j-1] ]+1].min
		end
	end
	# p a
	return a[ [word2.length,word1.length] ]
end

# This is a more advanced way to compute lenvenstein distance over
# two words
# Params:
# - word1 (string) first word
# - word2 (strong) second word
def best_lev_distance(word1, word2)
	# Note : i for row, j for colomn
	# init 2D array with default (0,1,2,...)
	last = Array.new
	(0..word1.length).each do |j|
		last[j] = j
	end
	current = nil
	(1..word2.length).each do |i|
		current = Array.new
		(1..word1.length).each do |j|
			if j == 1
				current[0] = i
			end
			if word1[j-1] == word2[i-1]
				diago = last[j-1]
			else
				diago = last[j-1] + 1
			end
			current[j] = [diago, current[j-1]+1, last[j-1]+1].min
		end
		last = current
	end
	# p current
	return last[word1.length]
end

n = 10
s1 = "j'aime les petits poneys"
s2 = "Il fait vraiment froid dehors"

s1 = "En novembre 1215, la première charte rurale en France est octroyée aux habitants de Rouvres par le duc Eudes III. Elle sera confirmée en 1247 par Hugues IV puis en 1362 par Jean le Bon, roi de France. Les villageois ne furent plus « taillables et corvéables à merci » moyennant une redevance annuelle assez lourde mais supportable au début, quand les mesures étaient précisées : 1 000 setiers (environ 2 400 hl), moitié avoine, moitié froment. Cette redevance, appelée la matroce21 par les habitants car elle était souvent remise à la châtelaine, ou « maîtresse », en l'absence de l'époux souvent en déplacement, fut rapidement une source de conflits pour deux raisons. Tout d'abord, c'était un impôt de répartition distributive : ce qu'un redevable ne pouvait donner, un autre devait le donner. Ensuite, certains châtelains peu scrupuleux modifiaient les mesures de grains à leur avantage, et ceci, malgré les mesures étalons que le notaire ducal, Girard Bonotte, avait fixées en 1288. C'est que le statut de forteresse du château, ainsi que le statut de ville de foire (deux par an) et de marché (le jeudi), bien qu'offrant des avantages à la population, augmentaient surtout sa contribution à l'impôt ! Les habitants commencent alors à « fuir » le village où les charges deviennent progressivement insupportables. Bien souvent, les 1000 émines ne peuvent être livrées. Il faut demander des reports de dette ou des réductions de la redevance. Des différents surgissent et la peste noire fait des ravages. La population diminue : en 1308, 575 feux ; en 1431, 123 feux ; en 1469, 99 feux ; en 1666, 37 feux. En 1356, un Comtois, Thibaud de Faucogney, venu pour tenter d'enlever le jeune prince Philippe, héritier ducal, pille et brûle le village. À ces malheurs, s'ajoutent les exactions des routiers : on connait ainsi le cas de « frère Darre », un chef de bande écumant la région en 1365."
s2 ="Au milieu du xive siècle, la famille ducale s’installe à la campagne, dans son domaine de Rouvres, afin d’échapper aux conséquences néfastes des épidémies. Jeanne Ire d’Auvergne (dite aussi « de Boulogne »), reine de France, assure la régence ducale depuis 1349 pour son fils né d’un premier lit bourguignon. Elle meurt néanmoins de la maladie, à Vadans, en septembre 1360. L’année suivante, le 21 novembre 1361, son fils Philippe Ier de Bourgogne, ou « de Rouvres » car né à Rouvres en 1346, meurt prématurément lui aussi de la peste22. Âgé de quinze ans, il n’a pas eu le temps de s’assurer une descendance. Avec lui, s’éteint « par les mâles » la branche aînée (ou « directe ») de la maison capétienne de Bourgogne. Le roi de France, Jean II le Bon, second mari de Jeanne, prend possession de la Bourgogne et en confie le gouvernement à son lieutenant général, le comte de Tancarville. En juin 1363, il remet en apanage la Bourgogne à son fils Philippe le Hardi qui devient le premier duc Valois en 1364. En 1369, Philippe II de Bourgogne (1364-1404) prend pour épouse Marguerite de Flandres, veuve de Philippe de Rouvres. Ils s’installent à Rouvres et font d’importants travaux au château : tour de guet (la Lanterne), fossés, hourds, pont-levis… Après 1414, le duc Jean sans Peur (1404–1419) fait encore renforcer l’édifice. En ces temps troublés de la guerre de Cent Ans, les écorcheurs sévissent alors dans la contrée. Ainsi, à partir de 1416, Marguerite de Bavière, épouse de Jean sans Peur, supervise la construction d’une grosse tour de défense, dite « tour Marguerite ». Sous les deux premiers ducs de la Maison de Valois3, les duchesses font en effet de longs et fréquents séjours au château. Leurs époux sont alors retenus à Paris par les affaires du Royaume : c’est l’époque de la lutte entre Armagnacs et Bourguignons. Le château, en ce début de xve siècle, est « une bâtisse vénérable, un grand ensemble de bâtiments, mi-forteresse, mi-demeure de plaisance, entourés de fossés larges et profonds et d'une enceinte de hauts murs de pierre, renforcée par des tours »23. Il s'y ajoute, au sud, de vastes jardins clos24,25. Avec Germolles et Argilly, c'est une des résidences préférées de la famille ducale dans la campagne bourguignonne. Rouvres constitue alors un important poste de dépenses du budget ducal26."

Benchmark.bm do |x|
  x.report("Normal:") { n.times do ; lev_distance s1, s2 ; end }
  x.report("Best:") { n.times do ; best_lev_distance s1, s2 ; end }
end
