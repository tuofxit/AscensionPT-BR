-- Revisoes seletivas de missoes provenientes de GabrielBosco/AscensionPTBR 1.5.0.
-- Carregada antes de Corrections.lua para preservar os acertos do Tuofxit.
AscensionPTBR = AscensionPTBR or {}
local A = AscensionPTBR
local fixes = {
    [6]={d="Garrick Patatenra — um criminoso que atormenta nossos fazendeiros e mercadores há semanas — foi visto em uma cabana perto dos vinhedos, que ficam a leste da Abadia e do outro lado da ponte. Traga-me a cabeça do patife e ganhe a recompensa por matá-lo!\
\
Mas tenha cuidado, $n. Garrick reuniu uma gangue de brutamontes. Não será fácil chegar até ele."},
    [7]={d="Sua primeira tarefa é de purificação, $n. Um clã de kobolds está infestando o bosque ao norte daqui. Vá até lá e derrote todos os malditos kobolds que encontrar. Se você reduzir os números deles, a gente tem mais chances de expulsar os kobolds da Vila Norte de uma vez por todas."},
    [8]={d="Ei, colega! Faz um favor para um jovem que tem combatido mais do que seu quinhão de aranhas e zumbis estúpidos?\
\
Tenho aqui esta carta que precisa chegar a Montalvo... até uma estalajadeira chamada Geni qualquer coisa. O sobrenome dela não tem a menor importância.\
\
Enfim, é um lugar pequeno e aconchegante cheio de vítimas da peste tentando ganhar a vida. E seria um ótimo local para você descansar também se houver necessidade. Você deveria conferir... faça isso, que eu lhe pago bem."},
    [54]={p="Belmonte enviou notícias? Vila Norte é um mero jardim quando comparada à Floresta de Elwynn, então imagino o que ele tem a relatar.\\n\\nDeixe-me ver essa papelada..."},
    [138]={p="Este parece ser o barril certo."},
    [313]={c="Ah sim, esses manes vão funcionar muito bem! Você mostra muita coragem, $c - eu aposto que veremos grandes coisas vindas de você."},
    [315]={title="A cerveja perfeita"},
    [344]={d="Fadigas do Ferro? Sim, eu conheço o livro. É muito bom, foi escrito pelo mineiro anão Margulf Blaggon algumas décadas atrás. Ele passou a maior parte da vida nas montanhas de Khaz Modan, escavando minério. Camarada inteligente!\
\
Mas onde eu estava? Ah, sim, o Fadigas do Ferro! Receio que o livro tenha sido transferido para a Abadia de Vila Norte. O zelador da biblioteca da abadia, Irmão Paxeco, queria fazer uma cópia do livro para as prateleiras dele.\
\
Mas isso foi há meses. Não entendo por que ele está demorando tanto..."},
    [358]={c="Muito bem feito, $n. O Flagelo está iludido se acha que pode usar aqueles cadáveres contra nós... o fluido que você recolheu dos escravos Putricouro será estudado pelos Boticários. A linfa pode ter segredos que poderemos usar contra eles.\
\
Como eu já disse, ótimo trabalho. Mas nossa luta continua, e o conflito com certeza lhe oferecerá mais chances de provar seu valor para os Renegados."},
    [628]={p="Li em algum lugar que os crocoliscos de água salgada estão entrando em extinção... Péssimas notícias para o meu negócio, hein?Mas e aí, você trouxe a pele de crocolisco ancião de água salgada que eu pedi?"},
    [639]={o="Obtenha o Selo de Strom para Zengu, em Ruína do Martelo.",p="Já encontrou o primeiro selo? É provável que um dos agentes da Camarilha em Stromgarde esteja com ele.",c="Excelente, camarada. É um bom começo. Precisaremos de todos os selos para retirar Trol'kalar da tumba de Matatroll."},
    [640]={o="Recupere os 5 Fragmentos do Selo dos defensores de Stromgarde e leve-os a Tor'gan, em Ruína do Martelo.",c="Ah, você precisa que eu reconstrua este selo? Não será difícil... Todas as peças estão aqui, e restaurar a estrutura mágica será simples.\
\
Talvez seja melhor fechar os olhos."},
    [641]={o="Leve o Selo de Thoradin restaurado para Zengu, em Ruína do Martelo.",p="$n! Trouxe o segundo selo?",c="Já estamos na metade do caminho para retirar Trol'kalar da tumba de Matatroll. Ainda não sabemos exatamente onde está o terceiro selo, pois seus portadores circulam bastante por Arathi, mas confio que você o encontrará."},
    [643]={o="Recupere o Selo de Arathor e leve-o a Zengu, em Ruína do Martelo.",p="Valente não será fácil de localizar, $n. Montado, ele percorre grandes distâncias rapidamente. Ainda assim, precisamos do selo.",c="A perda do líder da cavalaria será um duro golpe para os defensores de Stromgarde. Melhor ainda: agora falta apenas um selo para tomarmos Trol'kalar."},
    [644]={o="Mate o Príncipe Galen Matatroll e leve o Selo de Matatroll para Zengu, em Ruína do Martelo.",p="Você voltou, $n. A linhagem de Ignaeus Matatroll foi encerrada?",c="Este é um grande dia, $c. O sangue de Matatroll não assombrará mais meu povo, e os selos necessários para obter Trol'kalar estão em nossas mãos. Em breve atacaremos os odiados trolls de Zul'Gurub."},
    [645]={o="Recupere Trol'kalar na tumba de Matatroll, em Stromgarde.",p="As gravações na pedra da tumba de Matatroll correspondem às linhas brilhantes do Selo de Ignaeus..."},
    [651]={o="Consiga a Chave Ardente, a Chave Troante e a Chave Trovejante nas Pedras da União Ocidental, da União Oriental e de União Exterior.Leve-as até a Pedra da União Interna."},
    [700]={c="O granito parece uma homenagem pequena diante da grandeza daquele anão, mas ninguém vive para sempre.\
\
Que este monumento atravesse as eras e lembre às futuras gerações que bravos soldados como Sully Caxias deram a vida por elas."},
    [727]={title="Em busca do Compêndio de Yagyin em Altaforja"},
    [728]={title="Em busca do Compêndio de Yagyin na Cidade Baixa"},
    [733]={d="As coisas por aqui vão ficar mais difíceis que nadar de poncho se eu não conseguir juntar materiais para construir algumas defesas e outros itens importantes, tchê. Notei que os ogros da área parecem estar bem equipados com sucata. Talvez as histórias de máquinas de cerco nos Ermos não estivessem tão longe da realidade, afinal...\
\
De qualquer forma, o Prospector tem se preocupado com o estado do nosso pequeno acampamento, então eu gostaria de começar a trabalhar logo, se possível.\
\
O acampamento principal dos ogros fica na Gruta Arrota-pó, a uma boa caminhada de distância seguindo a oeste daqui."},
    [743]={p="As harpias Ventofúria são inimigas mortais. Sua força em combate só é superada pela sede de sangue."},
    [744]={p="Este cocar será o presente perfeito para meu irmão.",c="Obrigado por sua ajuda, $n.\
\
Meu trabalho no cocar está quase concluído. Agora só preciso entregá-lo ao meu irmão e presenciar a cerimônia."},
    [745]={p="Se os Jubalba tivessem respeitado a terra e seus habitantes, este conflito jamais teria acontecido."},
    [746]={o="Recolha 5 Picaretas do Prospector.\
\
Em uma forja, esmague as picaretas para criar Ferramentas Quebradas.\
\
Leve 5 Ferramentas Quebradas para Baine Casco Sangrento, na Aldeia Casco Sangrento.",p="Olá, $n. Trouxe as Ferramentas Quebradas? A escavação dos anões enfurecerá os kodos de Mulgore. Essa profanação precisa acabar!",c="Obrigado, $n. Isso acalmará as feras de Mulgore e, com a bênção dos espíritos, ensinará aos anões que profanar a terra não é o caminho para a sabedoria."},
    [747]={p="Trazer carne e penas para a tribo é o primeiro passo para provar seu valor diante do Chefe.",c="Os taurens de Narache agradecem, $n. Você demonstra grande potencial."},
    [768]={title="Coletando couro"},
    [770]={c="Mal posso acreditar no que vejo! Você derrotou o grande Uivo Fantasma? Passo a olhar para você com muito respeito, jovem $c. Você demonstra uma habilidade extraordinária para a caça!\
\
Meus dias de caçador terminaram, mas eu ficaria honrado se usasse uma de minhas armas em suas jornadas.\
\
Que ela sempre atinja o alvo e traga reconhecimento a você. E que o espírito de Uivo Fantasma finalmente tenha encontrado a paz."},
    [779]={p="O Selo da Terra está aqui, com três nichos destinados às Pedras Rúnicas de Ametista, Opala e Diamante.",c="Ao encaixar as Pedras Rúnicas nos nichos correspondentes, um estrondo violento sacode a terra e o Selo se rompe."},
    [780]={p="Os javaliços estão ficando cada vez mais agressivos. Já deixou o recado bem claro e trouxe os focinhos e flancos?",c="Excelente. Com estes ingredientes farei um belo ensopado, e a perda desses javaliços servirá de lição aos Costagulha."},
    [781]={o="Leve o Plano de Ataque dos Costagulha para o Chefe Vento do Falcão, na Aldeia Narache.",p="Você parece preocupado, $n. Que notícias traz?",c="Isto é realmente alarmante! Mas, com esta informação, podemos chamar nossos irmãos da Aldeia Casco Sangrento para ajudar a impedir o ataque. Você salvou a vida de muitos taurens, $n."},
    [812]={title="Em busca da cura"},
    [821]={p="Como está indo a busca?"},
    [822]={p="Está sendo muito difícil encontrar esses ingredientes, $n?"},
    [826]={o="Derrote Zalazane.\
\
Mate 8 Trolls Vodu e 8 Trolls Enfeitiçados.\
\
Leve a Cabeça de Zalazane para Mestre Gadrin."},
    [836]={d="A voz do gnomo surge de novo do robô:\
\
<Preciso transportar o OOX-09/HL para um local amplo e seguro para eu começar o longo procedimento de lançamento. Ele tem um manto de invisibilidade embutido, mas preciso de tempo para torná-lo funcional de novo. Escolte o robô de sua localização atual para, digamos, a costa além dos Penhascos Panorâmicos! Lá seria um lugar perfeito e extenso o suficiente para a conexão!>\
\
Leve-o em segurança para a costa e volte para falar comigo na Angra do Butim! Olhatorto Obnótico – câmbio!<"},
    [883]={c="Lakota'mani é chamado de <Treme-terra> em nossa língua, e seus passos são como um grande trovão. Ele está com você agora, e a coragem dele se mistura com a sua. Juntos, não há conflito que você não possa enfrentar.\
\
Caminhe de cabeça erguida, $n. De cabeça erguida, Treme-terra."},
    [885]={c="O raro falcotrom é uma fera que habita os Sertões, e sua morte pode ser um presságio de grande sorte, ou de grande azar.\
\
Mas a morte de Anhan Guera, que se chama <Mordida Espiritual> em Taurahe, pode trazer nenhuma das duas... ou ambas.\
\
A dor que você sentiu ao caçar Mordida Espiritual é a dor que todos sentem ao conseguir grandes ganhos através um alto custo. A pontada que você sentiu era a dor do arrependimento.\
\
Mas vejo que você já conseguiu superar. Você aprendeu que o arrependimento vira sabedoria, e que a dor leva à força.\
\
Você aprendeu muito, $n."},
    [914]={o="Leve as Gemas de Cobrahn, Sucurina, Pítias e Serpentis para Nara Juba Agreste, no Penhasco do Trovão."},
    [915]={p="Eu queria que fizessem outros sabores além de morango, mas ainda bem que morango é o meu favorito!"},
    [929]={c="Depois da Batalha do Monte Hyjal, ficamos sem rumo. Nordrassil ainda fumegava por causa do fogo que havia liberado, e nossa imortalidade — a própria essência do nosso povo — estava perdida.\
\
Foi nesse período difícil que o Traidor foi libertado de sua prisão e Shan'do Tempesfúria desapareceu. Foram tempos sombrios para todos nós."},
    [951]={p="$n, sua exploração das Ruínas de Mathistra rendeu bons frutos?",c="Obrigado. Estas relíquias pertencem ao tempo em que Mathistra ainda resplandecia. A antiga fortaleza é apenas uma sombra do que foi, mas fragmentos da magia daquele povo permanecem. Espero que consigamos desvendar seus segredos antes dos nossos inimigos...\
\
Mantenha-se alerta, $n."},
    [968]={d="Embora muito gasto e arranhado, o título do livro ainda está legível na capa:\
\
Os Poderes de Baixo\
\
O livro traz uma lista de nomes impronunciáveis com títulos agourentos, métodos de adoração e sacrifícios preferenciais... muitos dos quais envolvem seres vivos e humanoides.\
\
Na contracapa está escrito: <Runas e Ruínas de Agarrosso, Caverna Esquecida, Altaforja. Proprietário: Gerrig Agarrosso>.\
\
Se Agarrosso vende livros como esse, talvez ele se interesse em comprar de volta."},
    [981]={c="Eu sabia que você estaria à altura da tarefa, $n.\
\
Pressinto grandes feitos em seu futuro e acredito que você corrigirá muitos dos males que assolam nossas terras. Leve minhas bênçãos, $n, e aceite também este presente."},
    [1062]={title="Invasores Goblins",p="O Vale Matagrande fica a noroeste, $n. Vá. Espalhe o medo entre aqueles que saqueiam estas terras!"},
    [1068]={p="Os espíritos das árvores lamentam a perda de seus irmãos, $n. Você precisa destruir os retalhadores XT:4 e XT:9, ou temo que as Torres de Pedra jamais se recuperem."},
    [1090]={d="Sabe, eu já fui a segunda pessoa mais importante aqui. Mas tudo mudou quando o Hanfritz tomou o comando. Ele despediu o meu chefe, o Zé Fízzica, e me mandou pra cá pra baixo pra trabalhar na mina. Mas o Zé me falou pra ficar e ver o que está rolando. O novo chefe dele vai pagar bem se a gente conseguir descobrir o plano do Hanfritz.\
\
De qualquer forma, tudo que eu sei é que o Hanfritz mandou pegar muito desse minério verde dourado aí. Eu posso te dar um pedaço pra levar pro Zé, mas você vai ter que olhar os guardas enquanto eu pego."},
    [1144]={d="Finalmente a ajuda chegou!\
\
Você não faz ideia de há quanto tempo eu estou preso aqui. Não consigo nem me lembrar quando foi a última vez que vi o lado de fora.\
\
Eu sou um empreendedor, sabe? Sempre atrás do cobre, como dizem por aí. Eu soube que Cáliper Porcatraca estava pagando bem pelos Tubérculos Carmins desse urzal. Imaginei que seria vapt-vupt. Como dá para ver, eu estava equivocado!\
\
De qualquer forma, se você puder fazer a gentileza de me ajudar a sair daqui, eu lhe garanto que vai valer a pena."},
    [1401]={p="Está feito? Você pôs fim ao sofrimento dele?"},
    [1439]={title="Em busca de Tyranis"},
    [1652]={c="Então, nos encontramos novamente, $n, e vejo que está de ótimo humor.\
\
A casa dos Stilwell ficará segura por mais um dia e, pelo que me contou, não faltou perigo. Muito bem.\
\
Dafne e Jardel ajudaram muito a Igreja, e o mínimo que podíamos fazer era proteger a propriedade deles — e suas próprias vidas.\
\
Por sua bravura, você será recompensado."},
    [1778]={c="Então voltou tão rápido, hein? E o que conseguiu fazer nesse tempo?\
\
Conseguiu ajudar uma causa nobre? Talvez tenha aprendido o valor da caridade ou um pouco mais sobre suas obrigações com os habitantes de Azeroth. Conte-me quem ajudou e como...\
\
Impressionante, $n. Essas são, sem dúvida, ações de alguém que segue o caminho da Luz.\
\
Esse tipo de sacrifício sempre é recompensado com o tempo."},
    [1820]={c="Sim, é verdade. Preciso da sua perícia em combate. Meus recursos são poucos, mas minha tarefa serve tanto aos meus interesses quanto à causa dos Renegados. Faça isso e sua recompensa será dobrada."},
    [1920]={d="Ouvimos relatos de um distúrbio na taberna Recôndito Azulego do Distrito dos Magos. É estranho, criaturas invisíveis estão perambulando pela taberna, e acho que uma fenda de mana se formou lá.\
\
Quero que você investigue a taberna e capture as criaturas. Use o cantochão da manifestação para tornar a criaturas visíveis, depois é só dominar e capturar em um cofre de contenção. Quando tiver bastante, volte aqui com os cofres cheios, os vazios e o cantochão.",p="Você capturou as criaturas, $n? Elas precisam ser estudadas para descobrirmos o motivo de sua chegada."},
    [1921]={title="Coletando materiais"},
    [1960]={p="Você investigou o distúrbio, $n? Conseguiu capturar as criaturas?",c="Muito bem, $n. As criaturas dentro desses cofres de contenção serão estudadas por nossas melhores mentes, e descobriremos o motivo da presença delas na Cidade Baixa.\
\
Se o aparecimento delas foi causado por uma fenda no fluxo natural da magia, precisamos descobrir se essa fenda surgiu ao acaso. Caso tenha sido provocada por alguma força mágica, teremos de nos preparar para distúrbios ainda mais graves."},
    [1961]={title="Coletando materiais"},
    [2203]={d="Você tem sido de grande ajuda, $c. Eu lhe daria como recompensa a própria receita da bebida que ofereci antes... mas primeiro tenho uma tarefa bastante perigosa. Ouça meu pedido.\
\
Este cofre contém três Recipientes de Taumaturgia Vazios. Eles estão imbuídos de uma aura de harmonização capaz de drenar o sangue de um Dragão Guardião Calcinado. Usar um recipiente na criatura a deixará extremamente furiosa, então tome cuidado. Assim que encher os três, traga-os para mim.\
\
Faça isso e a receita será sua.",c="De um alquimista para outro, eu o saúdo. Pegue esta receita e aprenda-a. Que ela lhe traga o mesmo sucesso e as mesmas recompensas que me trouxe ao longo dos anos."},
    [2204]={p="Você nem parou para se arrumar depois de sair de Uldaman, não é? Veio direto para cá, sem se importar com o cheiro persistente da masmorra. Espero que esta visita seja apenas desagradável ao nariz, e não inútil também.\
\
Trouxe a fonte de energia para o colar?"},
    [2341]={d="Com Dran e Malton Droffers brigando por seu novo item recuperado, metade do acordo já está completo. Agora você tem uma viagem para os Ermos pela frente para terminar as coisas, já que Jarkal Limuno pode ter uma recompensa especial esperando por você em Karrath."},
    [2380]={c="É importante que a Mão Despedaçada permaneça alerta diante das mudanças que Thrall pretende trazer à Horda. Nossos números não bastarão para superar o governo dele: precisamos dominar a furtividade e a dissimulação."},
    [2499]={p="Você já encontrou Carrancarvalho, $r?"},
    [2501]={c="De um alquimista para outro, eu o saúdo. Pegue esta receita e aprenda-a. Que ela lhe traga o mesmo sucesso e as mesmas recompensas que me trouxe ao longo dos anos."},
    [2760]={d="A maioria dos nossos recrutas nunca chega à Angra do Butim, $n. O brilho da insígnia é suficiente para atiçar a ganância até mesmo nos mais impávidos ferreiros. Burros são eles, já que a insígnia é só uma gota no mar de riquezas escondidas!\
\
Encontre Galvan, o Antigo, e mostre a ele este broche. Ele mora lá pro norte, entre Zul'Gurub e a Gruta de Mosh'Ogg."},
    [2767]={d="A voz do gnomo surge de novo do robô:\
\
<Preciso transportar o OOX-22/FE para um local amplo e seguro para eu começar o longo procedimento de lançamento. Ele tem um disfarce embutido, mas preciso de tempo para torná-lo funcional de novo. Escolte o robô de sua localização atual para, digamos, a doca ao longo da Costa Esquecida! Lá seria um lugar perfeito e extenso o suficiente para acertar as coisas!>\
\
Leve-o em segurança para a doca e volte para falar comigo em Angra do Butim! Olhatorto Obnótico - câmbio!<"},
    [2848]={p="Trouxe os seis Kits de Armadura Grossa e a Vinha Selvagem?\
\
Não pense que confeccionar kits de armadura é um trabalho monótono. A prática constante desenvolve a precisão necessária para produzir peças de Couro Silvestre. Há um bom motivo para este exercício.",c="Estes kits de armadura são de excelente qualidade, $n. Se há algo que exijo no meu trabalho e no de quem trabalha comigo, é qualidade.\
\
Você fez por merecer este molde. Espero que ele lhe traga tantas recompensas quanto trouxe a mim."},
    [2855]={p="Trouxe os seis Kits de Armadura Grossa e a Vinha Selvagem?\
\
Considere a confecção dos kits uma lição de técnica e consistência. A prática prepara suas mãos para o trabalho delicado exigido pelas armaduras de Couro Silvestre. Toda lição tem um propósito, $n.",c="Estes kits de armadura são de excelente qualidade, $n. Exijo esse mesmo cuidado tanto no meu trabalho quanto no daqueles que ensino.\
\
Você fez por merecer este molde. Espero que ele lhe traga tantas recompensas quanto trouxe a mim."},
    [3378]={d="Você pode me ajudar, mortal? Pode tentar encontrar a oração a Eluna?\
\
Como disse, a oração foi gravada em uma tabuleta de ouro. Um desses canalhas idólatras deve estar com ela.\
\
Se você recuperar minha oração, leve-a para Astarii Mirestela em Darnassus. Pouco importa que minha fé tenha sido reavivada após minhas inúmeras ações malévolas contra este mundo e seus habitantes, minha oração deve ser ouvida. Absolvição é a última coisa que espero."},
    [3463]={p="Está sem rumo, $n?"},
    [3781]={p="Que a paz e a serenidade acompanhem você. Veio a serviço do próprio arquidruida, não é?"},
    [3782]={p="Que a paz e a serenidade acompanhem você. Veio a serviço do próprio arquidruida, não é?"},
    [3791]={c="Argh, estas sementes de manhagrana me fazem sentir... estranho. Em nome de Eluna, o que Staghelm está planejando com essas coisas?\\n\\nDe qualquer forma, obrigado novamente pela ajuda. Tome isto... pelo esforço. Minha pesquisa sobre a manhagrana levará algum tempo, e sem dúvida precisarei de mais. Enquanto isso, talvez eu descubra se ela possui alguma utilidade alquímica. Ainda assim, sinto-me desconfortável só de ficar perto dessas sementes."},
    [3903]={c="Ah, o Cabo Vilém pediu para você vir falar comigo? Além de ser um homem corajoso, ele está sempre disposto a ajudar, mas o dever exige a presença dele na Abadia de Vila Norte, e infelizmente o meu problema está fora de sua alçada.\
\
E quanto a você? Será que pode me ajudar?"},
    [3905]={d="Agora que a minha produção está salva, leve este Manifesto da Uva para o Irmão Neals. Ele cuida da loja de comida e bebida de Vila Norte, e eu tenho certeza de que ele vai adorar saber sobre as uvas fresquinhas.\
\
O Irmão Neals está na abadia, na torre do sino... onde ele gosta de degustar seus vinhos."},
    [4106]={p="Um Sinalizador Cenariano permite que um esfolador experiente identifique retalhos de pele contaminada nas criaturas caçadas na Selva Maleva. Transformo esses retalhos aparentemente inúteis em uma pasta espessa, usada como catalisador para o Bálsamo Vegetal Cenariano. Ao esfolar suas presas na Selva Maleva, mantenha um sinalizador com você.\
\
Quando obtiver Retalhos Contaminados, traga-os para mim e entregarei alguns bálsamos já preparados.",c="É exatamente disso que preciso. Pegue estes Bálsamos Vegetais e use-os para recuperar a Selva Maleva da corrupção. Precisamos perseverar, $n!"},
    [4111]={p="Um Sinalizador Cenariano permite que um esfolador experiente identifique retalhos de pele contaminada nas criaturas caçadas na Selva Maleva. Transformo esses retalhos aparentemente inúteis em uma pasta espessa, usada como catalisador para o Bálsamo Vegetal Cenariano. Ao esfolar suas presas na Selva Maleva, mantenha um sinalizador com você.\
\
Quando obtiver Retalhos Contaminados, traga-os para mim e entregarei alguns bálsamos já preparados.",c="É exatamente disso que preciso. Pegue estes Bálsamos Vegetais e use-os para recuperar a Selva Maleva da corrupção. Precisamos perseverar, $n!"},
    [4129]={p="Ginro mandou você, é?Minhas leituras psicométricas estão drenando bastante a minha psique… mas as minhas perdas no carteado kalimdoriano também. Me chamam de <Rei da Mão Azarada> aqui. Azar no jogo... sorte em dominar os segredos da natureza, eu acho.Enfim, claro que eu vou ajudar você. Esse pode ser exatamente o avanço que precisamos para descobrir o destino do Patiphe. Podemos começar assim que você me entregar a faca."},
    [4421]={d="Não são muitos os aventureiros que vêm para essas bandas... a corrupção da Selva Maleva se espalha de forma indiscriminada por aqui.\\n\\nComo parte do Círculo Esmeraldino, meu objetivo é curar essas terras, mas há aqueles que preferem vê-las apodrecer.\\n\\nEstou falando dos sátiros de Flamejade que vivem nas Ruínas de Constellas, a noroeste daqui. Liderados por um sátiro muito cruel chamado Xavathras, eles continuam transmitindo a doença para todas as criaturas que encontram\\n\\nTemos que defender essa terra que já foi nossa um dia. Derrote Xavathras e destrua seus lacaios."},
    [4862]={c="Que beleza! Olha só para esses ovos! Muito ouro vai sair de dentro deles.\
\
Como prometido, aqui está a sua criaturinha. Não deixe ela picar você!"},
    [5081]={p="Situação?"},
    [5248]={p="Amaldiçoooado... Para sempreeeee..."},
    [5504]={d="Seu serviço à Aurora Argêntea merece reconhecimento, $n. Você é verdadeiramente reverenciado entre nós. Fui autorizado a permitir que adquira um dos itens mais valiosos da Aurora: nossos mantos de resistência mágica.\
\
Aplicar um desses mantos às suas ombreiras aumentará sua resistência à magia de uma entre cinco maneiras. Como prova de sua dedicação contínua à causa, peço dez Símbolos de Bravura em troca do acesso aos mantos.",p="Ah, nobre $c! Trouxe os Símbolos de Bravura solicitados? Quando entregá-los, nossos diversos mantos ficarão disponíveis para compra."},
    [5507]={d="Seu serviço à Aurora Argêntea merece reconhecimento, $n. Você é verdadeiramente reverenciado entre nós. Fui autorizado a permitir que adquira um dos itens mais valiosos da Aurora: nossos mantos de resistência mágica.\
\
Aplicar um desses mantos às suas ombreiras aumentará sua resistência à magia de uma entre cinco maneiras. Como prova de sua dedicação contínua à causa, peço dez Símbolos de Bravura em troca do acesso aos mantos.",p="Ah, nobre $c! Trouxe os Símbolos de Bravura solicitados? Quando entregá-los, nossos diversos mantos ficarão disponíveis para compra."},
    [5722]={o="Investigue as Cavernas Ígneas à procura do corpo de Mauren Temível Totem e examine-o em busca de quaisquer itens de interesse.",c="O corpo está coberto de marcas de golpes, mas as roupas e o equipamento permanecem praticamente intactos. Parece que os troggs não dão muita importância a riquezas materiais.\
\
Você começa a revistar o corpo em busca de algo que possa interessar a Magatha."},
    [5725]={o="Leve os livros <Feitiços da Sombra> e <Encantamentos do Éter> para Varimatras na Cidade Baixa."},
    [5885]={p="Um Sinalizador Cenariano permite que um esfolador experiente identifique retalhos de pele contaminada nas criaturas caçadas na Selva Maleva. Transformo esses retalhos aparentemente inúteis em uma pasta espessa, usada como catalisador para o Bálsamo Vegetal Cenariano. Ao esfolar suas presas na Selva Maleva, mantenha um sinalizador com você.\
\
Quando obtiver Retalhos Contaminados, traga-os para mim e entregarei alguns bálsamos já preparados.",c="É exatamente disso que preciso. Pegue estes Bálsamos Vegetais e use-os para recuperar a Selva Maleva da corrupção. Precisamos perseverar, $n!"},
    [5890]={p="Um Sinalizador Cenariano permite que um esfolador experiente identifique retalhos de pele contaminada nas criaturas caçadas na Selva Maleva. Transformo esses retalhos aparentemente inúteis em uma pasta espessa, usada como catalisador para o Bálsamo Vegetal Cenariano. Ao esfolar suas presas na Selva Maleva, mantenha um sinalizador com você.\
\
Quando obtiver Retalhos Contaminados, traga-os para mim e entregarei alguns bálsamos já preparados.",c="É exatamente disso que preciso. Pegue estes Bálsamos Vegetais e use-os para recuperar a Selva Maleva da corrupção. Precisamos perseverar, $n!"},
    [6041]={c="Bah, estou te achando bem mais escuro do que me lembro. Tu tá com aquele jeito que diz: <Fui carbonizado por uma bomba altamente explosiva>.\
\
Leandro ri.\
\
Enfim! Toma aqui a tua parte. Acrescentei mais umas pilas para ajudar a cuidar das queimaduras."},
    [6362]={p="Há poeira dos Sertões em seus ombros. Você falou com meu amigo Jahan?"},
    [7486]={d="$n, os seus serviços para os Senhores da Guerra superaram todas as expectativas que tínhamos dos seres deste mundo.\
\
Não compreendemos as noções de gratidão do seu povo e nem como são feitas as recompensas, mas temos de tentar.\
\
Na ponta sul da ilha, abaixo das ondas, há uma arca. Lá encontrará a sua... recompensa.\
\
Vá, $n. Você fez por merecer."},
    [7623]={c="Minha paciência atravessa milênios, <class>. Mas não pense que isso lhe dá mais do que um instante do meu tempo..."},
    [7646]={c="São exemplares excelentes, <name> — as últimas peças finalmente estão no lugar. Enfim, chegou a sua hora!\
\
Nas profundezas do Grande Ossuário de Scolomântia estão os restos mortais de incontáveis seres. Entre eles há um corcel que um dia foi nobre. A alma esvaziada dessa criatura agora serve de montaria ao Cavaleiro da Morte Trevassol. É ele quem você enfrentará, e é sobre esse corcel que você dará seu veredito. Só você, <name>, pode redimir a alma dele e libertá-lo do tormento dessa servidão."},
    [8480]={d="Os Ignóbeis andam muito atrevidos, $n. Eles estão tão coordenados que lançaram um ataque ao Ancoradouro Velaclara.\
\
Como se isso já não fosse suficientemente embaraçoso, nossas armas ficaram para trás quando eles atacaram. Traga os armamentos de volta para que possamos mostrar àqueles rufiões quem manda aqui."},
    [8482]={d="Os documentos contêm mapas minuciosos de diversos prédios estratégicos na Floresta do Canto Eterno. Também há uma planta bastante detalhada do santuário arcano. Parece haver várias anotações em um idioma que você não consegue reconhecer.\\n\\nComo os documentos estavam nas mãos de um espião Darnassiano, talvez seja uma boa ideia mostrá-los para o capitão da guarda, Aledon Marcassol."},
    [8584]={d="Se tem uma coisa que você tem que saber sobre mim é o seguinte: NUNCA questione o meu trabalho! Eu lido com coisas que você jamais vai conseguir entender. Por exemplo... você sabe o que é um focinhódorfo psicotrônico? Claro que não! E é por isso que deixamos o planejamento comigo e a logística com você.\
\
Como eu já falei, pra isso aqui funcionar, vamos precisar de uma galinha de 250 quilos.\
\
Vá a Geringontzan e fale com Funesto Marrão. Ele deve orientar você quanto à aquisição de um espécime desses."},
    [8585]={p="Mmmmm... quimerok..."},
    [8892]={p="Ensinou uma lição àqueles Ignóbeis?"},
    [8897]={d="Tenho que montar guarda aqui nos portões, mas não paro de me preocupar com minha queria Colara. Só consigo vê-la por algumas horas, se tanto, e... Bem, olhe só para mim: o salário de tenente não é grande coisa e posso ser chamado à frente de batalha a qualquer momento.\
\
Será que ela vai se esquecer de mim? Tem muito homem na cidade! E muitos com muito dinheiro.\
\
De qualquer forma, eu escrevi algumas coisas... Nada de mais, mas seria ótimo se você pudesse entregar a mensagem para a minha querida."},
    [8924]={title="Caçando ectoplasma"},
    [8982]={title="Rastreando a fonte"},
    [8983]={title="Rastreando a fonte"},
    [8994]={c="É isso. Vou extrair o metal das braçadeiras e imbuir o braseiro com estes componentes finais. Depois, ele estará pronto para você evocar Lorde Valthalak e finalmente devolver o amuleto espiritual a ele.\\n\\nVocê percorreu um longo caminho, $n. Não vacile agora que o fim está à vista!"},
    [9026]={title="Rastreando a fonte"},
    [9027]={title="Rastreando a fonte"},
    [9137]={p="Para cada conjunto de Frondes Selvagens que entregar, você poderá escolher entre uma Insígnia da Aurora ou uma Insígnia da Cruzada.\
\
As insígnias podem ser entregues ao intendente em troca de diversas recompensas.",c="Obrigado, $n. Seu trabalho é essencial para o sucesso da nossa campanha contra o Flagelo."},
    [9195]={c="Agora você está falando a minha língua, <class>. Coisas que fazem BOOM!"},
    [9198]={c="Tubos de tório? Nossa, obrigado.\
\
<O Caravaneiro Esmagapedra joga a pilha de tubos de tório sobre um grande monte de sucata variada.>"},
    [9200]={c="A utilidade disto dispensa explicações."},
    [9266]={p="Você deve habernos feito algo realmente ruim a nós ou a nossos amigos, $n. Em qualquer caso, estou aqui para oferecer uma forma de recuperar nosso favor.\\nComo sabe, em Hibérnia do Hibérnia faz bastante frio. Com tantos goblins o que venimos de outras cidades, nos vendría bem uma mão para manter calientes. Traga-me um pouco de runatrama rúnica e carvão e você darei o perdão. No entanto, tenha em contao que a nossos inimigos não lhes agradará o que nos ajude."},
    [9359]={c="Veio ajudar? Excelente!\
\
A batalha contra os trolls Amani cobrou um preço alto, e combatentes capazes como você são sempre bem-vindos."},
    [9370]={p="Você voltou, $n. Pôs fim à loucura dos draeneis?"},
    [9425]={d="Ah, que bom ver você aqui, $c! Tenho uma tarefa muito propícia para você.\
\
Como recém-chegados à Horda, precisamos dar apoio às empreitadas deles e ajudar a resolver os problemas que tiverem. Assim, eles ficarão mais propensos a nos ajudar quando for preciso.\
\
Quero que vá até a cidade dos Renegados, Serraria Tarren, no Contraforte de Eira dos Montes. É em direção ao sudeste. Fale com a Conselheira Crepax quando chegar."},
    [9432]={d="Fico feliz que estejas aqui para nos ajudar. Na verdade, há algo que podes fazer.\
\
Como parte de nosso ingresso na Aliança, quero que viajes para Astranaar, a cidade dos elfos noturnos. Ela fica no Vale Gris, uma grande floresta ao sul da Costa Negra, no continente de Kalimdor.\
\
Ao chegares, fala com Vindicante Palais e vê se há algo que podes fazer para ajudar os habitantes do local."},
    [9565]={title="Vasculhe a Aldeia de Pinhoquieto"},
    [9643]={c="Estas vinhas parecem resistentes o bastante para o trabalho. Obrigado pela ajuda, <name>. Sua contribuição para a defesa da Vigília de Sangue não será esquecida."},
    [9742]={p="Resgatou mais sacos de esporos, $r?"},
    [9914]={c="Nunca duvidei de você nem por um segundo, amigo. A maioria destas presas está em ótimo estado, apesar de um pouco suja e arranhada. Ainda assim, acredito que valham o preço que combinamos.\
\
Espero que possamos continuar fazendo negócios no futuro."},
    [10042]={c="Notícias terríveis! Parece que acertei ao enviar você para ajudar Semanas. A última coisa de que precisamos é o Concílio das Sombras se estabelecendo bem diante de nossas portas.\
\
$n, em reconhecimento aos seus esforços na Aldeia Grangol'var, concedo a você o direito de escolher uma destas recompensas."},
    [10067]={d="Todas as criaturas tocadas pela energia dos cristais sofreram corrupção semelhante: estranhas marcas na pele, agressividade aumentada e pequenas estilhas de cristal no corpo. No entanto, os espíritos da água que foram corrompidos a norte daqui aparentemente estão se transformando em cristais por inteiro.\
\
Jamais testemunhei reação semelhante aos cristais. Quando exploramos o poço corrompido, notamos agressividade sem par. Temos que dar fim a tais espíritos antes que os Falconélius os explorem como nova fonte de energia."},
    [10091]={c="To'gun esteve aqui há pouco para apresentar o relatório. Ele deveria ter ficado com você para ajudar!\
\
Mandei-o de volta para auxiliar Grik'tha. Acho que os dois formam um belo casal.\
\
Então estes são os dispositivos de alma que o Concílio das Sombras usava para fortalecer suas evocações? Parecem perigosos. Talvez os Áugures saibam o que fazer com eles.\
\
Por favor, aceite uma destas recompensas por ter prejudicado a operação do Concílio das Sombras no labirinto."},
    [10407]={p="Conseguiu a Pedra de Teleporte de Socrethar, $n?"},
    [10419]={p="Conseguiu mais tomos arcanos, $n?"},
    [10435]={title="Recuperando a mercadoria"},
    [10446]={c="O VOCÊ CONSEGUIU! NOS VOCÊ SALVOU! VOCÊ SALVOU O FORTALEZA ALLERIANA!!\\nCom seus tropas diezmadas, seu líder morto e a bomba de mana destruída, todos podemos respirar com muita mais facilidade agora.\\n$n, nunca havia visto tanto altruísmo... tanto heroísmo! Você o favor, leve isto em nome de todos nós."},
    [10447]={c="O VOCÊ CONSEGUIU! NOS VOCÊ SALVOU! VOCÊ SALVOU O FORTALEZA ALLERIANA!!\\nCom seus tropas diezmadas, seu líder morto e a bomba de mana destruída, todos podemos respirar com muita mais facilidade agora.\\n$n, nunca havia visto tanto altruísmo... tanto heroísmo! Você o favor, leve isto em nome de todos nós."},
    [10478]={p="Conseguiu mais contas de guerra, $n?"},
    [10504]={c="Suas ações contra os clãs Malho e Giralança do Lâmina têm significado um grande passo em diante a hora de garantir o futuro de Sylvanaar. Sim bem não pretendemos expandirnos mais a deste estilhaço de terrao que, inicialmente, encontramos caos, também estamos dispostos a permitir o que nos destruyan.\\nComo nos você fez um grande serviço, o recompensarei com ou reconhecimento e o agradecimento da Aliança."},
    [10508]={p="Conseguiu a Pedra de Teleporte de Socrethar, $n?"},
    [10560]={d="<O tom melódico e relajante proyectado pela'dal se faz más quedo e sombria.>\\n<Te amostra grande estrutura naarus conhecida como O Bastilha da Tormenta. Agora está habitado pelas tropas de Kael'thas e seu poder, utilizado com propósitos vis. A'dal te promete instruções más importantes quando tenha feito sua parte para recuperar O Bastilha da Tormenta.>",c="<A'dal parece estar muito satisfeito com você. Com sua ajuda, o Bastilha da Tormenta será recuperado algum día das garras do mal.>"},
    [10562]={p="Já se cansou, $c?"},
    [10595]={p="Já se cansou, $c?"},
    [10857]={p="Então está feito? Os teleportadores foram desativados?"},
    [10945]={title="Hch'uu e o Povo dos Cogumelos"},
    [11007]={title="Kael'thas e a Esfera Verdejante"},
    [11030]={d="$c, temos um problema: temos muitos filhos. Desde que a Guarda Aérea se instalou aqui perto, eles só falam em entrar para suas fileiras.\\n\\nComo pais orgulhosos, queremos que tenham toda vantagem possível quando se candidatarem. Você poderia ir até a Forja de Cristal Vil, em um dos acampamentos da Forja ao norte ou ao sul, e conseguir um frasco mágico para eles? É impossível não notar a fumaça verde.\\n\\nAcreditamos que sejam necessários 10 Estilhaços de Apexis para criá-lo. Nós lhe daríamos os estilhaços, mas não temos nenhum no momento."},
    [11178]={c="O-o próprio Sangue de Zul'jin, está dizendo?\\n\\n<Budd se recompõe antes de continuar.>\\n\\nBem, agradeço o gesto, $c, mas eu poderia ter derrotado Zul'jin com facilidade. Não há como ele ser tão assustador quanto afirmam as lendas. Com o tempo, você aprenderá que essas histórias costumam ser terrivelmente exageradas. O mais provável é que aquele velho miserável tenha sido vencido pela artrite!\\n\\nDe qualquer maneira, suponho que isso seja o mínimo que poderia fazer para pagar toda a gentileza que demonstrei por aqui.\\n\\nAgora vá embora. Preciso me livrar deste frasco repugnante!"},
    [11209]={c="Nada mal, mas, se eu fosse você, tomaria um banho o quanto antes.\
\
Agora, sobre seu monstro marinho...\
\
Enquanto isso, sirva-se de uma bebida ou duas."},
    [11210]={d="Sim, não há dúvida de que Tethyr é real e vive nas águas de Theramore.\
\
Ele tem uma queda por luzes fortes. Foi por causa dele que apagaram o farol, sabia?\
\
Se acenderem o farol de novo, ele voltará. Mas ninguém em sã consciência faria uma coisa dessas.\
\
Então esse deve ser o seu plano! Foi bom dividir uma bebida com você, mas não culpe o velho Nat se Tethyr REALMENTE transformar você em isca de peixe. Se pretende levar isso adiante, fale antes com o Major Mills nas docas de Theramore."},
    [11214]={d="O Cartel Bondebico estabeleceu recentemente um novo posto avançado na parte sul do Pântano Vadeoso. Se não me engano, chama-se Coroa de Barro e fica na estrada principal, ao sul da Fazenda de Tabetha e das Ruínas Pedramalho.\
\
É uma excelente oportunidade para estabelecermos novas relações comerciais, e Grã-senhora Jaina quer que eu envie um representante para fazer contato. Você estaria disposto a ir?",c="Então Theramore está interessada em fazer negócios? Essa é uma oferta que eu não recusaria. Os suprimentos estão bem escassos por aqui, então precisamos de todos os contatos comerciais que pudermos conseguir!"},
    [11270]={p="Não me importa quantos gigantes, dragões ou kobolds você já matou. Termine este trabalho e volte quando estiver pronto."},
    [11300]={c="Que história fascinante! Algo está realmente julgando essas coisas? Por quê?! Para quê?\
\
Bem, deixe essa besteirada para lá. Outra pessoa pode decifrar essas coisas aí. Conseguimos recuperar o código e as tabuletas – com apenas duas mortes no frigir dos ovos."},
    [11318]={o="Cavalgue o carneiro e mantenha cada um dos três níveis de velocidade durante 8 segundos. Você tem 4 minutos.",p="Conseguiu dominar as três velocidades?",c="Muito bem! Leva algum tempo para dominar um carneiro de corrida, mas depois disso qualquer montaria comum parece lenta.\
\
Onde está sua recompensa? Ora, você acabou de montar um dos carneiros mais rápidos da região! Ainda quer mais? Então ajude o pessoal da CervaFest. Há bastante trabalho — e boas recompensas — para quem tem disposição."},
    [11381]={c="Isso é uma excelente panela de sopa espiritual sim alguma vez tenho olido uma. Apenas um toque de pimienta e esta pronta.\\nComo prometi, aqui tem sua parte. E porque fez um trabalho tão excelente, você darei algo extra de meu stock."},
    [11394]={c="Arlindo parece entusiasmado com o sucesso, mas faz um gesto para falarem baixo.\
\
Bom trabalho, $n! Mas suas coisas ficaram cheias de gosma de Flagelo. Talvez seja boa ideia você dar um mergulhinho. A água está fria, mas vai limpar você em dois tempos."},
    [11498]={c="Sangue e trovão, Nutral me mandou outro soldado de chão! Bom homem... para um draenei.\
\
<Olrokk cospe no chão perto dos seus pés.>\
\
Veio ao lugar certo se quer aprender a conduzir sua própria montaria pelos céus. Em troca de um belo saco de ouro, vou ensinar o que precisa saber para não cair vergonhosamente rumo à morte.\
\
E quando terminar, não se esqueça de falar com Dama Crina Selvagem ali sobre comprar um dos corredores do vento do nosso estábulo!"},
    [11519]={c="Arrr, eu e minha tripulação roubamos aquele escudo! Estamos tentando recuperá-lo daquele marujo de água doce imprestável, Sorlof! Veio ajudar, arrr?\
\
Como pode ver, estamos operando com uma tripulação mínima!\
\
<Capitão Ellis ri.>\
\
Sister Mercy precisa de mais um ajudante da pólvora para operar os canhões grandes no convés de popa. Acha que dá conta, camarada?\
\
Ajude minha tripulação a derrubar Sorlof e dividiremos o butim! Você fica com o escudo; eu e minha tripulação ficamos com o resto!"},
    [11689]={c="Que notícias me traz de Chapadalta?\
\
Você explica o que sabe e dá a má notícia à grande mãe sobre o pisaléguas Chifre Peludo.\
\
Meu... meu neto!\
\
A grande mãe luta para controlar suas emoções.\
\
Ele morreu de forma honrada como um verdadeiro taunka!\
\
Você foi a última a estar com ele, $n. Ele será eternamente parte de você. Agradeço profundamente por ter realizado seus últimos desejos."},
    [11881]={c="<Fazzix examinão butim.>\\nJenny esta um pouco hetaera, mas se recuperará. Assim o que ao butim, é um pouco mais... a estilhaços do que esperava, mas deveria poder encontrarle alguma utilidade. Não estás livre de responsabilidades ainda. Vamos a reconstruir esta máquina."},
    [12006]={c="Muito bem. Pelo menos, você atendeu meu pedido.\
\
Obrigada, draenei."},
    [12168]={d="Uma inscrição nas costas do objeto diz:\
\
<Para meu pupilo favorito.\
\
Se continuar progredindo assim, ensinarei a você coisas além da imaginação.\
\
Caso contrário, eu o destruirei!\
\
Do seu,\
\
Grão-sectário Zangus>\
\
Sem dúvida os guardiães no Recanto das Estrelas vão querer ver isso."},
    [12194]={c="O que é isto? Um vale-caneca? Então você gosta de beber? Ótimo! Depois que eu entregar esta caneca, vá tomar umas bebidas! Depois mais algumas. Talvez mais umas depois dessas... E então, isto é importante, volte para falar comigo.\
\
Olha, sei que você vai voltar cedo ou tarde. Se quiser trocar fichas da CervaFest, precisa falar comigo.\
\
Enfim, aqui está a caneca. E lembre-se de voltar depois."},
    [12234]={title="Precisamos saber"},
    [12262]={p="Vejo sangue em suas mãos... Então está feito?",c="Eles imploraram por suas vidas miseráveis? Fracos."},
    [12463]={c="<Você encontra um diário no cadáver de Barba de Saqueador.>\
\
Entrada Um:\
\
Eles arrastam cadáveres pelo túnel até a sala de embalsamamento para fazer experimentos. Há um suprimento infinito neste mausoléu. Tudo o que não pode ser reanimado é transformado em algum tipo de construto de ossos.\
\
Entrada Dois:\
\
Temo que este lich, Thel'zan, esconda um segredo sombrio. Quem é ele? Será que já foi... um de nós?\
\
Entrada Três: Descobri a localização do filactério do lich. Fica...\
\
<O restante das páginas foi arrancado.>"},
    [12523]={d="Ótimo, agora que temos o motor, vamos precisar de um sortimento de peças para que a máquina possa voar novamente. Não se preocupe, sei o que estou fazendo.\
\
Um bom mecânico é capaz de cuidar de suas criações com qualquer coisa, mas claro que é melhor não chegarmos a esse ponto.\
\
De qualquer forma, aqueles idiotas da Empreendimentos S.A. têm montes de peças extras de mineração espalhadas por toda a Escavação do Caloteiro, que fica além daquele pilar de cristal amarelo a nordeste. Colete algumas peças e traga-as para mim."},
    [12604]={c="Você fez excelente tempo em essa ronda. Parece o que poderá ser de utilidade para nós depois de todo.\\nComo prometi, aqui tem um pequeno incentivo por sua esforço.\\nSiga assim, $n.\\nEstas despedido."},
    [12668]={d="Tenho algo especial preparado para meus altos sacerdotes prediletos, mas primeiro quero que se prove útil preparando a base para a minha vingança.\
\
Ainda quer viver, não quer?\
\
Como viu, meus devotos estão gostando de ficar aqui, mas chegou a hora do acerto final de contas.\
\
Você me faria um pequeno favor, $n? Atraia-os para perto das minhas fontes de almas e depois ponha um fim à vida deles.\
\
Eles têm gosto muito bom e o sacrifício deles não será em vão, posso garantir."},
    [13043]={p="Você recuperou o tomo do doutor, mas não acabou com ele usando o gigante de carne?\
\
Volte lá e mate-o antes que seja tarde demais!"},
    [13164]={p="Finalmente estamos livres daquele aspirante a Arthas?"},
    [13190]={c="Ah!\
\
Que o odor zombeteiro do fracasso consuma as almas vazias deles!\
\
Obrigado, $c. Hoje você desferiu um golpe contra os mortos-vivos."},
    [13307]={p="Você matou os portadores dos estandartes e impediu a tentativa deles de usar os caídos contra nós?"},
    [13539]={p="Meu desprezo pelos bruxos só é superado pelo ódio que sinto pelos mortos-vivos. Ainda assim, ambos podem ser úteis de vez em quando.",c="Para derrotar o inimigo, nossos homens precisam ser tomados pela fúria; para que a vitória tenha valor, devem receber sua recompensa. Espero que isto seja suficiente por seu serviço à Horda."},
    [13931]={c="O que é isto? Um vale-caneca? Então você gosta de beber? Ótimo! Depois que eu entregar esta caneca, vá tomar umas bebidas! Depois mais algumas. Talvez mais umas depois dessas... E então, isto é importante, volte para falar comigo.\
\
Olha, sei que você vai voltar cedo ou tarde. Se quiser trocar fichas da CervaFest, precisa falar comigo.\
\
Enfim, aqui está a caneca. E lembre-se de voltar depois."},
    [14095]={p="O que você encontrou, campeão?"},
    [14206]={d="Por ordem de Sua Alteza Real, todos os cidadãos aptos da Aliança devem se apresentar a Manivela Chumbomela, na Angra do Butim.\
\
Siga ao sul pelo Cabo do Espinhaço até a movimentada cidade portuária goblínica. Manivela fica próximo às docas e precisa de ajuda em tarefas importantes para o equilíbrio de poder na região.\
\
Pela glória e honra da Aliança!",o="Apresente-se a Manivela Chumbomela na Angra do Butim, no Cabo do Espinhaço."},
    [14207]={d="Por ordem de Sua Alteza Real, todos os cidadãos aptos da Aliança devem se apresentar ao Intendente Lungertz, na Fortaleza de Etergarde.\
\
A guarnição precisa urgentemente de ajuda na Barreira do Inferno. Siga ao sul pelo Pântano das Mágoas e tome a estrada para leste até a fortaleza.\
\
Pela glória e honra da Aliança!",o="Apresente-se ao Intendente Lungertz na Fortaleza de Etergarde."},
    [14208]={d="Por ordem de Sua Alteza Real, todos os cidadãos aptos da Aliança devem se apresentar à Comandante Althea Ebanez, em Vila Sombria.\
\
Para chegar a Vila Sombria, no Bosque do Crepúsculo, siga pela estrada ao sul entre a Floresta de Elwynn e as Montanhas Cristarrubra.\
\
Pela glória e honra da Aliança!",o="Apresente-se à Comandante Althea Ebanez em Vila Sombria, no Bosque do Crepúsculo."},
    [14210]={d="Por ordem de Sua Alteza Real, todos os cidadãos aptos da Aliança devem se apresentar a Oralius, na Vigília de Morgan, nas Estepes Ardentes.\
\
Sua ajuda é urgente para deter a ameaça dos orcs Rocha Negra. Atravesse a Montanha Rocha Negra ao sul da Garganta Abrasadora para chegar às Estepes Ardentes.\
\
Pela glória e honra da Aliança!",o="Apresente-se a Oralius na Vigília de Morgan, nas Estepes Ardentes."},
    [14230]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Greta Casco Musgoso no Santuário Esmeralda, na Selva Maleva.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Greta Casco Musgoso no Santuário Esmeralda, na Selva Maleva."},
    [14231]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Mitsuwa no Posto Avançado Zoram'gar, no Vale Gris.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Mitsuwa no Posto Avançado Zoram'gar, no Vale Gris."},
    [14232]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Sergra Espinho Negro na Encruzilhada, nos Sertões.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Sergra Espinho Negro na Encruzilhada, nos Sertões."},
    [14233]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Mebok Borratrelha em Vila Catraca, nos Sertões.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Mebok Borratrelha em Vila Catraca, nos Sertões."},
    [14234]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Maggran Moldaterra no Retiro Rocha do Sol, nas Cordilheiras das Torres de Pedra.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Maggran Moldaterra no Retiro Rocha do Sol, nas Cordilheiras das Torres de Pedra."},
    [14235]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Takata Lamináurea no Posto do Andarilho Fantasma, em Desolação.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Takata Lamináurea no Posto do Andarilho Fantasma, em Desolação."},
    [14236]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Krog na Aldeia Muralha Verde, no Pântano Vadeoso.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Krog na Aldeia Muralha Verde, no Pântano Vadeoso."},
    [14237]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Mandingueiro Uzer'i no Acampamento Mojache, em Feralas.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Mandingueiro Uzer'i no Acampamento Mojache, em Feralas."},
    [14238]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Hagar Casco de Raio no Morro Livre dos Ventos, nas Mil Agulhas.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Hagar Casco de Raio no Morro Livre dos Ventos, nas Mil Agulhas."},
    [14239]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Engenheiro-chefe Parafuseta em Geringontzan, em Tanaris.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Engenheiro-chefe Parafuseta em Geringontzan, em Tanaris."},
    [14240]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Williden Marechal no Refúgio do Marechal, na Cratera Un'Goro.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Williden Marechal no Refúgio do Marechal, na Cratera Un'Goro."},
    [14241]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Clamaventos Chifre Altivo no Forte Cenariano, em Silithus.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Clamaventos Chifre Altivo no Forte Cenariano, em Silithus."},
    [14242]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Dalar Tecelauro no Sepulcro, na Floresta de Pinhaprata.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Dalar Tecelauro no Sepulcro, na Floresta de Pinhaprata."},
    [14243]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Sicário Samsa na Serraria Tarren, na Contraforte de Eira dos Montes.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Sicário Samsa na Serraria Tarren, na Contraforte de Eira dos Montes."},
    [14244]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Tor'gan em Ruína do Martelo, nas Terras Altas Arathi.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Tor'gan em Ruína do Martelo, nas Terras Altas Arathi."},
    [14245]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Otho Moji'ko na Aldeia Revatusco, nas Terras Agrestes.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Otho Moji'ko na Aldeia Revatusco, nas Terras Agrestes."},
    [14246]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Alto-executor Derrington no Baluarte, nas Terras Pestilentas Ocidentais.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Alto-executor Derrington no Baluarte, nas Terras Pestilentas Ocidentais."},
    [14247]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Arquimaga Angela Dosantos na Capela Esperança da Luz, nas Terras Pestilentas Orientais.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Arquimaga Angela Dosantos na Capela Esperança da Luz, nas Terras Pestilentas Orientais."},
    [14248]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Hansel Mãos-pesadas no Posto de Tório, na Garganta Abrasadora.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Hansel Mãos-pesadas no Posto de Tório, na Garganta Abrasadora."},
    [14249]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Gorn em Karrath, nos Ermos.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Gorn em Karrath, nos Ermos."},
    [14250]={d="Por ordem do Chefe Guerreiro, todos os membros aptos da Horda devem se apresentar a Dar em Pedregal, no Pântano das Mágoas.\
\
As forças da Horda na região precisam de reforços. O destino chama!",o="Apresente-se a Dar em Pedregal, no Pântano das Mágoas."},
    [14502]={d="As palavras gravadas na esfera parecem se fixar em sua memória.\
\
'Anseio furiosamente para ser encontrado,\
mas meus gritos se calam sob o chão.\
Acima de mim, ouço ao longe o trovão,\
abafado pelos rosnados do demônio que abomino.'\
\
Você sente que isso levará à terceira pista."},
    [17006]={p="Os Défias já foram eliminados?",c="Ah, graças à Luz — e graças a você, herói. Hoje você prestou um grande serviço ao rei. Agora só preciso encontrar homens disponíveis para entregar estes suprimentos."},
    [17009]={d="O mapa está manchado de algas e sujeira. Por sorte, parece haver um texto rabiscado perto da parte inferior que você mal consegue ler.\
\
\\\\\\\"Não acredito que escapamos daqueles horríveis 'peixes-coisa' com vida e ainda conseguimos levar o tesouro deles! Marquei o mapa para não esquecer onde escondi o saque. Seria uma pena chegar tão longe só para esquecer em qual navio joguei o baú. Vou deixar este mapa em algum lugar seguro, onde olhos curiosos nem pensarão em procurar.\\\\\\\" Há mais rabiscos, mas você não consegue decifrá-los.\
\
Não é muita informação, mas tudo indica que o tesouro mencionado no mapa está escondido sob as ondas, em um dos navios naufragados."},
    [17894]={d="Herói, notícias preocupantes desde A Desolação em ruínas. Elementais caóticos - monstruosidades warp e truenadores desgarrados - têm proliferado sem controle, amenazando com sobrepasar a região. Seu solfúria primitiva deve ser contenida antes do que se cause mais dano Preciso o que viagens a Desolação e reduzcas a estes feroces elementais! Elimine as monstruosidades e detenha aos truenadores para restablecer o equilíbrio."},
    [18057]={d="Herói, o vil necromante Kethrevon, o Sombrio, surgiu na aldeia amaldiçoada conhecida como Gahrron's Withering. Sua magia profana ergue legiões de sombras que assolam a terra e atacam tudo o que vive. Peço a você, bravo campeão: cace esse vilão e ponha fim ao mal antes que ele se espalhe. Vá até Gahrron's Withering, resista aos poderes sombrios de Kethrevon e mate-o para encerrar seu reinado de trevas."},
    [24499]={c="O Fosso de Saron nos aguarda e, se nossos batedores estiverem certos, depois do fosso encontram-se os Salões da Reflexão.\
\
É neles que Arthas baixa a guarda, e é neles que esperamos encontrar uma pista sobre o ponto fraco dele... ou talvez, quem sabe, a redenção de Arthas."},
    [24562]={c="Espero que entenda que não posso simplesmente permitir sua entrada na Nascente do Sol, $n. Este é o lugar mais sagrado dos sin'dorei, e só recentemente recuperamos o controle dele.\
\
Você pretende alimentar as esperanças do nosso povo com histórias sobre Quel'Delar? Sem uma prova da veracidade de suas afirmações, não tenho motivo para acreditar em sua palavra."},
    [24597]={c="Obrigado pela Pulseira de Patuás Adoráveis."},
    [25343]={d="Você tem se saído bem, $n, mas nosso grupo não se limita a tarefas fúteis. Tenho certeza de que ouviu falar disso quando se juntou a nós.\
\
Como sabe, o fim do mundo está próximo e todos que não estiverem preparados sofrerão uma morte horrenda.\
\
Nos foi oferecido um presente, uma oportunidade de nos tornarmos pessoas mais poderosas. O Feitor Golbaz está se preparando para um ritual no altar, que fica no extremo leste da fazenda. Espere por ele lá e aprenda mais sobre seus novos irmãos e irmãs."},
    [25416]={d="Você tem se saído bem, $n, mas não somos um grupo que se limita a tarefas fúteis. Tenho certeza de que ouviu falar disso quando se juntou a nós.\
\
Como sabe, o fim do mundo está próximo e todos que não estiverem preparados sofrerão uma morte horrenda.\
\
Nos foi oferecido um presente, uma oportunidade de nos tornarmos pessoas mais poderosas. O feitor Talathor está se preparando para um ritual no altar a oeste do pomar. Espere por ele lá e aprenda mais sobre seus novos irmãos e irmãs."},
    [26034]={c="Krasus escuta com atenção você relatar a batalha com Halion. Os olhos dele se arregalam ao ouvir a menção de Asa da Morte.\
\
Estamos em débito com você, mortal, por expulsar os invasores do Santuário. Mas o que está me dizendo sobre o Destruidor é terrível demais até para ser colocado em palavras! Tenho muito o que discutir com os outros membros do Conselho.\
\
Aceite isto como prova de minha gratidão, e que a sua raça se prepare para a tempestade que se avizinha."},
    [28442]={c="Sim, muito bem. Tenho estado esperando isto para um de meus experimentos. Você pode fazer explodir um fantasma? Ninguém o sabe, mas poderíamos estar um passo mais perto de descobrir.\\nEm qualquer caso, aqui tem sua pagamento."},
    [28467]={c="Sim, muito bem. Tenho estado esperando isto para um de meus experimentos. Você pode fazer explodir um fantasma? Ninguém o sabe, mas poderíamos estar um passo mais perto de descobrir.\\nEm qualquer caso, aqui tem sua pagamento."},
    [28618]={d="Serpes. Grandes, enfurecidos e perigosos. Tem um montón o que vive exatamente ao leste daqui e me dizer -- são valiosos. Cada escama vale uma pilha de moedas sim sabe onde venderla. E essa informações é algo o que você não pode permitir que você.\\nAssim o que, vamos um acordo. Cima 5 Escamas Desgastadas de Dragão. Podem não parece grande coisa agora, mas com um pouco de pulido e barniz, transformaremos fera em butim."},
    [28636]={d="Ah, um minero. Tenho um trabalho para você.\\nDe vez em quando, uma obra requer algo o que não seja minério común e saliva. Algo com um brilho especial, como da lua e tudo o que os elfos se emocionan por isso.\\nEm fim, traga-me 5 Varillas de prata. Tenho uma tarefa aqui em Auberdine o que precisa o brilho exacto, e a prata é perfeita para isso."},
    [28660]={d="Ah, um minero. Tenho uma missão para você.\\nSebastian ali e eu... bem, não nos llevamos bem. Este mausoléu não é o suficiente grande para os dois depois do incidente de pulgas e garrapatas, mas aqui é onde temos o que estar para apoyar aos Death Stalkers.\\nDe qualquer forma, cima Sebastian 5 Varillas de prata. Tenho uma comisión o que precisao que ele a maneje não Sepulcro e precisa precisamente esse brilho, e a prata se ajusta ao caso. O mensagem será recebido melhor vindo de você."},
    [28661]={c="Ah, um trabalho prazeroso! Agora que tenho os materiais adequados, a encomenda de Jahan será fácil. Obrigado, $c."},
    [28667]={d="Ei, você! Estou vendo essa picareta que carrega. Estou recrutando você para uma tarefa em nome da Horda.\
\
Está vendo aquela forja ali? Nós a montamos, mas os ogros ainda não pegaram o jeito porque não têm materiais armazenados. É aí que você entra. Traga-me 20 Minérios de Ferro para mostrarmos a esses ogros como funciona a fundição.",o="Nazeer Bloodpike quer que você use sua perícia em Mineração para coletar 20 Minérios de Ferro e leve a encomenda até ele, na Aldeia Muralha Verde, no Pântano Vadeoso.",c="Ah! Ferro de verdade, não sucata recolhida por aí. Com isto eu consigo trabalhar. Está liberado, <name>. Pode cuidar dos seus assuntos."},
    [28672]={o="Fizit quer que você use sua perícia em Mineração para obter 20 Barras de Tório e leve a encomenda até ele, em Valormok, Azshara.",p="Ainda vai levar algum tempo até conseguirmos oferecer todos os serviços de criação em Valormok, mas isto nos deixa um passo mais perto."},
    [28673]={d="O Tenente Rainer vem patrulhando a Guarnição do Arroio do Oeste com uma camisa que mais parece um trapo desde uma emboscada de gnolls na semana passada. Ele se recusa a parar para consertá-la — diz que isso fortalece o caráter.\
\
Se você tiver habilidade, poderia confeccionar duas Camisas Azuis de Linho e levá-las até ele? Talvez não admita, mas sei que apreciaria o gesto. Só não deixe que ele convença você a costurar o guarda-roupa inteiro.",o="Sara Timberlain quer que você use sua perícia em Alfaiataria para confeccionar 2 Camisas Azuis de Linho e leve a encomenda ao Tenente Rainer, na Guarnição do Arroio do Oeste, na Floresta de Elwynn.",p="Malditos gnolls! Estou começando a congelar aqui fora.",c="Ora, veja só! As costuras estão firmes, a cor está certa... você se superou. Sara pensou em tudo — menos no quanto eu odeio ficar devendo favores. Então pegue estes suprimentos e ficamos quites."},
    [28676]={d="Marleth, lá na Aldeia da Cevada, voltou a queimar os dedos no alambique. Diz que as luvas antigas finalmente ficaram duras e quebradiças depois de anos mexendo com caldeirões ferventes.\
\
Se você souber usar uma agulha, faça para ela um novo par de Luvas Pesadas de Linho. Ela não vai pedir ajuda por conta própria, mas acredite: as cervejas dela não terão o mesmo sabor se ela fizer careta toda vez que mexer o caldeirão.",o="Uthrar Threx quer que você use sua perícia em Alfaiataria para confeccionar 1 par de Luvas Pesadas de Linho e leve a encomenda até Marleth Barleybrew, na Aldeia da Cevada, em Dun Morogh.",p="Veio esquentar a barriga com uma Cerveja Cevada?"},
    [28678]={d="Vesprystus pode cruzar os céus, mas as botas dele não ficam longe do chão por muito tempo. Entre cuidar dos hipogrifos e levar despachos, o par antigo está se desfazendo nas costuras.\
\
Se puder confeccionar um novo par de Botas Simples de Linho, entregue-o a Vesprystus na Vila de Rut'theran. Ele não vai pedir substituição por conta própria, mas acho que já merece algo melhor do que farpas nas solas.",o="Trianna quer que você use sua perícia em Alfaiataria para confeccionar 1 par de Botas Simples de Linho e leve a encomenda até Vesprystus, na Vila de Rut'theran, em Teldrassil.",c="Um excelente par de botas! O céu sempre parece mais bonito quando seus pés não doem ao aterrissar."},
    [28681]={d="Balthule está há semanas de posto na Torre de Althalaxx, exposto aos ventos frios do mar e à escuridão que se espalha lá de dentro. Ele não abandona o posto — nem mesmo para buscar um manto.\
\
É aí que alguém com sua habilidade de Alfaiataria entra. Gostaria que você confeccionasse para ele um Manto com Fecho de Pérola que ofereça um pouco de calor e conforto. Entregue-o no norte da Costa Negra, para lembrá-lo de que, mesmo quando o dever chama, ele não foi esquecido."},
    [28683]={c="Pelas barbas de Moradin! Estas vão carregar o dobro de pedras com metade da dor nas costas. Você me fez um grande favor. Talvez agora eu encontre espaço para aquela pedra azul estranha..."},
    [28684]={d="Chegou notícia do dique: o Montanhês Haggil levou um tombo e rasgou as calças de alto a baixo ao descer por uma viga de sustentação. Desde então vem remendando tudo com barbante e teimosia.\
\
Se não se importar em cuidar desta encomenda também, confeccione uma Calça de Linho Costurada à Mão e leve-a até o Dique Lapidado.",o="Aldren Cordon quer que você use sua perícia em Alfaiataria para confeccionar 1 Calça de Linho Costurada à Mão e leve a encomenda ao Montanhês Haggil, no Dique Lapidado, em Loch Modan.",c="Que alívio! Eu estava a duas rajadas de vento de causar um escândalo. Você mereceu alguns suprimentos extras!"},
    [28686]={d="Então Danielle acha que estou suspirando por aquele vigia velho e sem graça? Nem pensar! Meu pretendente tem estilo. Ambição. Contatos. Ele é... bem, um goblin. Mas não qualquer goblin — Kzixx, o comerciante de bom gosto.\
\
Já que Danielle quer transformar isso numa competição, vou entrar no jogo. Confeccione um Colete de Seda Lazúli para Kzixx. Ele vai ficar tão impressionado que aposto que esquecerá aquela oferecida de Vila Plácida!",o="Sheri Zipstitch quer que você use sua perícia em Alfaiataria para confeccionar 1 Colete de Seda Lazúli e leve a encomenda até Kzixx, na Margem Escurecida, na Floresta do Crepúsculo.",c="Ora, isto é seda da melhor qualidade! Um presente de Sheri Zipstitch... Quem é essa? Suprimentos de alfaiataria em Vila Sombria? Hmm... talvez seja um contato comercial valioso. Obrigado pela dica!"},
    [28688]={d="Já me decidi! Cansei de servir bebidas a gente ingrata quando o que quero é estudar pergaminhos. Ofereceram-me uma vaga de aprendiz na Torre de Azora, e pretendo aceitá-la.\
\
Mas, se vou para a Torre, preciso parecer uma maga. Se você puder confeccionar duas Vestes Menores de Mago para mim, significaria muito. Quero que me vejam não apenas como uma aluna, mas como alguém pronta para se tornar maga.",o="Gretchen Vogel quer que você use sua perícia em Alfaiataria para confeccionar 2 Vestes Menores de Mago e leve a encomenda até ela, em Vila Plácida, nas Montanhas Cristarrubra."},
    [28700]={o="Vhan quer que você use sua perícia em Alfaiataria para confeccionar 1 par de Luvas Pesadas de Linho e leve a encomenda até Pawe Mistrunner, no Platô dos Espíritos, em Penhasco do Trovão, Mulgore."},
    [28701]={d="Merril Wendyl maneja as Pedras de Praga em nome de nossos paladinos, e a suciidade de essas pedras mancha seus túnicas até hacerlas irreconocibles. É uma palavra?\\nDe qualquer forma, poderia usar algumas novas Túnicas brancas de linho mas não tenho tido tempo para ocuparme de isso. Poderia praticar fazendo as túnicas."},
    [28708]={o="Mahani quer que você use sua perícia em Alfaiataria para confeccionar 1 Calça de Linho Costurada à Mão e leve a encomenda até Brine, na Serra do Espinho Negro, ao sul dos Sertões.",c="Agradeço aos elementos! Eu estava a duas rajadas de vento de causar um escândalo. Você conquistou minha gratidão!"},
    [33706]={d="Outra alma atraída pela lâmina... outro peão da minha dor.\
\
Sussurro... minha alma...\
\
Eu a forjei para desafiar a Legião... mas ela me foi arrancada pela traição e pela morte.\
\
Desde então, meu espírito vaga, alcançando o outro lado do véu e se agarrando à lâmina que um dia fez parte de mim.\
\
A Guerra dos Antigos destruiu mais do que pedra e carne. Destruiu juramentos. Destruiu a fé.\
\
Sussurro não é amaldiçoada pelo mal, mas pela saudade... pela minha saudade.\
\
Você, mortal... ouviu os lamentos, não ouviu? Os gritos através da lâmina?\
\
Eram meus. E dos outros também... incontáveis almas atraídas para a sombra de Sussurro.\
\
<Aelric abaixa a cabeça.>\
\
Eu imploro. Rompa as correntes.\
\
Reúna as relíquias necessárias para realizar a purificação que libertará meu vínculo com esta arma. Preciso dos seguintes itens:\
\
Lágrimas de Pó Lunar, que dizem cair dos Altaneiros Angustiados em Hibérnia; o Selo dos Esquecidos, carregado pelos Feiticeiros Eldreth no Gládio Cruel; e um Estilhaço da Ruína Vil, obtido de Comandantes da Guarda Apocalíptica nas Terras Devastadas.\
\
Também precisarei da Relíquia da Marca da Tristeza — um artefato antigo usado em rituais dos Altaneiros... acredito que seu pequeno amigo lá no pântano possa tê-la encontrado.\
\
Só então Sussurro estará livre... e eu também.",o="Colete os itens de que Aelric precisa para romper seu vínculo com Sussurro.",c="Você fez bem. Agora estou livre do meu vínculo com Sussurro... e, em troca?\
\
Eu a entrego a você. Que ela lhe sirva como me serviu, sem o sofrimento que trouxe ao mundo."},
    [49986]={d="Que visão magnífica, $n! Esta escritura brilha com a luz cálida da aurora, e sua leitura me enche de esperança e vigor renovados. O texto dourado fala da cura por meio da energia solar e da canalização do poder vital do sol. Uma magia tão radiante traz apenas bênçãos e renovação ao mundo.",o="Leia a Escritura Solar e procure a Capelã Nysoni no Vale de Vila Norte.",p="Sua presença aquece este lugar sagrado, $n. Trouxe a Escritura Solar? A bênção do sol flui por aqueles escolhidos para curar.",c="Você recebeu a bênção, $n! A luz radiante do sol flui por seu ser, marcando você como alguém escolhido para a cura e a renovação. Como Clérigo Solar, você levará esperança aos desesperados e luz aos lugares mais sombrios.\
\
Seu caminho de cura começa agora. Que sua luz jamais se apague e que você sempre leve a aurora aos que se perderam nas trevas."},
    [49992]={o="Procure Elling Trias na Abadia de Vila Norte.",c="A Luz brilha sobre você, <name>. Sinto a bênção dela em sua própria presença.\
\
Você aceitou o pacto sagrado do Caçador de Bruxas. Agora está ligado a um propósito divino: buscar o mal em todas as suas formas e purificá-lo com fogo justo. Isto não é apenas um chamado; é um mandamento divino.\
\
Sua fé será sua arma, e sua convicção, sua armadura. Você aprenderá a canalizar a Luz em ataques devastadores contra o profano, a proteger os inocentes com barreiras abençoadas e a enxergar através dos enganos de demônios e mortos-vivos.\
\
Lembre-se sempre: o mal pode se esconder nas sombras, mas não resiste à chama purificadora da justiça. Prepare-se, caçador. A escuridão não vai esperar — e nós também não."},
    [51003]={title="Guia do Patrulheiro",o="Procure o Guia do Patrulheiro e depois Baruhr Mightmane, no Vale Cristálgida.",c="As terras selvagens das montanhas fizeram uma boa escolha, <name>. Você carrega dentro de si o espírito dos lugares elevados, e os caminhos antigos chamam seu sangue. Como Patrulheiro da Montanha, será a ponte entre os salões de pedra e os picos indomados.\
\
Bem-vindo à irmandade das montanhas selvagens. Que sua pontaria seja certeira e seu caminho leve à liberdade das alturas."},
    [51005]={title="Diário de Necromancia",o="Procure o Diário de Necromancia e depois Savina Gloom, no Vale Cristálgida.",c="Você tem potencial, <name>. A morte não lhe causa medo nestes salões onde tantos ancestrais repousam, e isso é... revigorante. Como Necromante, aprenderá a trabalhar com a morte da montanha, em vez de lutar contra ela.\
\
Seu aprendizado nas artes antigas começa agora. Lembre-se: a morte não é má, apenas inevitável. Guie-a com sabedoria por estes sagrados salões de pedra."},
    [51012]={title="Mandato do Caçador",c="A Luz guiou você até mim, <name>.\
\
Estes picos congelados podem parecer tranquilos, mas o mal se esconde em cada sombra, cada caverna e cada ruína esquecida. Como Caçador de Bruxas, você será a arma da Luz contra a corrupção. Caçará cultistas, destruirá influências demoníacas e purgará a escuridão onde quer que ela se alastre.\
\
Sua fúria justa arderá até no ar mais frio das montanhas. Suas armas abençoadas abaterão o profano. Nestas terras severas, você se tornará o algoz de tudo que corrompe e destrói.\
\
Bem-vindo à caçada eterna. Que o mal trema com sua chegada!"},
    [51014]={title="Manual da Morte",o="Procure o Manual da Morte e depois Zipak Cogweight, no Vale Cristálgida."},
    [52001]={c="O sangue chama pelo sangue, e o seu responde com um poder além da compreensão mortal. Você escolheu trilhar o caminho carmesim e dominar a arte proibida da magia de sangue.\\n\\nComo Mago de Sangue, aprenderá a sacrificar vitalidade em troca de força mágica bruta, transformando a essência vital em feitiços devastadores capazes de drenar seus inimigos ou fortalecer aliados além de seus limites naturais. Cada gota derramada se tornará uma arma em seu arsenal.\\n\\nEssa magia exige sacrifícios constantes: seu sangue, o sangue de seus inimigos e o sangue de aliados dispostos, quando a necessidade exigir. Para aqueles corajosos o bastante para pagar esse preço, porém, as recompensas transcendem a feitiçaria comum.\\n\\nLembre-se sempre de que poder sem sabedoria conduz apenas à destruição. Use esses dons para servir à Horda, e que o sangue de seus inimigos alimente nossa vitória."},
    [52003]={title="Vínculo Vil",o="Procure o Tirano Gros no Vale das Provas.",c="As chamas vis ardem dentro de você agora — e estão famintas. Você escolheu tornar-se Juramentado Vil, reivindicando o poder da Legião não para desafiá-lo, mas para dominá-lo. O que antes queria escravizar você agora se curva à sua vontade.\
\
Como Juramentado Vil, aprenderá a aprisionar essência demoníaca por domínio e pacto, arrancando aliados infernais da Espiral Etérea e acorrentando-os às suas ordens. Cada demônio que controla é prova de sua ascensão, uma arma forjada na própria corrupção.\
\
Este caminho não busca equilíbrio entre salvação e danação. Ele abandona essas ilusões por completo. Os sussurros vis não são tentações; são verdades, oferecendo força àqueles implacáveis o bastante para aceitá-las. Os fracos sucumbem à corrupção; os dignos a moldam.\
\
Lembre-se de por que abraçou este poder: não por redenção, nem por contenção, mas por supremacia. Que o vil consuma hesitação, misericórdia e dúvida. Que suas chamas queimem o mundo até restarem apenas os fortes o bastante para resistir."},
    [52004]={c="Os espíritos da proteção reconhecem você como o campeão escolhido. Você aceitou a mais nobre das vocações: servir como guardião eterno, colocando a segurança dos outros acima da sua.\\n\\nComo Guardião, aprenderá a se tornar uma fortaleza viva, criando com suas técnicas defensivas barreiras que nenhum inimigo poderá romper. Sua magia protetora defenderá grupos inteiros do perigo, enquanto sua presença inabalável inspirará coragem no coração dos aliados.\\n\\nEsse caminho exige sacrifício altruísta: você suportará a dor para que outros não precisem suportá-la e enfrentará a morte para que outros possam viver. A glória costuma ignorar aqueles que evitam desastres em vez de causá-los, mas não existe honra maior do que preservar vidas inocentes.\\n\\nA Horda precisa muito de sua proteção, guardião. Esteja pronto para defender aquilo que mais importa."},
    [52007]={c="Os elementos brutos agora fluem através de você com fúria primordial! Você escolheu abraçar as forças mais fundamentais da própria criação, tornando-se um canal para terra, ar, fogo e água em suas formas mais puras.\\n\\nComo Primalista, você aprenderá a comandar magia elemental com poder sem precedentes. Seus feitiços provocarão erupções vulcânicas, terremotos devastadores, ventos com força de furacão e enchentes torrenciais. Os próprios elementos fundamentais da realidade responderão ao seu chamado.\\n\\nEsse poder vem dos alicerces do mundo, sendo mais antigo e perigoso do que qualquer magia criada por mortais. Os elementos não se importam com a civilização: respondem apenas à força e ao respeito. Demonstre fraqueza, e eles consumirão você.\\n\\nAs forças primordiais aceitaram você como campeão. Que se mostre digno de empunhar os poderes fundamentais que moldaram a própria Azeroth."},
    [52009]={c="A natureza selvagem reconhece alguém dos seus! Consigo ver em seus olhos o chamado do ermo, a conexão profunda com a natureza que distingue os verdadeiros Patrulheiros. Você escolheu tornar-se guardião das terras indomadas.\
\
Como Patrulheiro, aprenderá a se mover sem ser visto por qualquer terreno, comunicar-se com feras selvagens como se fossem irmãs e atacar das sombras com precisão mortal. As florestas esconderão você, as montanhas lhe darão abrigo e os animais prestarão auxílio.\
\
Este caminho exige profundo respeito pelo mundo natural e por todas as suas criaturas. Você aprenderá a viver em harmonia com a natureza enquanto a protege de quem pretende explorá-la ou destruí-la por ganância.\
\
Os espíritos selvagens recebem seu novo protetor. Que suas flechas voem certeiras e que seu rastro permaneça oculto daqueles que pretendem causar mal."},
    [52015]={title="Artes Tóxicas",o="Procure Qwi'spe, a Sábia, no Vale das Provas.",c="O equilíbrio mortal flui pelo seu entendimento! Você escolheu dominar a natureza dupla das toxinas: seu poder de ferir e o poder igualmente grande de curar quando aplicadas corretamente.\
\
Como Venomante, aprenderá a preparar venenos capazes de derrubar os inimigos mais poderosos, mas também antídotos e curas que podem salvar vidas que outros já consideram perdidas. Toda toxina tem um remédio, se alguém compreender seus princípios.\
\
Esse conhecimento traz uma responsabilidade enorme: o mesmo composto que mata uma fera corrompida pode salvar uma criança envenenada. Sua sabedoria deve decidir quando liberar a morte e quando preservar a vida.\
\
O equilíbrio natural reconhece sua compreensão. Que seus venenos encontrem os inimigos e suas curas tragam alívio aos aliados."},
    [52016]={title="Sabedoria Ancestral",c="Os loas recebem sua nova voz no mundo mortal! Você escolheu servir como receptáculo da sabedoria ancestral, fazendo a ponte entre o reino dos espíritos e a terra dos vivos.\
\
Como Médico Bruxo, aprenderá a canalizar o poder dos loas por meio de rituais e sacrifícios, a curar com magia espiritual e a lançar mandingas sobre seus inimigos com maldições que transcendem a própria morte. Os ancestrais guiarão suas mãos tanto na bênção quanto no julgamento.\
\
Este chamado sagrado exige respeito pelos costumes antigos sem ignorar as necessidades do presente. Você deve servir como curandeiro, conselheiro e guia espiritual de seu povo, interpretando a vontade dos loas para aqueles que não conseguem ouvir suas vozes.\
\
Sua magia não serve apenas a indivíduos, mas à saúde espiritual de toda a comunidade.\
\
A sabedoria ancestral recebe seu novo guardião. Que os loas guiem seus passos, e que sua magia sirva vivos e mortos com igual reverência."},
    [53004]={c="Seu juramento foi testemunhado, $n. A partir deste momento, você será escudo e abrigo para os necessitados.\
\
O Guardião permanece onde os outros não conseguem, suporta o que os outros não suportariam e protege aqueles que não podem se defender. Seu juramento não é apenas um conjunto de palavras: ele se torna parte da sua própria essência e transforma você em um baluarte vivo contra todas as formas de dano.\
\
Você aprenderá a tecer escudos de pura força de vontade, barreiras capazes de proteger exércitos inteiros do sopro de dragões ou de bombardeios. Sua presença inspirará coragem nos aliados e lançará dúvidas sobre os inimigos.\
\
Mas entenda: o caminho do Guardião exige sacrifício. Repetidas vezes, você se colocará entre o perigo e os inocentes. Suportará a dor para que outros não precisem suportá-la. Permanecerá só diante de possibilidades impossíveis enquanto os demais recuam. Isso não é um fardo, mas um privilégio: ser o escudo que nunca se parte e a muralha que nunca cai.\
\
Boas-vindas à vigilância eterna, $n. Que o mal se despedace contra suas defesas!"},
    [53015]={title="Fórmula de Veneno",c="Os venenos cantam para você, <name>. Cada toxina tem sua própria voz, seu propósito e sua terrível beleza.\
\
A Venomancia é a arte da transformação pela toxicidade. Venenos simples, que apenas matam, são brincadeira de criança: você aprenderá a preparar toxinas capazes de remodelar corpo e mente, evoluir ou regredir um ser, despertar potenciais ocultos ou selar poderes. Toda substância da natureza pode se tornar uma ferramenta em seu arsenal, do veneno da serpente mais letal à humilde picada de uma abelha.\
\
Você dominará toxinas que agem instantaneamente ou permanecem dormentes por anos, venenos que afetam apenas linhagens ou espécies específicas e agentes que se espalham como doenças por populações inteiras. Mas a destruição é apenas metade da sua arte: você também preparará antídotos capazes de neutralizar qualquer veneno, estimulantes que concedem capacidades sobre-humanas por um tempo e mutagênicos que provocam transformações benéficas permanentes.\
\
Seu próprio corpo se tornará um laboratório vivo. Você desenvolverá imunidade às toxinas conhecidas enquanto aprende a secretar venenos pela pele, pela respiração ou até pelo olhar. Os praticantes mais avançados conseguem envenenar conceitos abstratos — corrompendo memórias, contaminando emoções ou intoxicando a própria magia. Você compreenderá a linha tênue entre remédio e veneno e como a dose determina se uma substância cura ou destrói.\
\
Bem-vindo ao caminho do veneno, <name>. Que a química se torne alquimia em suas mãos!"},
    [53201]={c="As estrelas guiaram você até mim, $n. Sinto as energias cósmicas se agitando dentro de você.\
\
Como Evocador Estelar, você comandará forças que existem desde antes da civilização mortal. O céu noturno se tornará seu grimório, e as constelações, seus feitiços. Você canalizará a luz das estrelas em raios devastadores, fará chover meteoros sobre seus inimigos e navegará pelos ventos estelares que carregam os sussurros de galáxias distantes.\
\
O cosmos é vasto e eterno, repleto de poderes além da compreensão mortal. Antigos deuses estelares empunharam essas mesmas forças para moldar a própria realidade. Agora o conhecimento deles flui através de você.\
\
Bem-vindo ao domínio das estrelas. O próprio universo se curva à sua vontade!"},
    [55000]={d="Ah... este cristal... Já vi algo parecido antes, embora minhas lembranças sejam apenas fragmentos. Certa vez existiu um Altar com o poder de reforjar nosso equipamento em plena batalha. Ele nos deu a vantagem necessária para virar o rumo da guerra. Quando a guerra terminou, tentei reivindicar o Altar para a Aliança. Procurei por toda parte, mas ele havia desaparecido, escondido por aqueles que desejavam proteger seu poder. Gostaria de poder contar mais.\
\
Leve isto, herói. Uma lembrança daquela guerra há muito esquecida.\
\
Mantenha-se forte, mantenha-se fiel. Pela Aliança!",o="Fale com o Marechal de Campo Afrasiabi para receber uma Ficha de Reforja."},
    [55001]={d="Ah... este cristal... Já vi algo parecido antes, embora minhas lembranças sejam apenas fragmentos. Certa vez existiu um Altar com o poder de reforjar nosso equipamento em plena batalha. Ele nos deu a vantagem necessária para virar o rumo da guerra. Quando a guerra terminou, tentei reivindicar o Altar para a Horda. Procurei por toda parte, mas ele havia desaparecido, escondido por aqueles que desejavam proteger seu poder. Gostaria de poder contar mais.\
\
Leve isto, herói. Uma lembrança daquela guerra há muito esquecida.\
\
Mantenha-se forte, mantenha-se fiel. PELA HORDA!",o="Fale com o Suserano Runthak para receber uma Ficha de Reforja."},
    [55102]={c="As estrelas escolheram você, $n. Mu'sha e An'she são apenas o começo.\
\
Como Evocador Estelar, você extrairá poder dos corpos celestes — estrelas, luas, cometas e fenômenos cósmicos além da visão mortal. O céu noturno se tornará seu grimório, e as constelações, seus feitiços. Você canalizará a luz das estrelas em raios devastadores, invocará chuvas de meteoros e navegará pelos ventos estelares.\
\
Os tauren sempre observaram o céu em procure de presságios. Você irá além: comandará as próprias estrelas. Domine Chuva Estelar, aprenda Alinhamento Celestial e, um dia, invoque o poder de galáxias distantes.\
\
Bem-vindo ao domínio cósmico. Que o próprio universo responda ao seu chamado!"},
    [55107]={c="O trovão recebe você como parte da família, $n.\\n\\nOs tauren sempre respeitaram as tempestades. Como Arauto da Tempestade, você não apenas as respeita: você se torna uma delas. O trovão é sua voz, o relâmpago é sua arma e os ventos são seus servos. Você dominará Raio, Cadeia de Raios e a própria Forma de Tempestade.\\n\\nO ar crepita com sua presença. Nuvens se reúnem à sua aproximação. Você é a tempestade encarnada, canalizando a fúria da natureza por uma forma mortal. Esse poder exige controle: uma tempestade descontrolada destrói tudo.\\n\\nBoas-vindas ao coração da tempestade. Que o trovão anuncie sua chegada!"},
    [77725]={title="Obtenha o Conhecimento Proibido",d="A busca pelo Conhecimento Proibido oferece grandes recompensas. Persiga seus inimigos com a mesma ambição ardente com que persegue o conhecimento!",o="Obtenha o Conhecimento Proibido com Theldurin."},
    [77728]={title="Magias Antigas dos Centauros",d="Nosso clã já teve acesso a uma magia antiga que permitia aos nossos guerreiros controlar os ventos de Desolação para abater nossos inimigos. Procuramos esse conhecimento ancestral, mas nunca conseguimos recuperá-lo.\
\
Você nos ajudou a superar nossos adversários e a tornar Desolação mais segura. Talvez também consiga recuperar o conhecimento perdido e nos devolver o acesso a essas magias.",o="Obtenha a Tábua Antiga dos Gelkis."},
    [77729]={title="Magias Antigas dos Centauros",d="Nosso clã já teve acesso a uma magia antiga que permitia aos nossos guerreiros controlar os ventos de Desolação para abater nossos inimigos. Procuramos esse conhecimento ancestral, mas nunca conseguimos recuperá-lo.\
\
Você nos ajudou a superar nossos adversários e a tornar Desolação mais segura. Talvez também consiga recuperar o conhecimento perdido e nos devolver o acesso a essas magias.",o="Obtenha a Tábua Antiga dos Gelkis."},
    [77836]={d="Você está se tornando um caçador e tanto. Uma coisa é derrubar a presa quando consegue se aproximar sem ser visto. Outra bem diferente é caçar em campo aberto...\
\
Mate 15 Basiliscos Sal-gema ao redor da Cratera de Weazel, nos Baixios Cintilantes.",o="Mate 15 Basiliscos Sal-gema."},
    [77872]={o="Mate Azuregos e o Senhor da Perdição Kazzak."},
    [77873]={o="Descrição do registro."},
    [77877]={d="Volte ao Quadro de Chamados."},
    [77911]={title="Decifrando os Símbolos",d="UMA NOTA? Tudo que ele tinha era... uma nota? Nem conseguimos ler isto; está em dracônico. Leve-a ao Capitão Thalo'thas Brightsun. Ele é um velho conhecido meu. Tenho certeza de que vai nos ajudar com este \"problema\".\
\
Da última vez que ouvi falar dele, estava tentando se afogar em bebida em Vila Catraca.\
\
E nem pense em tentar algum truque comigo. Estarei de olho.",o="Fale com o Capitão Thalo'thas Brightsun."},
    [77917]={d="Bem, eu nunca gostei muito dele mesmo. Minhas coisas têm sumido com frequência demais desde que ele chegou.\
\
Enfim, não pense que eu não sei do seu plano. Vou ajudar... mas você vai me dever uma.\
\
Vá ao Pico da Rocha Negra. Lá você encontrará o General Drakkisath. Traga-me o sangue dele e eu o usarei para liberar todo o potencial deste amuleto."},
    [81285]={d="Você ficou mais forte, herói. Quase sinto que desta vez não estou mandando você para uma missão suicida... quase.\
\
O Arcanista Doan ainda tem multas atrasadas da biblioteca. É totalmente inaceitável. Vá ao Monastério Escarlate e aplique a punição justa e perfeitamente razoável dele: a morte.",o="Entre no Monastério Escarlate e mate o Arcanista Doan."},
    [81289]={d="Estou começando a achar que você tem futuro. Quer provar que estou certo?\
\
Esta não veio dos meus superiores, mas... você não vai acreditar! Um centauro chamou minha mãe de gorda! Já sei a vingança perfeita. Viaje até Maraudon... e mate a mãe dele! É a gorda. Assim ele aprende.",o="Entre em Maraudon e mate a Princesa Theradras."},
    [81308]={title="Raide de Caminhada Temporal: Zul'Aman",o="Derrote Zul'jin!"},
    [81316]={title="Exploração de Masmorra",d="O Quadro de Chamados oferece recompensas valiosas a aventureiros capazes de concluir uma masmorra Normal. Use o Localizador de Masmorras, entre em um grupo e prove seu valor. Depois, leve a comprovação da vitória ao Quadro de Chamados para receber sua recompensa."},
    [81317]={title="Exploração de Masmorra Heroica",d="O Quadro de Chamados oferece recompensas valiosas a aventureiros capazes de concluir uma masmorra Heroica. Use o Localizador de Masmorras, entre em um grupo e prove seu valor. Depois, leve a comprovação da vitória ao Quadro de Chamados para receber sua recompensa."},
    [81318]={title="Exploração de Masmorra Mítica",d="O Quadro de Chamados oferece recompensas valiosas a aventureiros capazes de concluir uma masmorra Mítica. Use o Localizador de Masmorras, entre em um grupo e prove seu valor. Depois, leve a comprovação da vitória ao Quadro de Chamados para receber sua recompensa."},
    [81333]={d="Bravo herói, chegou a hora de atacar o coração do poder do Flagelo. Kel'Thuzad, senhor lich e braço direito do Lich Rei, reside em Naxxramas, de onde orquestra horrores incontáveis contra nosso mundo.\
\
Precisamos pôr fim à existência vil dele e devolver a esperança às terras assoladas pela peste. Reúna seus aliados, invada Naxxramas e elimine Kel'Thuzad de uma vez por todas.",o="Ponha fim a Kel'Thuzad!"},
    [85007]={d="<Você encontra uma nota amassada, enfiada às pressas em um diário.>\
\
Theladrin,\
\
Eu... eu sei que você disse para eu não ir, mas não consigo mais ignorar. Os sussurros... a mata... estão gritando, e há algo errado. Consigo sentir no peito, nos ossos...\
\
Preciso ver com meus próprios olhos. Eu... vou tomar cuidado, prometo. Vou correr ao primeiro sinal de perigo. Eu só... não consigo ficar sem fazer nada.\
\
Se você não tiver notícias minhas em breve... por favor... não se culpe. Eu... eu precisava tentar...\
\
<Algo terrível pode ter acontecido aqui. Talvez seja melhor investigar antes que seja tarde demais...>",o="Investigue a área próxima em busca do Zelador Desaparecido.",c="A Alta-sacerdotisa mandou você...?\
\
Ah, graças a Eluna... Eu... eu não achei que alguém viria... Eu... eu pensei... pensei que fosse morrer aqui!"},
    [85008]={title="Preso na Escuridão",o="Escolte o Zelador Dalenian até um local seguro nos Remanescentes de Thel'dralor."},
    [100080]={title="Uma Troca \"Justa\"",d="Olá, mortal... Se algum dia quiser resgatar uma alma abandonada das profundezas da Espiral Etérea, saiba que não precisa procurar além de mim, o grande Belpix!\
\
Sou benevolente, mas não sou instituição de caridade... Traga-me Sangue Vil das forças caídas da Legião e uma Pedra de Ressurreição.\
\
Ah, e acrescente umas mil moedas de ouro e estaremos combinados! Preciso disso para, hã... para a troca! Isso, a troca...",o="Volte até Belpix com 250 unidades de Sangue Vil, uma Pedra de Ressurreição e 1.000 moedas de ouro."},
    [100500]={d="Bem-vindo de volta, meu amigável aprendiz! Agora preste atenção, porque acabei de inventar uma receita de arrepiar. Infelizmente, preciso de alguém com determinação e coragem inabaláveis para procurar os ingredientes, e não vejo ninguém por perto que se encaixe no perfil.\
\
É aí que você entra! Se estiver disposto a arriscar o pescoço, prometo que vai valer a pena. Supondo, é claro, que você não perca a alma e acabe vagando pela Ilha da Purgação por toda a eternidade — mas há só, tipo, um por cento de chance disso acontecer.\
\
Enfim, é disso que preciso:"},
    [100504]={title="Garras de Makrinni ao Vapor",o="Jinx Swiftchop quer que você obtenha os seguintes itens:\
\
10 Garras de Makrinni. Elas podem ser obtidas de qualquer makrinni, inclusive dos arkkoran, em Azshara.\
\
10 Especiarias Goblin. Você pode comprá-las com Jinx ou com qualquer cozinheiro respeitável de uma cidade goblin.\
\
Reúna todos os itens e volte até Jinx."},
    [100805]={o="Consulte novamente mais tarde."},
    [149068]={title="Vila Brisabela",o="As notícias vindas da torre são realmente preocupantes. Parece que precisarei ficar aqui por mais algum tempo. Viaje até Vila Brisabela em meu lugar e descubra o que está acontecendo."},
    [150900]={p="Conseguiu mais tomos arcanos, $n?"},
    [150902]={p="Conseguiu mais tomos arcanos, $n?"},
    [172000]={d="O Inquisidor Caleras, o General Cerulean e o Belígero Goredrak estão entre os tenentes mais leais e formidáveis de Malygos, encarregados de proteger as linhas ley que convergem no Nexus. Eles garantem o domínio da Revoada Azul sobre as energias mágicas do mundo e impulsionam o plano destrutivo de seu mestre.\
\
Herói, a própria essência de Azeroth está em risco. Entre nas profundezas de Coldarra e derrote o Inquisidor Caleras, o General Cerulean e o Belígero Goredrak. Ao eliminar esses guardiões, você enfraquecerá o controle de Malygos sobre as linhas ley e ajudará a preservar o delicado equilíbrio mágico que sustenta nosso mundo.",o="Derrote o Inquisidor Caleras, o General Cerulean e o Belígero Goredrak em Coldarra para enfraquecer o controle de Malygos sobre as linhas ley e proteger o equilíbrio da magia em Azeroth.",c="Herói, seus esforços desferiram um golpe significativo contra o controle de Malygos sobre as linhas ley, preservando o equilíbrio da magia. Em reconhecimento ao seu serviço a Azeroth, você receberá uma recompensa por sua dedicação."},
    [172001]={d="Recentemente, a energia arcana dentro do Nexus começou a transbordar para a região ao redor, fazendo o próprio tecido da realidade se deformar. Isso deu origem a entidades poderosas e instáveis conhecidas como Serpentes Arcanas, criaturas mágicas impregnadas de energia arcana bruta.\
\
Herói, as energias descontroladas dessas serpentes ameaçam a estabilidade das linhas ley e o equilíbrio mágico de Azeroth. Viaje até Coldarra e enfrente essas criaturas voláteis. Ao derrotá-las, você ajudará a restaurar a integridade das linhas ley e evitará uma catástrofe ainda maior.",o="Mate Serpentes Arcanas em Coldarra para impedir que as energias arcanas descontroladas desestabilizem as linhas ley e prejudiquem o equilíbrio mágico de Azeroth.",c="Herói, sua vitória sobre as Serpentes Arcanas ajudou a restaurar o equilíbrio das linhas ley e evitou um desastre em potencial. Por sua dedicação à preservação da magia de Azeroth, você será devidamente recompensado."},
    [172002]={d="Para manter o controle sobre as linhas ley e o Nexus, Malygos posicionou uma legião de Vigilantes do Nexus por toda Coldarra. Essas criaturas foram encarregadas de proteger as linhas ley e eliminar qualquer intruso que ouse desafiar o domínio da Revoada Azul.\
\
Herói, os Vigilantes do Nexus são parte vital do controle de Malygos sobre as energias arcanas de Azeroth. Viaje até Coldarra e derrote-os para enfraquecer o domínio de Malygos sobre as linhas ley e ajudar a preservar o equilíbrio mágico essencial ao nosso mundo.",o="Mate os Vigilantes do Nexus em Coldarra para enfraquecer o controle de Malygos sobre as linhas ley e proteger o equilíbrio mágico de Azeroth.",c="Herói, seu triunfo sobre os Vigilantes do Nexus desferiu um golpe importante no domínio de Malygos sobre as linhas ley. Em reconhecimento ao seu serviço a Azeroth, você receberá uma recompensa por sua dedicação e coragem."},
    [172003]={title="Coldarra: Inclinando a Balança",d="No coração de Coldarra, Malygos, o Tecelão de Feitiços, continua sua tentativa de tomar para si as energias arcanas de Azeroth. Sua legião de Draconídeos Cobalto atua como tropa de linha de frente no esforço para dominar as linhas ley.\
\
As escamas encantadas desses draconídeos contêm poderosas energias arcanas capazes de se opor à influência de Malygos sobre as linhas ley. Se conseguirmos aproveitar esse poder, talvez possamos preservar o equilíbrio da magia em Azeroth.\
\
Herói, aventure-se pelas terras congeladas de Coldarra e obtenha Escamas de Dragão Cobalto dos Draconídeos Cobalto. Assim, você ajudará a inclinar a balança a nosso favor e a proteger o equilíbrio mágico que sustenta nosso mundo.",o="Colete Escamas de Dragão Cobalto dos Draconídeos Cobalto em Coldarra para combater a influência de Malygos sobre as linhas ley e proteger o equilíbrio da magia em Azeroth.",p="Colete Escamas de Dragão Cobalto dos Escamaflagelo Cobalto, Tecemagos Cobalto e Navalhas Cobalto derrotados em Coldarra. Essas escamas encantadas contêm poderosas energias arcanas que podem combater a influência de Malygos sobre as linhas ley.",c="Herói, as Escamas de Dragão Cobalto que você trouxe nos deram os meios para combater a influência de Malygos sobre as linhas ley. O equilíbrio da magia em Azeroth está um passo mais perto de ser protegido. Por sua dedicação e serviço, você receberá uma recompensa."},
    [172004]={d="As energias arcanas de Coldarra possuem enorme potencial para o bem ou para o mal, dependendo de quem as controla. Para proteger o equilíbrio mágico de Azeroth, precisamos estudar e compreender as forças que Malygos, o Tecelão de Feitiços, tenta manipular.\
\
Para aprendermos mais, reúna quatro itens espalhados pela ilha: um Dragão do Nexus, Mana Cristalizada Potente, uma Casca Antiga Vinculada à Magia e um Relatório Geológico. Esses objetos contêm informações e energias valiosas que podem nos ajudar a elaborar uma estratégia contra os planos de Malygos.\
\
Herói, o futuro do equilíbrio mágico de Azeroth depende disso. Reúna os itens e ajude-nos a desvendar os mistérios das linhas ley e das forças arcanas de Coldarra.",o="Encontre e obtenha o Dragão do Nexus, a Mana Cristalizada Potente, a Casca Antiga Vinculada à Magia e o Relatório Geológico em Coldarra para estudarmos as forças arcanas da região e protegermos o equilíbrio da magia em Azeroth.",p="Herói, os itens que você reuniu nos forneceram conhecimento inestimável sobre as forças arcanas de Coldarra. Com essas informações, podemos tomar medidas para proteger o equilíbrio da magia em Azeroth. Por sua dedicação e serviço, você será recompensado.",c="Herói, os itens que você reuniu nos forneceram conhecimento inestimável sobre as forças arcanas de Coldarra. Com essas informações, podemos tomar medidas para proteger o equilíbrio da magia em Azeroth. Por sua dedicação e serviço, você será recompensado."},
    [172005]={d="Herói, robôs defeituosos perderam o controle e estão espalhando caos e destruição pelos Campos de Gêiseres. Eles foram projetados para operações de mineração, mas a perturbação de energia na região causou falhas em seus sistemas. Precisamos que você elimine as máquinas descontroladas e garanta a segurança das comunidades e de nossas operações de mineração. Atenderá ao chamado?",o="Robôs defeituosos tomaram os Campos de Gêiseres e estão causando destruição. Elimine a ameaça e torne a região segura novamente.",c="Muito bem, herói. Ao eliminar os robôs descontrolados dos Campos de Gêiseres, você devolveu paz e estabilidade à região. As comunidades locais e nossas operações de mineração podem trabalhar novamente sem medo. Obrigado por atender ao chamado."},
    [172006]={d="Herói, interceptamos informações de que os Mecagnomos do Biela estão realizando experimentos nos Campos de Gêiseres da Tundra Boreana. Nossas fontes acreditam que eles descobriram uma nova tecnologia potencialmente perigosa. Precisamos impedir que esse conhecimento seja usado contra nós.",o="Obtenha Esquemas Estranhos dos Mecagnomos do Biela nos Campos de Gêiseres.",p="Excelente trabalho, herói! Você conseguiu obter os Esquemas Estranhos dos Mecagnomos do Biela. Agora poderemos analisá-los e preparar contramedidas para qualquer ameaça que essa tecnologia represente.",c="Você fez um trabalho excepcional, herói. Os Esquemas Estranhos que recuperou serão inestimáveis para proteger nosso povo das maquinações dos Mecagnomos do Biela. Sua coragem e habilidade ajudaram a proteger nosso futuro, e seus esforços serão devidamente recompensados."},
    [172007]={title="Campos de Gêiseres: Fonte de Energia Cristalizada",d="Herói, os Campos de Gêiseres da Tundra Boreana revelaram recentemente um recurso único que despertou o interesse de nossos engenheiros.\
\
Os Cristais de Sal Impregnados de Óleo encontrados na região possuem propriedades extraordinárias e podem ser usados para alimentar e aprimorar nossos dispositivos e armamentos.\
\
Eles podem ser obtidos com o Robô-vigia 57-K nos Campos de Gêiseres da Tundra Boreana.",o="Colete 12 Cristais de Sal Impregnados de Óleo do Robô-vigia 57-K nos Campos de Gêiseres.",p="Excelente trabalho, herói! Você reuniu com sucesso 12 Cristais de Sal Impregnados de Óleo. Esses recursos serão valiosos para desenvolver tecnologia avançada e reforçar nossas defesas."},
    [172008]={title="Campos de Gêiseres: Erradicando os Nerub'ar",o="Mate Cospe-venenos, Guerreiros e Escavadores Nerub'ar nos Campos de Gêiseres.",c="Você demonstrou grande habilidade em batalha, herói. Os Cospe-venenos, Guerreiros e Escavadores Nerub'ar não foram páreo para sua força. Com essas criaturas eliminadas, os Campos de Gêiseres voltaram a ser seguros. Sua coragem não passará despercebida, e sua recompensa está garantida."},
    [172009]={title="Campos de Gêiseres: Interrompendo a Ninhada",o="Destrua os Sacos de Ovos Nerub'ar nos Campos de Gêiseres.",c="Sua ação decisiva impediu uma infestação que poderia ter tomado os Campos de Gêiseres e colocado nosso povo em grave perigo. Mais uma vez, sua rapidez e determinação foram essenciais. Sua bravura será devidamente reconhecida."},
    [172010]={p="Trabalho incrível, herói! Você reuniu a Carne do Flagelo dos mamutes assolados e as Amostras de Sangue do Flagelo dos magnatauros pestilentos. Essas amostras ampliarão nosso conhecimento sobre os métodos de corrupção do Flagelo.",c="Graças à sua coragem, nossos pesquisadores poderão aprofundar o estudo dos efeitos do Flagelo sobre a fauna local. Sua contribuição é vital para restaurar o equilíbrio da Tundra Boreana. Você provou seu valor mais uma vez e receberá a recompensa merecida."},
    [172012]={title="Talramas: Crônicas dos Mortos-vivos",d="Herói, recebemos informações sobre quatro poderosos tomos necromânticos escondidos em Talramas e na Cidade-Templo de En'kilah. Esses livros descrevem os métodos usados pelo Flagelo para ressuscitar os mortos e controlar seus exércitos.\
\
Infiltre-se nessas fortalezas, recupere os quatro tomos e traga-os para nós. O conhecimento contido neles pode revelar como enfraquecer as forças do Flagelo.",o="Colete os quatro tomos necromânticos em Talramas e na Cidade-Templo de En'kilah.",c="Com esses tomos proibidos em nosso poder, poderemos estudar as artes sombrias do Flagelo e desenvolver maneiras de combatê-las. Sua coragem e inteligência foram essenciais, herói. Estamos um passo mais perto da vitória, e seu nome será lembrado entre aqueles que enfrentaram o Flagelo."},
    [172503]={title="Coldarra: Inclinando a Balança",p="Texto provisório de missão diária de Wrath."},
    [175001]={o="Participe da reunião dos nobres.",p="Lidar com essas pessoas é tedioso e exaustivo...",c="<A derrota está estampada nos olhos lacrimejantes do velho.>\
\
Seria necessário um milagre para convencer este bando de covardes a tomar a iniciativa uma única vez. Você ouviu: enquanto Lady Serenya Coldmere, a última de seu nome, se recusar a pedir ajuda formalmente — e ela nunca pedirá —, a Casa dos Nobres não intervirá.\
\
O sangue do meu povo manchará as mãos deles, mas não as minhas. Não ficarei sentado sem fazer nada enquanto Scadeald definha."},
    [175007]={title="Feridas, Cicatrizes e Sangramento",o="Apresente-se a Sir Draewyn na sala do trono de Graysky.",c="Veio recomendado por Lady Serenya, então?\
\
<Draewyn parece ser o tipo de homem que não precisa elevar a voz para impor respeito. Seus olhos cinzentos analisam você da cabeça aos pés.>\
\
Scadeald é generosa em duas coisas: chuva e problemas. A Luz sabe que precisamos de toda ajuda que pudermos reunir. Muito bem! Você parece competente. Dedicado. Já é mais do que posso dizer da maioria daqui!"},
    [175015]={title="A Purga do Fosso Lodoso",d="O covil dos troggs fica do outro lado do rio congelado, além da ponte.\
\
<Uma determinação febril toma conta de Diallos.>\
\
Mate quantos puder. Extermine-os. Esmague seus crânios! Perfure-os com sua lâmina! Triture os ossos deles com sua—!\
\
<Um acesso de tosse põe fim ao ímpeto de Diallos. A secreção que ele cospe sobre a neve está manchada de sangue.>\
\
Mostre a eles a mesma misericórdia que demonstraram aos meus companheiros.",o="Derrote os troggs do Fosso Lodoso."},
    [175018]={title="Violência na Estrada",d="<Gotas de suor se formam na testa do mercador enquanto ele tenta encontrar as palavras. Seus pulsos carregam marcas de cordas apertadas; claramente foi mantido prisioneiro.>\
\
Minha carroça... minhas mercadorias... meu pobre burro, Tito... Tudo destruído. Que desastre...\
\
Graças à Luz a guarda chegou a tempo e conseguiu espantar aqueles canalhas antes que me deixassem no mesmo estado que Tito.\
\
<O mercador observa a carroça saqueada, com os ombros caídos.>\
\
Não vou conseguir me recuperar disso... investi tudo o que tinha nessas mercadorias. Por favor, ajude-me! Encontre o esconderijo daqueles bandidos e recupere os itens que roubaram.",o="Recupere as mercadorias roubadas no norte da Floresta de Elwynn, dentro da Caverna Pedrafunda."},
    [175020]={p="Enquanto tenha murlocs não lago, da o mesmo algumas vezes lance meu linha... já você acabou com esses plagas?"},
    [175021]={title="Erva-anzol para os Feridos",d="Malditos murlocs... ainda vou me vingar!\
\
<Os ferimentos do pescador são recentes. Embora não pareçam fatais, ele precisa de cuidados antes que seu estado piore.>\
\
Um murloc me emboscou e levou a pouca pesca que eu tinha conseguido. Tive sorte de sair vivo, mas mal consigo ficar em pé. Acho que a arma dele estava envenenada...\
\
Cresce neste lago uma planta que nós, pescadores, usamos para tratar ferimentos causados por peixes venenosos. Chamamos de Erva-anzol. Pode me ajudar a colher alguns brotos?",o="Colete Ervas-anzol no Lago Landen e entregue-as ao pescador ferido."},
    [175030]={d="A receita da Torta de Dunshire leva vários ingredientes. Tenho quase tudo de que precisamos aqui, mas ainda faltam algumas coisas, guloso.\
\
Vá lá fora e traga os melhores ovos das galinhas de Dunshire.\
\
E... hmm... eu poderia mandar você subir a montanha, mas será mais fácil passar na estalagem e comprar alguns litros daquele Leite Requintado dos Ventos que trazem do cume.",c="Temos tudo!\
\
Quer que eu comece a preparar agora ou a fome ainda não apertou, guloso?\
\
Bah, que pergunta... assim que o cheiro chegar, sua boca vai começar a salivar!"},
    [175032]={title="O Medalhão Perdido",d="Você! Sim, você. Não viu um medalhão por aqui, viu?\
\
<Os ombros de Darond caem quando ele vê você negar com a cabeça.>\
\
Sou o carregador desta vila e um 'amigo' dos elfos. O medalhão que perdi é minha garantia para atravessar a barreira encantada da caverna. Sem ele, não consigo fazer meu trabalho; de tempos em tempos, os elfos precisam dos meus serviços.\
\
E este é um desses momentos. Já procurei o amuleto por toda parte.\
\
Poderia me dar uma mão?",o="Encontre o amuleto mágico de Darond, o carregador de Dunshire."},
    [175033]={d="Você chegou. Ótimo. Está tudo pronto para a entrega. Pegue o medalhão; você vai precisar dele para atravessar a barreira mágica da caverna.\
\
Coloque a carga nas costas e siga até o Santuário Namarien. Quando chegar, procure Haldin Greensong. Ele é o mercador do Santuário e o elfo que fez esta encomenda.\
\
Fique com o pagamento. Você mereceu depois de toda a ajuda que me deu. E, se não me engano, quando vir o Vale Dourado com os próprios olhos, qualquer outra recompensa vai parecer pequena em comparação.",o="Pegue as mercadorias de Darond e atravesse a caverna até o Vale Dourado. Depois, siga ao Santuário Namarien e encontre Haldin Greensong.",c="Um rosto novo. Hm. Pelo pacote em suas costas, suponho que trouxe minha encomenda. Darond mandou você, então.\
\
Muito bem, amigo. Respire fundo e tranquilize a mente. Você não encontrará neste Santuário mal algum que não tenha trazido consigo."},
    [175034]={title="Fúria Ursina",d="Os ursos estão se tornando um problema, e a culpa é dos Ealdir. Todo aquele discurso sobre a floresta e os espíritos... Hipócritas! Eles ocupam as cavernas dos ursos e interrompem seus ciclos de hibernação...\
\
Agora as feras vagam furiosas pela mata, rondando as vilas e atacando nossas fazendas. Isso precisa acabar!\
\
A única solução a curto prazo é caçá-las. Adultos, filhotes... não podemos abrir exceções.\
\
Mate quantos encontrar e traga-me as peles, para que suas mortes não sejam completamente em vão.",o="Mate os Ursos de Scadeald e leve as peles até Jornan Thalor.",c="O povo de Cresthairn agradece.\
\
A morte desses ursos trará paz à região, e suas peles fornecerão calor quando os ventos de Dun Morogh soprarem."},
    [175039]={title="O Irmão Íntegro",d="E agora? Mandaram você para me torturar? Já disse que não vou dar a vocês o prazer de me ouvir gritar.\
\
<Você reconhece no prisioneiro a descrição dada pela mulher de Cresthairn sobre um de seus dois filhos: loiro, cabelo curto, rosto barbeado. Este deve ser Cairn.>\
\
<Você explica que a mãe dele mandou você.>\
\
Louvada seja a Luz! Achei que apodreceria nesta jaula. Você precisa me tirar daqui, custe o que custar. Encontre a chave da jaula. Um dos Ealdir está com ela. Mate-o. Mate todos eles. Nenhum desses selvagens é inocente!",o="Encontre a chave da jaula de Cairn derrotando os Ealdir próximos."},
    [175042]={title="Ruídos Abaixo",o="Derrote os mortos-vivos que rondam as criptas da igreja de Cresthairn.",c="Você cuidou dos mortos-vivos?\
\
Graças à Luz! E graças ao Lorde Comandante por ter enviado você! E a você, é claro, por ter feito o trabalho.\
\
Ainda não entendo como isso pôde acontecer. Que tipo de feitiço aquelas bruxas conjuraram para profanar a santidade dos túmulos e erguer seus ocupantes como mortos-vivos?"},
    [175046]={title="Pescaria do Dia: Truta",o="Pesque Trutas de Scadeald para o Comerciante Mercel.",c="Belo estoque você reuniu! Até mais do que eu esperava!\
\
Promessa é promessa, então aqui está. E, ei... se algum dia quiser trabalhar para um humilde comerciante, apareça por aqui."},
    [175049]={d="Não fique aí parado!\
\
Veio ajudar ou assistir seus companheiros sangrarem até a morte sobre a neve?\
\
Encontre um rolo de bandagem grossa entre os suprimentos de primeiros socorros e cuide dos feridos. Eles estão dando a própria vida para proteger a província e o reino. O seu reino também!\
\
Ande, rápido!",o="Procure bandagens grossas entre os suprimentos de primeiros socorros e cuide dos feridos."},
    [175050]={title="Insígnias do Sacrifício",d="A emboscada dos trolls e a batalha que veio depois tingiram a neve de vermelho. Centenas morreram: amigos, companheiros, compatriotas.\
\
Ainda não conseguimos recuperar os corpos. Pelo inferno, desde então não fazemos outra coisa além de oferecer cadáveres à neve.\
\
Faça-me um favor: não vou pedir que carregue corpos, mas recupere ao menos as insígnias deles. Algo a que possamos prestar homenagem quando este pesadelo acabar, quando o último troll Jubafria tiver caído.",o="Recupere as insígnias dos soldados caídos nos arredores da Emboscada Jubafria."},
    [175064]={title="Aperitivo de Grifo",c="Quanta carne conseguiu trazer?\
\
<Bromli dá uma olhada rápida.>\
\
Ótimo, ótimo. Isto serve como aperitivo. Sim, 'aperitivo'. Não me olhe assim: eu avisei que eles comem mais do que você imagina!"},
    [175065]={title="Ninhos e Penas",d="Importa-se de me ajudar mais uma vez? Às vezes os grifos trazem itens... 'peculiares' para os ninhos, e é melhor limpar tudo antes que alguém se machuque.\
\
Agora que você tem a carne, jogue um bom pedaço para eles encherem a barriga e ficarem tranquilos. Só depois se aproxime dos ninhos.\
\
Ah! E, se encontrar penas caídas, não jogue no lixo; elas têm mais utilidades do que você imagina. Traga todas as que encontrar!",o="Limpe os ninhos de grifo no Pico Daumor e colete as penas caídas."},
    [175067]={title="Seus Dias Sombrios",d="Ela está sempre em minhas orações. Ralda, pobre mulher... Está ouvindo o lamento? Deve ser um daqueles dias. Os dias sombrios dela. Metade das águas do Shadewell deve ser feita das lágrimas daquela mulher.\
\
Não há remédio para isso; perder uma filha... não é natural. Para piorar, pouco depois do que aconteceu com a menina, o marido dela foi destacado para a Vigília dos Ventos, onde monta guarda dia e noite. E ela ficou tão sozinha...\
\
Poderia me fazer uma gentileza? Leve algo para ela comer. A pobre quase nunca tem apetite e às vezes esquece de comer completamente.\
\
Ela mora na casa solitária logo abaixo de nós, às margens do lago.",c="Dorothy...? Ah...\
\
<Ao ver o pacote de comida, você percebe a esperança desaparecer dos olhos dela.>\
\
Fernad mandou você. Eu... obrigada, eu acho. Mas não tenho apetite. Não consigo ficar parada enquanto minha filha está desaparecida.\
\
Preciso encontrá-la!"},
    [175069]={title="Agarraram-na pelo Tornozelo",c="Como assim você não encontrou nada? Mas os murlocs... Dorothy...\
\
<O olhar de Ralda escurece.>\
\
Está escondendo alguma coisa de mim? Você não ousaria! Mesmo que Dorothy não estivesse... Se ela... <Ela engole em seco, mas o nó na garganta permanece.> Prefiro saber do que viver com a incerteza.\
\
Então diga. Porque você deve ter encontrado alguma coisa.\
\
Ela ainda está viva? Por favor!\
\
<Ralda desaba em lágrimas.>"},
    [175071]={title="Os Kobolds Estão com Ela",c="Como assim você não encontrou nada? Tem certeza? Nenhum sinal de Dorothy? Impossível... Impossível... Impossível!\
\
O pai dela a puniu e a levou para a mina com os kobolds. Ela precisa estar lá!\
\
Você não procurou direito... precisa voltar e procurar melhor. Ela tem que estar lá... em algum lugar."},
    [175079]={title="Costas Largas e Generosas",d="O exército inimigo — se é que aquilo pode ser chamado de exército — não espera um ataque pela retaguarda. Os melhores guerreiros estão na linha de frente, presos em combate com os soldados da fortaleza.\
\
Sabe o que isso significa? Chegou a hora de atacar.\
\
Você parece impaciente e, se veio até aqui, é porque está louco por uma briga. Quer liderar a investida?\
\
Derrube alguns desses soldados Rocha Negra. Meus homens e eu cuidaremos do resto. Quando terminar, apresente-se ao Comandante Moore."},
    [175080]={d="Por mais rudimentar que seja a tecnologia dos orcs, uma catapulta continua sendo uma catapulta. E uma pedra grande e rápida o bastante pode causar tanto estrago quanto um canhão.\
\
Precisamos nos livrar delas.\
\
Aqui. Explosivos. Coloque-os na base quando chegar perto e mande algumas daquelas coisas pelos ares. Quando terminar, apresente-se ao Comandante Moore.",o="Destrua as máquinas de cerco dos orcs Rocha Negra."},
    [175083]={title="Não Peça Conselho aos Elfos",d="Não gosto de ver você parado aí de braços cruzados enquanto preparo as rações. Que tal uma última tarefa?\
\
Os Elfos da Nascente estão perto daqui; muito educados, muito cordiais, mas não se engane: a gentileza deles é um escudo, e a cautela, uma desculpa para ficarem longe dos nossos problemas.\
\
Talvez você tenha mais sorte do que eu.\
\
Faça uma visita a eles, sim? Peça água encantada da preciosa nascente para os nossos feridos. Eles guardam o lugar com zelo feroz, mas já passou da hora de ajudarem como todo mundo.",o="Encontre os Altos Elfos na nascente e consiga um suprimento de água encantada."},
    [175086]={o="Encontre os agentes da AVIN nos arredores do Forte Kerebor."},
    [175091]={title="Quando os Chifres Soaram",o="Encontre Darvin nas ruínas fora das muralhas da fortaleza.",c="Você... você não é um orc, é?\
\
<Darvin solta um suspiro estrondoso, como se estivesse prendendo a respiração havia horas.>\
\
Pelas barbas dos meus ancestrais! Nunca fiquei tão apavorado! Quando as pedras começaram a voar e aqueles chifres de guerra soaram... achei que certamente me encontrariam."},
    [175103]={title="Semente Abençoada de um Novo Começo",d="Não esqueci o motivo que trouxe você aqui, a maldição que caiu sobre os mineiros daquela vila humana.\
\
O vale está se recuperando, e meu poder cresce. Você nos ajudou mais do que imagina. É justo que eu retribua o favor.\
\
Aceite este presente.\
\
<O elfo coloca em sua mão uma semente parecida com uma pepita de ouro.>\
\
Uma lembrança de minha terra natal, Quel'Thalas; a semente de uma flor que crescia perto da agora perdida Nascente do Sol e que ainda conserva seu brilho. Leve-a aos mineiros e diga que a enterrem perto da mina.\
\
Quando florescer, a maldição desaparecerá."},
    [175116]={title="A Bruxa dos Meus Pesadelos",d="A sudeste de nossa posição, escondida entre os penhascos no coração da floresta, fica a vila Ealdir de Cair Cragg, lar da bruxa Bagga Darma.\
\
Venho enfrentando a magia dela há algum tempo. Ela envia vermes, maldições e sombras para nos atormentar. Eu nos protejo como posso, invocando o poder da floresta e a proteção da Deusa.\
\
Sua ajuda pode inclinar a balança a nosso favor.\
\
Procure Cair Cragg e encontre Bagga Darma. Provavelmente ela estará consumida por sua feitiçaria vil. Use isso a seu favor: pegue-a de surpresa e ponha fim à existência miserável dela.",o="Encontre e derrote a bruxa Bagga Darma na vila de Cair Cragg."},
    [175124]={c="Isto é...\
\
<Deirdre examina o anel de Lady Serenya com algo próximo de ganância. O anel é uma obra-prima como nenhuma que você já viu; só a safira incrustada nele vale mais do que todas as joias dos Ealdir juntas.>\
\
Então você a matou. Não vai demorar para a notícia se espalhar.\
\
Ótimo. Ótimo! Agora que Serenya saiu do tabuleiro, só resta Morgwena."},
    [175129]={title="Murlocs Quillscale",c="Vejo que voltou coberto de sangue.\
\
<O anão franze o nariz quando sente o cheiro.>\
\
Murlocs? Embora... o cheiro seja diferente. Ah, bem. Suponho que você lhes deu uma bela surra. Ótimo. Que voltem choramingando para o oceano. Quanto mais longe das nossas praias, melhor. Já temos problemas suficientes por aqui."},
    [175131]={d="<Kildar faz um gesto brusco e impaciente para que você se aproxime. Seu olhar é sombrio e preocupado.>\
\
Você disse que seu nome era <name>, certo? Sim. Ótimo. Vai servir.\
\
Tenho uma missão para você. Eu mandaria meus montanheses, mas eles estão ocupados com os Jubafria, os wendigos, os javalis, os leopardos, os ursos, os lobos e...\
\
<Kildar respira fundo.>\
\
Escute com atenção: um comboio diplomático partiu recentemente de Altaforja rumo à cidade-estado de Dun Kazad. Algo deu errado. Eles sofreram uma emboscada na Estrada Sinuosa e, embora o embaixador tenha sobrevivido e conseguido seguir viagem, pediram reforços.\
\
Você é esse reforço.",o="Investigue o local da emboscada na Estrada Sinuosa, descubra o que aconteceu e localize o Embaixador Thargas Anvilmar."},
    [175133]={title="Orgulho Lanoso",d="<O anão força a vista para se concentrar na mensagem criptografada. Depois de um bom tempo, solta um resmungo.>\
\
\"Decifrar isto vai dar mais trabalho do que eu pensava. Trabalho demais! Mas... estou disposto a fazer um acordo.\
\
Eu disse que devia dinheiro ao estalajadeiro; não é bem verdade. Fizemos um trato: em troca de quitar minha dívida, eu ajudaria com algumas tarefas. Principalmente alimentar e limpar os iaques da fazenda.\
\
Não é que eu vá ficar sentado sem fazer nada! Enquanto você cuida dos iaques, eu tento decifrar esta maldita mensagem.",o="Alimente os iaques das fazendas de Nivelarn e limpe a palha suja dos estábulos.",p="Como foi com os iaques?",c="Você foi rápido! Rápido demais! Se eu soubesse, teria pedido mais alguns favores.\
\
Enfim, estou quase terminando. Dê-me só um instante; quero conferir esta tradução mais uma vez..."},
    [175145]={d="<name>, vou ficar aqui para vigiar as instalações da Metantenna, mas preciso que você conte pessoalmente a Baugwolf sobre esta sabotagem.\
\
Diga a ele que envie guardas para proteger a área e uma equipe de mecanoengenheiros para restaurar a segurança operacional da estação.\
\
Enquanto isso, vou estudar os dados armazenados no Robô-alarme. Talvez consiga descobrir por que aquele Ferro Negro queria desativar o Metrô Correfundo entre Ventobravo e Altaforja.\
\
Ande! Não temos tempo a perder!",o="Viaje até Dun Kazad e informe Baugwolf sobre os acontecimentos na Estação Metantenna."},
    [175146]={title="Forte Boreos",d="A estrada que você usou para chegar a esta cidade se desvia pouco antes dos portões de Dun Kazad e sobe ainda mais a montanha.\
\
Em nossa língua, essa trilha antiga é chamada de 'Scyldrand', o Caminho do Inverno.\
\
Preciso que alguém percorra o caminho até o Forte Boreos. Já se passaram vários dias desde a última notícia que recebemos de lá.\
\
Nossos guerreiros estavam enfrentando os trolls Jubafria. É possível que estejam em sério perigo.\
\
<Baugwolf lança um olhar urgente para você.>\
\
Vá.",o="Percorra o Caminho do Inverno até o Forte Boreos e apresente-se ao Capitão da Guarda Erdruin."},
    [175152]={d="Esta trilha, o Caminho do Inverno, atravessa os picos de Ealdfrost de leste a oeste.\
\
Em tempos de perigo, os anões deste reino recorrem ao Monte Moroduin, do outro lado deste vale, em busca de orientação. Não é por acaso: em eras passadas, os Titãs construíram um observatório em seu cume nevado.\
\
Seu único e último habitante há milênios é um gigante do gelo chamado Thrymus, o mais sábio de sua espécie.\
\
Temo que ele esteja em grave perigo por causa dos trolls Jubafria. E, entre nós, se existe alguém capaz de percorrer esse caminho até o fim e voltar inteiro, é você.",o="Percorra o Caminho do Inverno até o cume de Moroduin e proteja Thrymus dos trolls."},
    [175154]={p="Ainda não há novas instruções para esta etapa."},
    [175161]={c="<O anão da uma palmada resonante às peças de carne que você trouxe.>\\nAgora isto é o bem! Bem feito. Não chegou ao nível de um monte, mas é mais o que suficiente para passar o dia.\\nPegue sua parte, kid!"},
    [175170]={d="Este cemitério é um dos lugares mais sagrados para os anões de Dun Kazad.\
\
Mas olhe ao redor. Quando não é a neve se acumulando, são as ervas daninhas tomando conta de tudo. Os mortos merecem respeito; no mínimo, seus nomes deveriam permanecer legíveis.\
\
Já arrumei algumas sepulturas por conta própria. Que tal me ajudar a limpar o restante?",o="Ajude a colocar o Cemitério Véu de Neve em ordem.",p="Já terminou?"},
    [175179]={d="Decidi consagrar a alma do meu marido à Luz.\
\
Ele conheceu guerra demais em vida; morte e violência em abundância. Se a Luz puder oferecer a Holdor um pouco de paz e me trazer algum conforto...\
\
Você ficará para ouvir o sermão do Bispo Beorn?\
\
Fale com ele quando estiver pronto para iniciar a cerimônia.",o="Informe ao Bispo Beorn que a cerimônia pode começar.",c="Está feito.\
\
Que a Luz o acolha em sua glória e conceda consolo aos seus familiares.\
\
A morte sempre pesa mais sobre os vivos."},
    [175180]={d="Holdor falava muito sobre legado. Seu desejo era deixar para trás uma cidade mais segura e mais forte.\
\
Mais soberana.\
\
Ele nunca se interessou muito por espiritualidade, mas acredito que teria apreciado o pragmatismo do Credo do Panteão.\
\
Conhecer, recordar, honrar. É isso que devemos fazer agora por meu falecido marido.\
\
Fale com o Patriarca quando estiver pronto para iniciar a cerimônia.",o="Informe ao Patriarca Khazemil que a cerimônia pode começar.",c="Palavras austeras, mas sinceras.\
\
Agora começa o verdadeiro trabalho: lembrar é carregar um peso. A memória traz conforto, mas também pode levar ao esgotamento.\
\
O Credo do Panteão estará aqui para guiá-los quando o peso das lembranças ameaçar esmagá-los."},
    [175181]={title="A Congregação Cresce",d="Você tem minha gratidão. Sem sua ajuda, acredito que os Stonefist teriam acabado escolhendo o Credo do Panteão.\
\
Uma religião nobre, sem dúvida, mas que oferece pouco consolo. E diante da morte, o que mais se precisa é de compaixão.\
\
Tenho um último favor a pedir. Quando passar por Dun Kazad, apresente-se ao Bispo Degarn, meu superior. Diga a ele que a família Stonefist se converteu à Luz Sagrada.",o="Viaje até Dun Kazad e informe ao Bispo Degarn sobre a conversão da família Stonefist à Luz Sagrada.",p="Ainda não há novas instruções para esta etapa.",c="Apesar de nossas diferenças, somos todos um na Luz: fazendeiros, mineiros ou campeões como Holdor. Até reis e thanes.\
\
Que a Luz guie seus passos, meu filho."},
    [175182]={title="A Congregação Cresce",o="Viaje até Dun Kazad e informe ao Patriarca Arbilun sobre a conversão da família Stonefist ao Credo do Panteão.",p="Ainda não há novas instruções para esta etapa.",c="Da terra viemos e à terra retornamos. Tudo o que tomamos emprestado dela, um dia devolvemos.\
\
Do anão mais humilde ao lorde mais poderoso, isso é o que todos temos em comum. Não importa quão rico ou nobre alguém seja; no fim, não passamos de pedra moldada em carne."},
    [175195]={p="Ainda não há novas instruções para esta etapa."},
    [175196]={title="Ambições Traiçoeiras",o="Viaje até Dun Kazad e informe pessoalmente o Thane Azaghal Stonesong.",c="<A testa do Thane se franze enquanto você relata a conspiração da Guilda e os planos de Thorazin Anvilmar.>\
\
Aquele rato do Thorazin. Nunca gostei dele. Mandaria executá-lo se já não tivesse fugido com o primo!\
\
Imagino que tenham deixado a cidade pouco depois de falar com você. Devem estar a caminho de Altaforja.\
\
Maldito anão. Ele posicionou as peças exatamente onde queria. O primo, o Senador, dirá a Magni exatamente o que Thorazin quer que ele ouça, e ninguém duvidará da palavra dele.\
\
Os Barbabronze declararão guerra contra nós."},
    [175198]={title="Vozes no Portão Norte",d="Vi você falando com Lorde Darengar. A ralé não mandou você, espero? <Sermon Spada lança um olhar arrogante e avaliador.>\
\
Mas escute só. Claro que não. Você parece mais um mercenário.\
\
Acontece que há uma multidão furiosa no portão norte de Ventobravo, exigindo respostas sobre a situação em Scadeald. Nada do que tentamos conseguiu acalmá-los, mas talvez as palavras de alguém da mesma “posição” tenham mais efeito que um documento oficial.\
\
Fale com eles. Intimide-os, se for necessário. Quando terminar, procure meu sobrinho, Thair Spada, que monta guarda no portão.",o="Informe aos cidadãos preocupados do Distrito dos Anões de Ventobravo que a Casa dos Nobres ouviu seus apelos.",p="Não recomendo entrar em Scadeald neste momento.",c="Meu tio...? Não havia necessidade de mandar ninguém. Estou cumprindo meu dever como esperado.\
\
A situação no portão está sob controle... embora a palavra “controle” esteja começando a parecer generosa.\
\
De qualquer forma, agradeço por ter se dado ao trabalho de ajudar.\
\
Espero que meu tio e a Casa dos Nobres decidam agir logo."},
    [175201]={title="O Que a Mina Escondia",d="Nenhum daqueles brutamontes cobertos de lata que mandam de Graysky vai resolver o problema dos gnolls, a menos que “resolver” queira dizer “matar todos”. Não que eu vá reclamar se for esse o caso.\
\
De um jeito ou de outro, não posso fazer mais nada por você. Essa é a maneira educada de convidá-lo a sair da minha cabana.\
\
<Beldred aponta para a porta com um de seus dedos muito longos.>\
\
Então, adeus! Vá fazer seja lá o que você faz melhor: matar coisas, colher flores... ou falar com pessoas. Isso! Conte ao Capitão Amros o que descobriu. Que homem preocupado, esse Amros, não é? Tenho certeza de que nem saiu da taverna.",o="Informe ao Capitão Amros Dhagor o que aconteceu na Mina Galho de Ferro.",c="Maldição ou não, vão querer ouvir seu relatório em Graysky. Melhor do que nada, suponho.\
\
Vou ficar por aqui, caso a situação piore."},
    [175205]={d="Aqueles que Carden trouxe de volta da morte logo serão cinzas. E, com isso, Alanna finalmente terá o descanso que seu amado lhe roubou.\
\
Lembre-se desta lição: a Sombra não possui arma contra você além daquela que você próprio coloca em suas mãos. A obsessão do amante, a ira do louco, a rigidez do santo...\
\
Tudo pode ser distorcido.\
\
<As Três Irmãs abençoam seu nome três vezes antes de partir.>\
\
Agora vá. Deixe este lugar. Seu papel nesta história está chegando ao fim. Os soldadinhos de lata em Graysky vão querer saber que você eliminou a ameaça em Cresthairn."},
    [175206]={title="Uma Variedade de Queijos",d="Desculpe incomodar, mas estou bastante sobrecarregado. Minha mãe não pode deixar a loja sozinha, e meu pai já tem preocupações demais, entre a fama que o queijo Windswept vem ganhando e a situação em Ventobravo...\
\
Poderia me ajudar com uma coisa simples? Estou atrasado com uma entrega.\
\
Só preciso que esta seleção de queijos seja entregue a Zaradiel, a elfa no Parque de Ventobravo. Não vai levar muito tempo e você me faria um enorme favor.",o="Entregue a seleção de queijos a Zaradiel no Parque de Ventobravo.",p="Está com a seleção de queijos?"},
    [175220]={d="O antigo senhor de Wangard, Ohlos, era um líder sábio e querido por seu povo. Talvez, apesar do medo, alguns yetis ainda estejam dispostos a se levantar contra o novo tirano e lutar pelo que é certo.\
\
Principalmente se virem você derrubando os capangas dele.\
\
Mate o máximo que puder.",o="Derrote os capangas de Gharma em Wangard e inspire os yetis leais a Ohlos, seu antigo senhor.",p="<O yeti não passa de um monte ensanguentado, largado sem cerimônia no chão.>",c="<Você percebe que Ruhl está dando seus últimos suspiros, longos e dolorosos.>\
\
Tudo... por nada..."},
    [175238]={title="Dízimo de Almas",d="Como vestígios da Grande Árvore, a flor e o fruto estão além do alcance de Tzotec. São relíquias da Vida, e ele é o Loa da Morte. Água e óleo.\
\
Para que ele devore a energia que guardam, primeiro precisamos temperá-los com magia da morte.\
\
<Tizare entrega a você um amuleto negro, frio como uma moeda colocada sobre os olhos de um cadáver.>\
\
Use-o nos corpos dos yetis Chifrefrio e dos pelursos Cascagélida que matar. As almas deles ficarão presas de forma irreversível ao apetite do Loa da Morte.",o="Use o amuleto de Tizare nos cadáveres dos yetis Chifrefrio e dos pelursos Cascagélida para capturar suas almas.",c="<Tizare ergue o amuleto até o ouvido, como se escutasse algo lá dentro.>\
\
Sim. Isto será suficiente.\
\
Eles não estão felizes, é claro. Mas a agonia será breve e, depois disso, conhecerão a paz. A verdadeira paz."},
    [175249]={d="Há alguma coisa rio acima. Não falei disso antes porque não queria mandar você para a morte.\
\
Mas, depois do que vi, talvez consiga enfrentá-la e destruí-la.\
\
<Telkin tira as mãos do gelo por um instante e encara você intensamente.>\
\
É um espírito nascido do rio estagnado, uma manifestação elemental de sua corrupção. O gelo contaminado que você purificou era apenas uma de suas muitas formas.\
\
Se conseguir destruí-lo, fale com Shivara.",o="Derrote Kegare, o Espírito Estagnado, na represa rio acima.",p="Água parada gera veneno.",c="<Os olhos de Shivara brilham ao compreender o que aconteceu.>\
\
Kegare está morto? Eu não imaginava que isso fosse possível.\
\
Que a bênção da Muda esteja com você. Estamos em dívida, <class>."},
    [175268]={d="<O antigo golem permanece imóvel entre as ruínas, como mais uma estátua no pátio sacerdotal.>\
\
<Uma sucessão de imagens fragmentadas invade seus pensamentos: um templo intacto, sacerdotes Jubafria entoando cânticos, uma oferenda...>\
\
<Então a sensação muda. Exaustão. Submissão. Séculos de passos sem rumo. Guardiões privados de propósito, protegendo salões vazios e altares destruídos.>\
\
<O golem ergue lentamente uma das mãos na direção dos outros constructos que patrulham as ruínas.>\
\
<Ele quer que você lhes conceda descanso.>",o="Destrua os constructos drakkari no Palácio Sacerdotal para libertar os restos espirituais aprisionados dentro deles.",p="<O golem espera em silêncio. Uma vibração tênue percorre a pedra de seu corpo.>",c="<Ao retornar, o antigo golem recebe você com algo parecido com uma reverência.>\
\
<Onde os constructos tombaram, fios azul-claros de energia espiritual flutuam e desaparecem entre a neve e a rocha. Não há vozes, mas você sente algo semelhante a alívio.>\
\
<O golem estende uma mão rachada em sua direção. Por um breve instante, sua mente é preenchida por uma última impressão: uma gratidão antiga, pesada como uma montanha.>"},
    [175282]={title="Enterre-os na Neve",d="Precisamos fechar a passagem. Selar as cavernas.\
\
<Olgrim ergue os olhos para o teto irregular de pedra.>\
\
A montanha é velha. Cansada. Ela aceitará desabar, se pedirmos com educação.\
\
Há pilares de gelo sustentando o desfiladeiro. Quebre alguns e o peso da montanha fará o resto.\
\
As Cavernas Nascimento Gélido serão o túmulo daqueles trolls miseráveis.",o="Derrube várias seções das Cavernas Nascimento Gélido para bloquear a passagem usada pelos Filhos da Luz Doente.",c="<Um rugido distante ecoa pela caverna. Neve, pedra e poeira caem do teto como cinzas brancas.>\
\
Bem.\
\
<Olgrim apoia uma mão na parede congelada.>\
\
O caminho está fechado. Com isso, você salvou a vida de alguns leopardos."},
    [175350]={title="Rebanho Gentil"},
    [177899]={d="Você ficou mais forte, herói. Quase parece que desta vez não estou mandando você para uma missão suicida... quase.\
\
O Arcanista Doan ainda tem multas atrasadas da biblioteca. Totalmente inaceitável. Vá até o Monastério Escarlate e aplique a punição justa e perfeitamente razoável que ele merece.\
\
A morte."},
    [177903]={d="Estou começando a achar que você tem potencial. Quer provar que estou certo?\
\
Esta nem veio dos meus superiores, mas... você não vai acreditar! Um centauro chamou minha mãe de gorda! Sei exatamente como me vingar. Vá até Maraudon... e mate a mãe dele! É a grandona.\
\
Isso vai ensiná-lo a ter educação."},
    [200001]={d="Você encontra um bilhete preso ao falcão: \
\
<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão."},
    [200004]={d="Você encontra um bilhete preso ao falcão: \
\
<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão.",p="Aye, guri. Talos já voltou. Obrigado."},
    [200007]={d="Você encontra um bilhete preso ao falcão: \
\
<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão.",p="Maravilha! Brim voltou!"},
    [200010]={d="Você encontra um bilhete preso ao falcão: \
\
<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão."},
    [200013]={d="Você encontra um bilhete preso ao falcão: \
\
<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão.",p="Você fez uma grande coisa hoje ao encontrar Felo. Obrigado."},
    [200016]={d="Você encontra um bilhete preso ao falcão: \
\
<Se está lendo isto, encontrou meu amigo. Junto ao bilhete há um pequeno frasco vermelho. Dê a ele caso esteja ferido; ele saberá o que fazer em seguida.>",o="Use o Frasco Vermelho no falcão."},
    [200034]={d="Ahá, <name>, bem-vindo. Está gostando de sua aparência mortal? Chegou a hora de espalharmos o inferno por Azeroth, um passo de cada vez.\
\
Como você bem sabe, somos poucos, mas nossos números crescerão com o tempo. Imagino que eu não precise lembrar que a situação da Horda não é nossa principal preocupação. Eles são apenas uma ferramenta, um escudo, para que possamos avançar nossos próprios objetivos.\
\
A cada passo, a cada momento, precisamos causar estragos neste mundo, mas não podemos revelar nosso segredo — que somos demônios. Por isso, tenho uma pequena tarefa para você.\
\
Há um peão tão absurdamente preguiçoso que ninguém consegue fazê-lo trabalhar, por mais que tente.\
\
Meus superiores daqui me encarregaram de resolver o problema. Poderíamos dar um aumento a ele, espancá-lo com um bastão até obedecer ou até tentar convencê-lo a trabalhar. Mas...\
\
Mate-o. Inventaremos uma desculpa para a morte dele. Provavelmente um ataque de escorpídeo."},
    [200035]={d="Ahá, <name>, bem-vindo. Está gostando de sua aparência mortal? Chegou a hora de espalharmos o inferno por Azeroth, um passo de cada vez.\
\
Como você bem sabe, somos poucos, mas nossos números crescerão com o tempo. Imagino que eu não precise lembrar que a situação da Horda não é nossa principal preocupação. Eles são apenas uma ferramenta, um escudo, para que possamos avançar nossos próprios objetivos.\
\
A cada passo, a cada momento, precisamos causar estragos neste mundo, mas não podemos revelar nosso segredo — que somos demônios. Por isso, tenho uma pequena tarefa para você.\
\
Há um indivíduo causando problemas em Plangemortis. Quando despertou, simplesmente saiu correndo e espalhando o caos.\
\
Meus superiores daqui me encarregaram de resolver o problema. Normalmente eu seria amigo de alguém assim, mas precisamos manter a aparência de que estamos do lado deles.\
\
Mate-o. Inventaremos uma desculpa para a morte dele."},
    [200036]={d="Ahá, <name>, bem-vindo. Está gostando de sua aparência mortal? Chegou a hora de espalharmos o inferno por Azeroth, um passo de cada vez.\
\
Como você bem sabe, somos poucos, mas nossos números crescerão com o tempo. Imagino que eu não precise lembrar que a situação da Aliança não é nossa principal preocupação. Eles são apenas uma ferramenta, um escudo, para que possamos avançar nossos próprios objetivos.\
\
A cada passo, a cada momento, precisamos causar estragos neste mundo, mas não podemos revelar nosso segredo — que somos demônios. Por isso, tenho uma pequena tarefa para você.\
\
Há um sátiro que não deveria estar aqui. Ele está causando problemas para os moradores de Umbravale.\
\
Meus superiores daqui me encarregaram de resolver o problema.\
\
Mate-o. Sátiros não são bem-vistos por aqui."},
    [200165]={d="Ahhh, $n, vi sua chegada faz muito tempo. Agora é hora de ensinar o que significa ser um Cronomante. Tecer a mesma lunatrama do espaço e o tempo. Ser equivalente a um deus...\\nNão me adelantes demais. Sua, $n, é novo no mundo da cronomancia, e antes do que possa permitir que você habitarte este mundo com tanta poder latente... você deve aprender a controlarte.\\nComo Cronomante, é um mestre da magia do tempo. Isto significao que você deve respetar o tempo nos níveis mais fundamentales. Resultao que deixei meu varinha em algum lugar do monastério.\\nTem 2 minutos. Encuéntrala para mim."},
    [200166]={d="Ahhh, $n, vi sua chegada faz muito tempo. Agora é hora de ensinar o que significa ser um Cronomante. Tecer a mesma lunatrama do espaço e o tempo. Ser equivalente a um deus...\\nNão me adelantes demais. Sua, $n, é novo no mundo da cronomancia, e antes do que possa permitir que você habitarte este mundo com tanta poder latente... você deve aprender a controlarte.\\nComo Cronomante, é um mestre da magia do tempo. Isto significao que você deve respetar o tempo nos níveis mais fundamentales. Resultao que deixei meu varinha em algum lugar deste edifício.\\nTem 2 minutos. Encuéntrala para mim."},
    [200167]={d="Ahhh, $n, vi sua chegada faz muito tempo. Agora é hora de ensinar o que significa ser um Cronomante. Tecer a mesma lunatrama do espaço e o tempo. Ser equivalente a um deus...\\nNão me adelantes demais. Sua, $n, é novo no mundo da cronomancia, e antes do que possa permitir que você habitarte este mundo com tanta poder latente... você deve aprender a controlarte.\\nComo Cronomante, é um mestre da magia do tempo. Isto significao que você deve respetar o tempo nos níveis mais fundamentales. Resultao que deixei meu varinha em algum lugar deste edifício aqui mesmo.\\nTem 2 minutos. Encuéntrala para mim."},
    [200168]={d="Ahhh, $n, vi sua chegada faz muito tempo. Agora é hora de ensinar o que significa ser um Cronomante. Tecer a mesma lunatrama do espaço e o tempo. Ser equivalente a um deus...\\nNão me adelantes demais. Para você, $n, é novo no mundo da cronomancia, e antes do que possa permitir que você habitarte este mundo com tal poder latente... você deve aprender a controlarte.\\nComo Cronomante, é um mestre da magia do tempo. Isto significao que você deve respetar o tempo nos níveis mais fundamentales. Resultao que deixei meu varinha perto daqui.\\nTem 2 minutos. Encuéntrala para mim."},
    [202566]={o="Ajude o Batedor Peter a defender seu posto.",c="Então você manteve a posição. Não recuou. É disso que eu gosto. Talvez você não seja apenas mais um mercenário.\
\
O povo da cidade poderá dormir um pouco mais tranquilo esta noite graças a você. Conquistou seu lugar entre aqueles que mantêm a linha.\
\
Pegue isto como um sinal do respeito de Vila Plácida. Só não deixe subir à cabeça. A próxima luta está sempre logo depois da colina."},
    [211178]={c="O-o próprio Sangue de Zul'jin, está dizendo?\\n\\n<Budd se recompõe antes de continuar.>\\n\\nBem, agradeço o gesto, $c, mas eu poderia tê-lo derrotado facilmente. Não há como ele ser tão assustador quanto dizem as lendas. Com o tempo, você aprenderá que essas histórias costumam ser terrivelmente exageradas. O mais provável é que aquele velho miserável tenha sido vencido pela artrite!\\n\\nDe qualquer maneira, suponho que isso seja o mínimo que poderia fazer para pagar toda a gentileza que demonstrei por aqui.\\n\\nAgora vá embora. Preciso me livrar deste frasco repugnante!"},
    [213384]={d="Agora que você conseguiu a íris de foco, é hora de usar a chave.\\n\\nEmbora eu fosse gostar de ver Malygos voltando para nós, sei que isso não vai acontecer agora. Com tudo o que está em jogo, os outros Aspectos Dragônicos decidiram que o Tecencantos precisa ser eliminado.\\n\\nKrasus diz a última frase com um tremor na voz.\\n\\n$n, siga para o Olho da Eternidade, enfrente Malygos e volte aqui com o Coração da Magia."},
    [254004]={d="Quer saber das coisas que o Velho Mirsinth viu? Um ser de metal faz guerra contra meu povo e talvez contra o seu também? Sim, sim, o Velho Mirsinth viu muitas coisas. Talvez tenha visto seu ser de metal. Você quer detê-lo por causa da ameaça que representa ao seu povo, mesmo que ele ataque o meu?\
\
Talvez você tenha mais visão que o povo do Velho Mirsinth. Você deixou antigas rivalidades de lado; então o Velho Mirsinth fará o mesmo. O povo do Velho Mirsinth já não é mais seu povo. Expulsa, sim, “exilada”, como você diz. Por quê? E por que seu ser de metal não faz o que mandam? Talvez pelas mesmas razões do Velho Mirsinth... ou pelo contrário.\
\
Se quer respostas, fará algo que o Velho Mirsinth não pode. O Velho Mirsinth se esconde aqui porque os yetis mantêm nosso povo afastado. Yetis são mais fáceis de evitar que nosso próprio povo, entende? O Velho Mirsinth pode se esconder, fugir, vagar... mas o Irmão Jun’Kon tomou seu totem quando a expulsou. Disse que ela não era mais família dele. O Irmão Jun’Kon é covarde e se esconde bem fundo numa caverna. Traga o totem de volta e falaremos sobre o ser de metal, a história e muitas outras coisas. Sim?",o="Recupere o totem de Mirsinth, a Exilada, com Jun’Kon na Fortaleza Jubafria.",p="O Irmão Jun’Kon expulsou o Velho Mirsinth. Disse que ela era traidora por questionar velhas rivalidades e vinganças.\
\
Mesmo assim, o Velho Mirsinth gostaria que o irmão não precisasse morrer... Faça isso rápido, por favor.",c="O Velho Mirsinth e o Irmão Jun’Kon foram amigos um dia, há muito, muito tempo... Já não são crianças. O Velho Mirsinth ficou mais sábio; o Irmão Jun’Kon, menos. Mesmo assim, é difícil esquecer aqueles dias...\
\
Dê ao Velho Mirsinth um momento. Paciência tem valor, sabe?... Não é mesmo, Irmão Jun’Kon?"},
    [254005]={d="A velha Mirsinth vai falar agora. Para ela, o irmão Jun'Kon está morto há muito, muito tempo... mais morto ainda desde que expulsou a velha Mirsinth. Ela não deveria lamentá-lo, mas há sabedorias que nem a idade nem os loa conseguem ensinar...\
\
Seu ser de metal foi criado como uma ferramenta, sim? Martelo, espada, faca, mais peças... parecem magia para o povo da velha Mirsinth, mas ainda são ferramentas, sim? Uma ferramenta deveria fazer aquilo para que foi usada, cumprir seu propósito. Mas o ser de metal não é uma ferramenta.\
\
O ser de metal está vivo. Metal, sim, mas vivo. A criadora não lhe contou isso, não? Talvez nem saiba?\
\
Ela é tola.\
\
Espíritos não são ferramentas. Diga isso a ela. Você não encontrará nada sem a verdade dela. Faça-a contar, e quando contar, diga que a velha Mirsinth precisa de mais informações para encontrar o ser de metal.",o="Encontre Efry Cogspark na Estalagem Stoutlager, em Thelsamar."},
    [254007]={d="O Velho Mirsinth terminou. Encontrou o espírito do ser de metal. Ele está perto de uma escavação que seu povo chama de Ironband, lá em cima. O Velho Mirsinth só sabe onde, não por quê, mas era disso que você precisava, sim? Parece que o trabalho do Velho Mirsinth acabou.\
\
Agora talvez o Velho Mirsinth vague pelo mundo. Este lugar já não parece muito um lar. Rivalidades antigas demais, ciclos demais... mas os loa mostraram muitas coisas ao Velho Mirsinth. Então ela vagará por um mundo que já não chama de casa.\
\
Faz muito tempo que o Velho Mirsinth chamou alguém de amigo. Talvez seja cedo demais para usar essa palavra com alguém com quem falou tão pouco. Mesmo assim, o Velho Mirsinth espera encontrar você novamente em suas andanças, amigo.",o="Derrote Nylrisa perto do Local de Escavação de Ironband e recupere seus componentes.",p="Por favor, por favor, por favor, diga que ela conseguiu encontrar Nylrisa.\
\
Conseguiu? Então vá logo, antes que a perca de novo!",c="Você conseguiu? Encontrou ela? Anda, anda, andaandaanda... desculpe. Não estou nervoso. Só... funcionou? A troll encontrou ela?\
\
Você trouxe os componentes de volta... obrigado. Seria caro substituir isso tudo. Vejamos... treco termoarcano, peça eletrostática, dispositivo mecanofuncional do núcleo... Hmm. Acho que o processador quebrou na luta, e o ectoplasma deve ter vazado também. Só sobrou um pouco de resíduo. Bem... talvez isso tenha sido uma péssima ideia.\
\
Tá bom, foi definitivamente uma péssima ideia. Não vou fazer de novo, certo? De qualquer forma, você salvou minha pele, talvez literalmente. Obrigado mesmo! Se um dia precisar de um inventor para inventar alguma coisa, é só me chamar.\
\
Hmm... eu jurava que tinha usado microengrenagens de bronze neste processador, não cobre... Ah, estou pensando demais. Vidra, vou querer uma daquelas bebidas agora! Melhor: três!"},
    [254011]={title="Coisas Brilhantes!",d="Você reconhece o desenho como uma criatura que já ouviu dizer que ameaça Durotar: uma harpia. Talvez alguns pedaços de metal brilhante a deixem calma o bastante para conversar.",o="Colete destroços metálicos."},
    [254013]={title="A Rosa de Avianna",o="Leve as informações que descobriu até Sakari, em Orgrimmar.",c="Você falou com uma harpia?!\
\
Eu acredito em você, claro. Tenho certeza de que é honrado demais para me enganar. Elas só nunca foram muito receptivas... e, para falar a verdade, também não tentamos conversar muito.\
\
Bem, se descobriu as propriedades da flor, posso começar."},
    [254014]={d="Bem, não sei até que ponto a história sobre a origem é verdadeira, mas ela precisa ter surgido de algum lugar. Se a flor realmente possui propriedades poderosas para remover maldições, isso faria sentido.\
\
Talvez, usando métodos alquímicos, eu consiga estender o efeito e produzir várias curas — embora ainda não sejam muitas. A flor tem apenas uma semente, mas talvez eu encontre uma forma de cultivar outras a partir dela...\
\
Ah, estou me adiantando. Primeiro precisamos ter certeza de que este método funciona. Você já chegou até aqui comigo; se conseguir o cristal de que a harpia falou e me encontrar nos Sertões quando terminar, acredito que posso usar o sangue demoníaco para fazer a mistura se ligar ao nosso próprio sangue demoníaco e neutralizá-lo.",o="Encontre o Cristal de Ouru'gai nos Sertões."},
    [254032]={title="As Catacumbas de Karazhan: Rompendo as Proteções",d="Certo. Agora que ajustei a pedra-chave para que você consiga usá-la, deve ser possível simplesmente abrir a porta e entrar.\
\
Mas não recomendo fazer isso sozinho. Reúna alguns aliados e entre nas catacumbas.\
\
Meu poder está praticamente esgotado, então não serei de muita ajuda daqui em diante. Ainda assim, vou projetar uma imagem minha lá dentro. Há mais algumas coisas que precisamos resolver enquanto você estiver por lá.",o="Encontre a projeção de Tabetha dentro das Catacumbas de Karazhan."},
    [254034]={title="As Catacumbas de Karazhan: Um Coração Ensanguentado",o="Derrote Cynfael nas Catacumbas de Karazhan.",c="Então a longa vida de Cynfael finalmente chegou ao fim, não é?\
\
Sabia que ele nunca podia se afastar demais do próprio coração? Se a ligação fosse rompida, morreria imediatamente. Que desperdício... preso numa tumba por causa de uma busca imprudente por \"imortalidade\".\
\
Não é de admirar que os San'layn de hoje não tentem repetir a mesma coisa."},
    [254035]={title="As Catacumbas de Karazhan: O Antigo Cavaleiro da Morte",d="Antes do Lich Rei e daqueles soldados mortos-vivos que vocês jovens gostam de chamar de \"Cavaleiros da Morte\", esse nome significava outra coisa, sabia?\
\
Durante a Segunda Guerra, Gul'dan colocou as almas dos bruxos mortos do Conselho das Sombras nos cadáveres de cavaleiros da Irmandade do Cavalo. Como assim você não reconhece esses nomes? Não ensinam nem um livro de história aos aventureiros antes de mandá-los para missões perigosas? Este mundo está perdido, e essa é a verdade!\
\
Enfim, não estou aqui para dar aula sobre a Segunda Guerra. Você pode descobrir isso sozinho. Um desses cavaleiros acabou enfrentando Aegwynn. Ela havia sido privada da maior parte de sua magia, mas acredite: um mago realmente habilidoso continua sendo um adversário terrível mesmo sem seus feitiços.\
\
Ela conseguiu atraí-lo para perto das catacumbas e ativou as proteções para aprisionar sua alma lá dentro. Provavelmente ele ainda procura um hospedeiro adequado até hoje. Acabe com essa alma de uma vez por todas, antes que consiga outro corpo.",o="Derrote Kurgoth Doomreaver nas Catacumbas de Karazhan."},
    [254036]={title="As Catacumbas de Karazhan: O Julgamento dos Pecadores",d="Aegwynn pouco queria saber dos problemas da cidade abaixo, mas as pessoas tendem a tratar como líder qualquer maga poderosa que more numa torre enorme, queira ela ou não. Isso fica especialmente perigoso quando essa maga está paranoica e sob a influência de Sargeras — como era o caso, se você não sabia.\
\
Ela passou a punir qualquer crime com os destinos mais cruéis. Os condenados eram pendurados de cabeça para baixo em uma piscina nas catacumbas; seus corpos se afogavam, mas suas almas permaneciam seladas para sempre. Talvez não fossem exemplos de virtude, mas nenhum deles merecia um fim desses.\
\
Já que estará lá embaixo, finalmente liberte essas almas. Tenho certeza de que dará um jeito. Só tome cuidado: depois de tantos anos, duvido que estejam de bom humor.",o="Enfrente o Julgamento dos Pecadores nas Catacumbas de Karazhan."},
    [254037]={d="Aquela armadura amaldiçoada finalmente foi destruída... Nunca achei que veria este dia.\
\
Tenho certeza de que meu nome já não significa nada para o mundo lá em cima. Quem se lembraria de um herói fracassado? Não há motivo para guardar minha memória, mas ainda assim peço que ouça minha história, para entender que a sombra presa àquela armadura não representa quem eu sempre fui.",o="Ouça a história de Takan Velor.",c="Espero de verdade que consiga vencer onde eu fracassei. Queria poder empunhar minha espada ao seu lado mais uma vez, mas minha alma está fraca demais. Só posso observar e rezar para que a Luz conceda sua salvação."},
    [254046]={title="Subterfúgio na Parada",d="Argh! Alguém roubou minha Chave de Arco Voltaico, e tenho quase certeza de que foi um daqueles goblins sebosos lá do Circuito da Ilusão.\
\
Aposto que aquele tagarela do Pozzik sabe de alguma coisa. As orelhas enormes dele estão sempre metidas nos assuntos dos outros. Vá até lá e descubra se ouviu alguma coisa.\
\
Só não deixe que ele faça você ficar andando em círculos.",o="Tibbi Fizzcrank quer que você descubra quem levou suas ferramentas. Pozzik, no Circuito da Ilusão, provavelmente sabe de alguma coisa."},
    [254055]={title="Um Petisco para um Cão das Trevas",d="Você ainda parece um pouco nervoso. Não se preocupe, ele não morde... a menos que eu mande.\
\
Certo, faça o seguinte para conquistar um pouco da confiança dele. Ele gosta muito daqueles morcegos-cinzentos. Na verdade, demorou para eu treiná-lo a não sair correndo atrás deles toda vez que um passava pelo acampamento.\
\
Tenho visto um bem grande a leste e estava pensando em caçá-lo para ele. Já que você está aqui, por que não vai encontrá-lo e traz um pedaço para o meu cão?",o="Encontre um petisco e ofereça-o ao Cão das Trevas de Edwin."},
    [254057]={d="Pronto. Está feito. Com isto, a Cruzada Escarlate nem perceberá que perdeu até ser tarde demais.\
\
Agora falta apenas levar a mistura até eles sem levantar suspeitas. Era para isso que servia a cabeça do tenente.\
\
Preparei um elixir que fará você parecer exatamente com ele. Deve conseguir entrar no Monastério Escarlate sem muita dificuldade. Só não chegue perto demais de ninguém se puder evitar, e continue andando. O disfarce não é perfeito, mas, desde que você não faça nenhuma idiotice, ficará bem.\
\
E nem pense em começar uma briga. Os guardas do monastério não são como os daquele acampamento. Eles podem espalhar suas entranhas pela grama com um único golpe. Se descobrirem que você não é o tenente, não vão hesitar em provar isso.",o="Use o Elixir de Transformação de Ralden para se infiltrar no pátio do Monastério Escarlate e contaminar os suprimentos da Cruzada."},
    [254065]={title="Noite do Eclipse"},
    [254087]={d="Agora me lembro. Ouvi dizer que uma tal de Julie Addle está hospedada na estalagem de Vila Sombria. Hoje em dia precisamos ficar de olho em todo mundo; nunca se sabe quando uma pessoa comum pode esconder algo a mais.\
\
Nós três somos necessários aqui e já somos poucos. Mesmo assim, duvido que avancemos muito por este caminho. Se passar por Vila Sombria, talvez possa procurá-la e descobrir se ela consegue ajudar.",o="Encontre Julie Addle na Taverna Corvo Escarlate.",c="<A mulher parece prestes a chorar, mas se recompõe um pouco quando você se aproxima.>\
\
Olá. Posso ajudar em alguma coisa?\
\
Um worgen disse o meu nome...?\
\
Arvis... foi nisso que você se transformou? Desculpe. Preciso de um momento..."},
    [254089]={p="Ele não diz nada, mas tenho certeza de que é ele. Antes de você chegar, eu pensei que talvez ele...\
\
Eu sei. É raro um worgen conservar sequer um vestígio de quem já foi. Era apenas uma esperança egoísta, nada mais.",c="Trouxe o Néctar? Ótimo. Acho que chegou a hora de começarmos."},
    [254091]={title="Que Possamos nos Reencontrar"},
    [255000]={title="Quando a Luz da Vela se Apaga",o="Derrote a “Fera que Habita na Escuridão”.",p="Uma criatura corrompida pelas sombras habita essa caverna. É melhor deter essa fera antes que ela faça novas vítimas.",c="Consegui ouvir os rugidos daquela fera daqui! Nosso povo também temia a criatura, o lagarto-trovão consumido pelas sombras. Os kobolds a chamavam de “Fera que Habita na Escuridão”, mas nós tínhamos outro nome para ela: Vexakoros.\\n\\nEra uma grande ameaça e também uma história contada aos filhotes para que não se afastassem demais. Para matar uma criatura assim, você deve carregar a marca de Shirvallah, mesmo sem saber.\\n\\nEsta noite haverá um banquete pela morte de Vexakoros!"},
    [255001]={title="O Despertar dos Terranos",o="Abra o Grande Barril de Ressonita com um Cristal de Ressonita Zumbante, mate Adaziar e volte ao estranho eremita com a notícia.",p="Sei que é uma esperança vã. Você provavelmente morrerá, e essa criatura poderá ser libertada sobre Azeroth em toda a sua força.\
\
É egoísmo meu pedir que ponha fim a isso. Não precisa dar ouvidos a este velho."},
    [255002]={title="Legado da Ravina Deslizapedra",p="Um Terrano não seria selado aqui sem motivo. Sinto que há mais nesta história do que aprendemos, e talvez você encontre as respostas dentro daquele vale."},
    [255004]={title="Morte à Rainha Traidora",o="Mate a Rainha Erethina.",p="Claro que estou curioso sobre ela. Se essa flor a transformou em uma elfa noturna, será que as harpias já foram elfas noturnas um dia?\
\
Mas ela é perigosa demais para permanecer viva só por causa da minha curiosidade. Quando isso estiver resolvido, poderei voltar às pesquisas para purgar nossa corrupção vil."},
    [255005]={title="Mudança de Comando",d="<As feridas deste corpo não correspondem às de nenhuma criatura local que você enfrentou até agora, mas lembram os cortes de um retalhador goblin. O que quer que tenha causado isso não pode estar muito longe.>",o="Encontre e derrote o que matou os trabalhadores da Empreendimentos S.A."},
    [255006]={d="Rohil acha que você é forte. Forte o bastante para matar Urash. Forte o bastante para quebrar a maldição.\
\
Temos uma prova para novos caçadores: enfrentar as feras e sobreviver. Quimera, lagarto e mantícora. Sobreviva às três e será um grande caçador.\
\
Mas isso não basta para Rohil. Enfrente também Shanel’tefir, o maior terror dos céus. Traga troféus de todas elas e prove que Rohil estava certo sobre você.",o="Colete troféus das grandes feras ao redor da mina.",p="As feras destas terras são mais fortes que as de fora. Grandes e poderosas, só caem diante dos melhores caçadores."},
    [255007]={title="Caçando o Caçador",o="Mate Kasajh.",p="Não chame atenção para nós, forasteiro. Ainda estamos sendo caçados."},
    [255008]={title="Uma Ressonância Antiga",c="Éramos todos tolos. Talvez você também seja.\
\
Mas estas velhas anotações resistiram bem. Faça com elas o que quiser; eu só não quero mais me envolver nisso."},
    [255009]={title="A Força da Pedra",d="Rohil diz que você é forte.\
\
Não há nada mais forte que pedra. E a pedra mais forte de todas é a grande pedra roxa.\
\
Se é tão forte quanto Rohil diz, prove que é mais forte que ela.",o="Destrua os Elementais de Ressonita.",p="A grande pedra roxa nunca fica parada por muito tempo. Talvez ela esteja inquieta.",c="Você quebra grandes pedras roxas?\
\
É forte. Mais forte que eu, mais forte que a maioria.\
\
Rohil estava certo."},
    [255010]={title="Fim do Dever"},
    [255012]={title="Rechaçando a Ofensiva",d="Estou começando a me sentir como se estivesse lidando com coelhos na fazenda: derrubamos um e logo aparecem outros três. Pela Luz, eu queria que fossem coelhos!\
\
Se pretende ajudar, mate alguns orcs até que o avanço deles desacelere. Não espero que acabe com a ofensiva por conta própria, mas ao menos nos dê um pouco de fôlego. Estou pronto para esmagar mais alguns crânios, mas os outros não estão acostumados a lutar tanto tempo sem descanso.",c="Você matou quantos?!\
\
Retiro o que disse sobre os coelhos. Nem eles são tão persistentes. Foi uma boa tentativa, obrigado.\
\
Vamos, pessoal. Parece que ainda ficaremos aqui por um bom tempo."},
    [255013]={title="Belas Armas Enânicas",o="Colete Armamentos Enânicos nos arredores de Burndural."},
    [255014]={title="Um Fim à Vista",o="Mate o Comandante Amzust nos arredores de Burndural."},
    [255015]={title="O Viajante de Vermelho",o="Fale com Aelir em Burndural.",p="<O anão parece confuso, como se você tivesse feito algo que, de alguma forma, não deveria ser possível.>"},
    [255016]={o="Mate Lordes da Guerra, Xamãs Sombrios e Videntes da Morte Presa do Dragão em Zulumar."},
    [255017]={title="Cegando os Presa do Dragão",o="Mate os Vigias Presa do Dragão nas torres ao redor de Zulumar."},
    [255018]={title="Mestres Cruéis",d="Os Presa do Dragão ainda mantêm muitos cativos, pobres crianças obrigadas a servir a todos os caprichos deles. Conheço bem demais a dor que devem sentir, a impotência de sequer conseguir escapar.\
\
Tudo o mais que peço é por Burndural, mas, enquanto estiver lá, preciso fazer um pedido pessoal também. Por favor, liberte as crianças das garras dos Presa do Dragão. Talvez sejam forçadas a resistir, mas, quando seus opressores caírem, tenho certeza de que conseguirão escapar sozinhas.",o="Resgate as “crianças” mantidas pelos Presa do Dragão."},
    [255019]={title="Batalha na Ponte",o="Derrote Konym Rompedragões em Zulumar."},
    [255020]={title="As Mãos Certas"},
    [255021]={o="Derrote Lorde Valesir na Fortaleza de Desterro e recupere a correspondência."},
    [255022]={o="Mate Fuzileiros e Curadores de Theramore no Forte Coração do Ar."},
    [255023]={o="Mate o Capitão Farran no Forte Coração do Ar.",p="<A tauren parece fraca demais para dizer qualquer outra coisa. É melhor deixá-la descansar.>"},
    [255024]={o="Escolte Viktorin Newbery para fora do Forte Coração do Ar.",p="Não há tempo para conversar. Precisamos sair daqui!"},
    [255025]={title="Entesourando Conhecimento"},
    [255026]={title="Em Atraso",o="Recupere o cajado do Arquimago Henricus no alto da torre."},
    [255028]={p="Não sei o que essas nagas estão fazendo aqui, mas nagas tão perto do Porto de Bondebico nunca são bom sinal."},
    [255029]={title="A Corrupção dos Altaneiros",p="Já encontrou? Tenho visto dragões de bronze ao sul, mas nunca consegui chegar perto. Talvez devesse procurar por lá."},
    [255030]={title="Irmãos na Cerveja",d="Faz anos que estou longe de casa, mas meu irmão ainda aparece toda semana para tomar uma caneca. Isso prova que ele sabe que eu sou o melhor cervejeiro, rá!\
\
...Só que ele ainda não apareceu esta semana. Estranho para ele. Não estou preocupado nem nada, mas, se acabar passando por Burndural em suas viagens, diga que ele está atrasado, tá?",o="Encontre o Estalajadeiro Arnith em Burndural.",c="Halbrek mandou você, foi? Não suponho que tenha mandado cerveja junto... Eu bem que precisava de uma agora.\
\
Claro que não. Aquele pão-duro ainda me cobra toda vez que apareço por lá.\
\
Bem, se sabe se virar numa luta, talvez possa ficar por aqui um pouco. Vou visitar meu irmão quando este ataque acabar."},
    [255031]={title="Carneiros em Espera",o="Encontre o Caçador Ukourn em Burndural."},
    [255033]={d="Ora, se não é meu salvador! O que posso fazer por você? No mínimo, devo uma bebida por ter me tirado daquela enrascada.\
\
Isso me lembra: aqueles orcs levaram minha caneca favorita. Tentei procurá-la depois do ataque, mas não encontrei em lugar nenhum, e aquele sujeito de vermelho disse que eu preciso “descansar e me recuperar”.\
\
Como vou descansar se nem beber parece certo sem minha caneca? Não seria justo pedir mais uma coisa, mas, se for atrás dos Presa do Dragão de qualquer forma, poderia ficar de olho nela?",o="Recupere a caneca de Urgil dos Presa do Dragão.",p="Por favor, encontre minha caneca! Não suporto imaginar aqueles orcs quebrando-a.",c="Minha linda e preciosa caneca! Como senti sua falta!\
\
Ah, e de você também, <name>. Agora lhe devo duas bebidas, e não sou o tipo de anão que gosta de deixar dívidas pendentes. Já deixei tudo acertado. É o melhor que temos por enquanto, então aproveite."},
    [255034]={title="Proprietários Legítimos"},
    [255035]={title="Questão Contratual"},
    [255038]={title="Poder do Núcleo"},
    [255040]={o="Confronte o informante dos Vela Sangrenta na Angra do Butim."},
    [255041]={o="Fique ao lado da Angra do Butim e denuncie o informante ao Barão Rezingada."},
    [255042]={o="Fique ao lado dos Bucaneiros da Vela Sangrenta e aceite o suborno do informante."},
    [255043]={title="Chama Eterna",o="Derrote a Abominação da Chama Eterna.",p="Não deve ser nada com que se preocupar... Só prefiro não continuar pensando nisso."},
    [255044]={o="Mate Campeões, Esfoladores e Cervejeiros Cascasseca nas Terras Altas Arathi.",p="Deve haver um caminho ao norte que leva até a colina."},
    [255045]={title="Uma Colheita Escassa"},
    [255046]={p="Já conseguiu a pelagem e as presas, mon?"},
    [255047]={title="Jaula Iridescente",p="Se esse cristal é uma prisão, deve conter bastante poder, mon."},
    [255048]={o="Recupere o carregamento de charutos de Zebel com o fornecedor e volte até Zebel Shplit em Gadgetzan.",p="Já conseguiu meu carregamento de charutos?"},
    [255049]={o="Mate 8 Ladinos, 5 Magos das Sombras e 5 Vigias do Sindicato perto da Fortaleza de Desterro.",p="Odeio ficar aqui parado..."},
    [255050]={title="Espíritos de Thel'Dralor",o="Mate 6 Altaneiros Atormentados, 6 Altaneiros Lamentadores e 6 Altaneiros Esquecidos."},
    [255051]={o="Mate 7 Espíritos Torturados e 5 Servos de Xorthal."},
    [255052]={o="Use o Pano de Polimento para limpar as estátuas nos Vestígios de Thel’Dralor."},
    [255053]={d="Um grupo de historiadores pediu que alguém recolha selos rúnicos dos espíritos em Thel'Dralor para ajudar nos estudos sobre a história dos Altaneiros.",o="Colete Selos de Thel’Dralor dos espíritos Altaneiros em Thel’Dralor."},
    [255054]={d="Registros históricos sugerem que o espírito de uma poderosa maga Altaneira ainda permanece nas ruínas de Thel'Dralor. Pouco se sabe sobre Setheria Starsong, e concluíram que a melhor maneira de descobrir mais seria enviar um grupo de aventureiros para enfrentar o espírito dela e reunir informações.",o="Derrote Setheria Starsong."},
    [255055]={title="Recuperação da Bateria",o="Derrote a Serpente das Nuvens Tempestívaga e recupere a bateria do zepelim.",p="<Você terá que destruir a serpente das nuvens antes de conseguir examinar a bateria direito.>"},
    [255056]={o="Encontre uma fonte de energia e restaure a bateria."},
    [255057]={title="Treinamento da Milícia",o="Pratique suas habilidades contra os Recrutas da Milícia."},
    [255058]={o="Colete Carne de Cervo Chifre-sombrio para Eikta.",p="Não sei por que Mishu sempre preferiu a carne dos Cervos Chifre-sombrio. Eu nunca consegui notar diferença no sabor."},
    [255059]={o="Alimente Mishu, o urso adormecido.",p="Já o alimentou? Talvez seja pedir demais, mas espero que isso tenha algum efeito."},
    [255060]={o="Mate Trabalhadores Gan’arg e destrua Protótipos de Canhão Vil no Pântano das Mágoas.",p="Esses relatos estão perto demais do Portal Negro para o meu gosto."},
    [255061]={title="Eles Tinham a Tecnologia",o="Derrote Vir’Ishar no Pântano das Mágoas."},
    [255062]={title="Fuga de Ja'kani",o="Escolte Ja’kani para fora do acampamento demoníaco."},
    [255063]={title="Missão do Pântano 4 — Não Usada",p="Admiro a engenhosidade dos Gan’arg, mas isso não significa que eu queira vê-la usada contra nós."},
    [255064]={o="Mate Trabalhadores Gan’arg e destrua Protótipos de Canhão Vil no Pântano das Mágoas."},
    [255065]={title="Fuga de Ja'kani",o="Escolte Ja’kani para fora do acampamento demoníaco."},
    [255066]={title="Eles Tinham a Tecnologia",o="Derrote Vir’Ishar no Pântano das Mágoas."},
    [255067]={title="Até que a Não Morte nos Separe",o="Colete as alianças de casamento sob o Cemitério do Morro do Corvo.",p="Esses anéis... eu já os vi antes..."},
    [255068]={o="Colete gemas no Monte dos Ogros Vul’Gol."},
    [255069]={title="Da Morte Vem o Amor",o="Leve a encomenda até Eleanor Zemille.",p="Você voltou com meu precioso anel? Mal consigo conter a expectativa!"},
    [255070]={title="Lavrando contra a Corrupção"},
    [255071]={o="Encontre o estranho que permanece nos arredores da vila.",p="Já foi verificar quem é esse estranho?"},
    [255072]={title="O Tolo e o Torpe",o="Investigue os locais ao redor da Floresta do Crepúsculo para Quill, o Tolo.",p="Encontrou alguma coisa? Espero que não tenha sido assustador demais..."},
    [255073]={o="Mate Filhotes de Viúva Negra na Floresta do Crepúsculo.",p="Então, já cuidou daquelas aranhas terríveis?"},
    [255074]={o="Colete carne de Jovens Devastadores Negros, Mastins Devastadores Negros e Devastadores Negros.",p="Trouxe alguma coisa para mim?"},
    [255075]={title="Ventos Crescentes",d="Dos quatro, eu era quem melhor conhecia a tribo Bosque Negro. Muitos deles já dominaram o poder do vento e, embora suas mentes tenham sido corrompidas, vários ainda conservam essa habilidade.\
\
Não tenho forças para salvá-los, mas talvez eles próprios ainda tenham. Embora me desagrade pedir que os machuque, traga os totens que abençoei em nome deles. Muitos ainda os carregam.\
\
Talvez o vento ainda consiga levar embora a corrupção.",o="Colete Totens do Vento dos Totêmicos e Xamãs Bosque Negro para Losir.",p="Não quero que sofram, mas assim ao menos alguns poderão viver, e a tribo terá a chance de se reerguer com o tempo.",c="Eu nunca quis tomar de volta os totens que abençoei, mas, no estado atual, eles não conseguem usar essas bênçãos.\
\
Pode levar algum tempo, mas farei tudo o que puder para salvá-los. Obrigado."},
    [255076]={title="Adversários Hostis",o="Derrote Ursas e Guerreiros dos Bosques Negros para Serevei.",p="O poder arcano é, na verdade, o poder da ordem. Tudo o que desejo é preservar a ordem destas terras."},
    [255077]={title="A Mácula da Costa Negra",o="Purifique os cultistas mortos do Martelo do Crepúsculo usando o Estilhaço Puro de Arvekor.",p="Não podemos ignorar um inimigo só porque um dia foi nosso amigo. Por mais que doa, precisamos agir se quisermos sobreviver."},
    [255078]={title="Toque de Ouvido",o="Raj’iri quer dançar com a irmã, mas Naj’iri não está no clima. Talvez um pouco de música ajude. Consiga uma Flauta de Vento Centauro com Domadores e Tempestuosos Kolkar.",p="E aí, mon! Teve sorte?"},
    [255079]={title="Encontrando o Ritmo",d="Ah... então nem a flauta foi suficiente para animá-la. Que pena, amigo. A melodia era doce, mas o coração dela continua pesado.\
\
Mas não vamos desistir! Precisamos apenas de algo mais forte, mais barulhento... um tambor! É disso que precisamos!\
\
Rhuna, a curtidora, poderia costurar um para nós se tivesse os materiais certos. Você faria isso por minha pobre irmã mais velha?",c="Precisa de um tambor, é?\
\
Veio ao lugar certo. Ninguém nos Sertões trabalha o couro melhor do que eu!"},
    [255080]={title="Dançando no Ritmo",p="Já voltou! Conseguiu o tambor?"},
    [255082]={title="Eliminando a Concorrência",o="Voltzix Sprocketpop quer que você elimine as forças da Empreendimentos S.A. no campo de lodo ao norte.",p="Já acabaram com eles?"},
    [255083]={title="Aniquilando a Concorrência",o="Voltzix Sprocketpop quer que você elimine as forças da Empreendimentos S.A. na Mina Boulder Lode, ao norte.",p="Já acabaram com eles?"},
    [255084]={title="O Dever Solene dos Guardiões",o="Recupere o Cálice de Vozes Opalinas, o Manto de Proteção Elemental e o Anel da Rainha Louca para os Guardiões.",p="Já encontrou as relíquias?"},
    [255085]={title="Estudo Individual",o="Colete Grimórios do Sindicato dentro da Fortaleza de Stromgarde.",p="Encontrou algum grimório na fortaleza até agora?"},
    [255086]={title="Você Ouve as Sombras?",o="Verifique como está Stephana Fryth, a soldado de Stromgarde que vem agindo de forma estranha.",p="Conheço Stephana desde antes da queda da fortaleza. Não consigo deixar de me preocupar; alguma coisa nisso não me agrada..."},
    [255087]={o="Mate Espancadores e Xamãs Punho de Pedra."},
    [255088]={title="Encontrando o Invisível",o="Use as Lentes da Visão Verdadeira para procurar sombras fora do lugar na Fortaleza de Stromgarde.",p="Ouvi dizer que Alaric pediu que você investigasse o incidente com Fryth. Eu preferia que se concentrasse nas ameaças mais óbvias, mas ela era uma boa soldado e Alaric sempre cumpriu seu dever. Prossiga, se desejar."},
    [255089]={o="Mate o Tecelão de Espectros do Sindicato na Fortaleza de Stromgarde.",p="Você consegue me perceber até agora? Que interessante..."},
    [255090]={o="Mate Thalanas, o Louco, na estrada para a Propriedade Northfold.",p="Ouviu falar de outro membro do Sindicato? Então pode muito bem cuidar disso também."},
    [255091]={title="Stromgarde Caiu",o="Informe o povo restante de Stromgarde sobre a decisão de Alaric.",p="É uma decisão difícil, mas não posso sacrificar mais vidas em uma batalha perdida."},
    [255093]={title="O Último da Cavalaria",o="Fale com o Tenente Valorcall."},
    [255094]={title="O Legado de Strom",o="Intercepte Zengu na Ponte Thandol e recupere Trol’kalar."},
    [255095]={title="Confronto de Vontades",o="Resista à Rainha Sybell."},
    [255096]={title="Um Passeio Tranquilo",o="Caminhe com o Tenente Valorcall."},
    [255098]={title="Siga para Darnassus",p="Olá. Está procurando por mim?",c="Um exemplar duplicado do livro de Thelaesa? Certo, deixe-me ver.\
\
A biblioteca dela está muito bem abastecida hoje em dia, então não chega a me surpreender. De qualquer forma, este acabou vindo no carregamento por engano, então é melhor assim."},
    [255099]={p="Vai a algum lugar? Pense duas vezes antes de sair sem um dos meus hipogrifos."},
    [255100]={c="Ela mandou outro livro em troca?\
\
Sempre foi muito atenciosa. Tenho uma boa coleção de tomos sobre nossa própria história, mas o material sobre outros povos ainda é limitado. Agora que nos juntamos à Aliança, faria bem a todos aprender mais sobre nossos novos aliados. Ficarei feliz em acrescentar este às estantes."},
    [255101]={o="Use o Orbe de Subterfúgio na Montanha Rocha Negra e leve a Missiva de Vaelastrasz até Ralestrasza, perto do Desgaste Rubi, nos Pantanais."},
    [255102]={o="Encontre o Artífice Baraal no Porto de Menethil e descubra por que ele ainda não chegou a Dun Algaz."},
    [255103]={o="Encontre as peças perdidas do robô do Artífice Baraal."},
    [255104]={title="Aviso de Atraso",o="Informe aos gnomos de Dun Algaz que Baraal se reunirá com eles em breve."},
    [255105]={title="Robô Perdido",o="Encontre o robô desaparecido em Thelgen Rock."},
    [255106]={title="Comportamento Autodestrutivo",o="Leve o robô ao Engenheiro de Dun Algaz antes que ele se autodestrua.",p="Oh? Tem alguma coisa para mim?"},
    [255107]={title="O Paladino Perdido",o="Encontre Edmund Crestfall na Fortaleza de Desterro."},
    [255109]={o="Fale com o Fazendeiro Sal na Propriedade Alestone."},
    [255110]={o="Fale com o Fazendeiro Sal na Propriedade Alestone."},
    [255111]={title="Aliados Alternativos",o="Encontre o Rastreador de Meridianos Hestlor na Torre do Mago Vermelho em nome de Lady Idelia Solomon.",c="Aquela imprudente da Idelia voltou rastejando para pedir nossa ajuda, foi?\
\
Ah, claro. E nem se deu ao trabalho de explicar por que mandou você falar conosco em vez de vir pessoalmente. Que conveniente."},
    [255113]={title="Comida para Gnolls",o="Colete suprimentos de comida nos acampamentos de gnolls da Cordilheira Cristarrubra para Luca Tyndall."},
    [255114]={o="Recupere o Cálice de Tyrenel para o Padre Norice.",p="O Cálice de Tyrenel permaneceu nesta capela por gerações. Não podemos permitir que seja perdido."},
    [255116]={title="Recuperando a Serraria de Alther",o="Mate Tarântulas Maiores ao redor da Serraria de Alther para ajudar o povo de Lakeshire a recuperar a região."},
    [255117]={title="Tábuas Perfeitamente Boas",o="Colete Tábuas de Madeira na Serraria de Alther para o Encarregado Oslow.",p="É melhor trazer uma boa quantidade. Não sei de quantas ainda vou precisar antes que os ataques terminem."},
    [255118]={title="Água Própria para os Vivos",o="Busque água na base da cachoeira para Monika Sengutz.",p="Não me diga que já terminou...?"},
    [255119]={title="Água Própria para os Mortos",o="Busque água do mar na foz do rio para Monika Sengutz.",p="Quase perguntei se viu alguém que eu conhecia em Costa Sul... mas talvez seja melhor não saber."},
    [255120]={title="Água Própria para os Insanos",o="Busque um balde de água pestilenta na cachoeira do Lago Darrowmere, na fronteira das Terras Pestilentas Ocidentais.",p="Já foi buscar a água? Meus ossos doem só de pensar nessa viagem..."},
    [255121]={o="Entregue a refeição de Derak às irmãs Evermorne na estalagem da Serraria Tarren.",p="Mmmm... Que cheiro delicioso é esse?"},
    [255122]={title="História Há Muito Esquecida",d="Este lugar está cheio de segredos. Claro, é perigoso demais para eu sair explorando sozinho, e os Renegados não parecem ter muito interesse na história troll.\
\
Se estiver disposto a ajudar, há ruínas rio acima que todos evitam, até as feras. Talvez exista alguma coisa protegendo o lugar, mas tenho certeza de que está cheio de artefatos e relíquias que eu adoraria colocar as mãos.\
\
Pegue tudo que conseguir encontrar e traga para mim.",p="Encontrou alguma coisa, mon?",c="Então eram espíritos...\
\
Se eu fosse um troll melhor, diria que deveríamos encontrar uma forma de dar descanso às almas deles. Mas... isso talvez significasse abrir mão das minhas novas relíquias.\
\
Não acho que eles se importem se eu ficar com elas mais um pouquinho, né, mon?"},
    [255127]={title="Buscando Almas",o="Use o Extrator de Essência de Bergamont Lestern em humanos mortos em Strahnbrad."},
    [255130]={title="As Salas de Interrogatório",o="Procure a chave nas salas de interrogatório.",p="Encontrou a chave nas salas de interrogatório?"},
    [255131]={title="Uma Busca Inútil",d="Todos os worgens de Fosso Macabro deveriam permanecer presos e contidos. Foram trazidos para cá para que a Sociedade Real dos Boticários pudesse estudar a maldição... entendê-la e, talvez, até controlá-la. Mas, depois do que você me contou, está claro que alguém aqui busca muito mais do que simples pesquisa.\
\
Nada disso importa se eu continuar acorrentada nesta cela.\
\
As salas orientais às vezes são usadas para guardar pertences confiscados. Talvez seja lá que encontre o que procura.",o="Procure a chave nas salas orientais.",p="Diga que encontrou a chave nas salas orientais.",c="Maldição... ainda sem chave.\
\
Necromantes, você disse!?\
\
Pela Dama Sombria... eu sabia que havia algo errado!\
\
Se necromantes realmente estão soltos por este lugar, profanando cadáveres com rituais não autorizados, então meu encarceramento deixou de ser a maior preocupação.\
\
Nenhum servo leal dos Renegados, louco ou não, se rebaixaria a tamanha depravação. Forçar outra pessoa à maldição da não morte... é um crime indescritível."},
    [255132]={title="Loucura Vinda do Alto",p="Esses traidores já foram punidos?"},
    [255133]={title="O Expurgo de Fosso Macabro"},
    [255134]={o="Mate o Cronista Harvey e recupere a Chave da Cela de Fosso Macabro.",p="Tem a chave? Diga que foi o Cronista que estava com ela."},
    [255135]={title="Rotmaw",o="Mate Rotmaw e informe o Boticário Holm no Sepulcro.",p="Rotmaw está morto?"},
    [255136]={p="Você trouxe notícias de Fosso Macabro? Deixe-me ver esse diário."},
    [255140]={title="Lâminas Banhadas em Luz",o="Fortaleça 10 Sentinelas ou Defensores da Eira dos Montes na Mina Lazúli usando Óleo Sagrado de Armas."},
    [255141]={title="Pedra para Costa Sul",o="Recupere 15 pedaços de Minério de Azurita dos Mineradores da Eira dos Montes na Mina Lazúli.",p="Essas pedras não vão se minerar sozinhas, você sabe..."},
    [255142]={o="Entregue o Bilhete Elegantemente Selado do Conselheiro Belview ao Arquimago Ansirem Tecerrunas, perto da Cratera de Dalaran, nas Montanhas Alterac."},
    [255143]={title="Contendo a Cratera"},
    [255144]={o="Vasculhe os montes de escombros em busca de materiais reaproveitáveis e entregue-os aos Trabalhadores de Dalaran na Cratera de Dalaran.",c="Aprecio seus esforços. Espero que isto ajude a acelerar o trabalho.\
\
Do jeito que as coisas estão, pouco me resta além de esperar e observar como tudo se desenrola.\
\
Ainda assim... suponho que paciência seja uma virtude que estou sendo obrigado a praticar hoje."},
    [255145]={o="Destrua a Anomalia Arcana na margem leste da Cratera de Dalaran."},
    [255146]={d="Agora que a situação aqui está relativamente sob controle, como você pôde ver com os próprios olhos... importaria-se de voltar ao meu aprendiz um tanto zeloso demais e garantir a ele que tenho tudo sob controle?\
\
Francamente, ser importunado dessa maneira pelo próprio aprendiz...\
\
<O Arcimago suspira profundamente.>",o="Volte ao Conselheiro Belview, em Costa Sul, e conte a ele sobre seu trabalho na Cratera de Dalaran.",p="O Arquimago disse o quê?",c="Ah... que atrevimento!\
\
Por pouco não me teletransporto até lá para dizer umas boas verdades àquele sujeito pessoalmente!\
\
Dito isso... mesmo que ele tenha usado você para se livrar do próprio trabalho, fico aliviado em saber que o Arcimago manteve a barreira e que o progresso continua.\
\
Talvez, pelo menos por enquanto, eu possa voltar toda a minha atenção para Costa Sul.\
\
Obrigado, aventureiro."},
    [255147]={title="Vale um Tostão",o="Derrote 6 Saqueadores Ravenclaw e 6 Escravos Ravenclaw na Fazenda de Olsen."},
    [255148]={title="O Descanso dos Denholm",o="Ajude o Padre Dayton a libertar os espíritos da família Denholm no Campo dos Mortos."},
    [255149]={o="Mate Silkshadow no Contraforte de Eira dos Montes.",p="O covil dela fica a leste, perto da muralha, onde pode atacar viajantes desprevenidos... é uma criatura astuta, não é?"},
    [255150]={title="O Rei das Colinas",d="Antes de pendurar minha lança de vez, ainda há uma última ameaça nestas colinas que precisa ser abatida.\
\
Mas preste atenção... não enfrente esta caçada sozinho. Esta fera está além das capacidades de um único caçador.\
\
Chamam-no Highclaw, o maior e mais esquivo leão-da-montanha que já rastreei. Leões raramente são um problema, pelo menos para mim... mas este é diferente. Ele caça pessoas de propósito. Acampamentos, caravanas, tanto faz. Para ele, todos nós somos presas.\
\
Seja rápido e ataque sem hesitar. Não sei o que faria se ele matasse você.",o="Mate Highclaw no Contraforte de Eira dos Montes.",p="Então... está feito?",c="Não vou mentir: eu não tinha certeza de que você voltaria. E uma parte de mim se perguntava o que faria se voltasse... se eu estava realmente pronto para pendurar minha lança.\
\
Abandonar a emoção da caçada... e o dever de manter este povo em segurança.\
\
Mas agora vejo com clareza. Esse fardo já não pertence a mim. Você o carregou mais longe do que eu jamais conseguiria.\
\
Obrigado, <name>."},
    [255151]={title="Ladrões Canalhas",d="Fomos atacados por um bando de ladrões perto do Forte do Desterro — ou do que restou dele, pelo menos.\
\
Nosso grupo transportava diversas relíquias pela estrada principal e esperava conseguir repelir qualquer ladrão que cruzasse nosso caminho. Infelizmente, fracassamos, e ainda estamos nos recuperando da viagem.\
\
Você estaria disposto a recuperar nossos bens roubados antes que esses pilhadores destruam peças tão valiosas da história?",o="Recupere 8 Relíquias Roubadas do Sindicato no Forte do Desterro.",p="Conseguiu localizar parte da nossa carga?",c="Ahá! Você encontrou...!\
\
<O Historiador examina as relíquias e sua expressão desaba.>\
\
Oh... oh, não..."},
    [255152]={title="Preservando a História",d="Embora pareçam estar em bom estado para uma pessoa comum, qualquer especialista percebe o quanto estas peças foram danificadas.\
\
Nas condições atuais, não tenho certeza de que sobreviveriam a uma viagem sem se desfazer por completo.\
\
Enquanto você esteve fora, perguntei pela cidade e descobri que há um membro da Liga dos Exploradores por aqui — uma organização de arqueólogos renomados. Se houver algo que possamos fazer para preparar estes artefatos para a jornada, talvez ele tenha algum conselho para nós.",o="Leve o pacote de relíquias danificadas ao representante da Liga dos Exploradores em Costa Sul.",c="Pelas minhas barbas! Que tipo de trogg pôs as mãos nestas preciosidades?!\
\
<O anão resmunga, encarando você de forma acusadora.>\
\
Mãos pesadas são uma coisa, mas trate estas peças com um pouco mais de cuidado se sabe o que é bom para você!"},
    [255153]={title="Entrega em Menethil",o="Entregue com segurança a caixa de relíquias extremamente frágeis ao Arqueólogo Flagongut, no Porto de Menethil.",p="Eu não estava esperando uma entrega..."},
    [255154]={d="Não quero ofender, mas alguém como você realmente não deveria manusear artefatos tão frágeis.\
\
Dito isso, ficarei mais do que feliz em tirá-los das suas mãos.\
\
Agora, não quero que você vá embora de mãos vazias... leve esta moeda à pessoa de quem estou comprando estas preciosidades e, depois disso, estará livre para seguir seu caminho.",o="Leve o pagamento do Arqueólogo de volta ao Historiador Wendell, em Costa Sul.",p="Você voltou! Mas... onde estão as relíquias?"},
    [255155]={c="Obrigada. Isso é muito generoso da sua parte. Pode ter certeza de que vou aproveitar tudo muito bem."},
    [255156]={c="Isso será de grande ajuda. Vou colocar tudo em uso o mais rápido possível."},
    [255157]={p="Estamos quase prontos para sair da casa da minha filha, mas sempre parece faltar mais tecido. Se encontrar algum de que não precise, ele será muito bem aproveitado aqui."},
    [255158]={title="Uma Doação de Madeira do Bosque",c="Isso será de enorme ajuda. Com este material, a barricada deve aguentar por mais algum tempo.\
\
Se a Luz nos favorecer, talvez tempo suficiente para que logo nem precisemos mais dela. Obrigado."},
    [255159]={title="Mais Madeira do Bosque",p="A barricada continua firme e, com a batalha finalmente virando a nosso favor, comecei a ouvir conversas sobre o futuro. Talvez seja otimismo demais, mas depois de tudo que passamos, um pouco de esperança não faz mal.\
\
Quando expulsarmos o Sindicato, ainda haverá muito trabalho para restaurar a fortaleza, e precisaremos de bastante material de construção. Se encontrar Madeira do Bosque sobrando, ela será muito bem-vinda."},
    [311178]={c="O-o próprio Sangue de Zul'jin, está dizendo?\\n\\n<Budd se recompõe antes de continuar.>\\n\\nBem, agradeço o gesto, $c, mas eu poderia tê-lo derrotado facilmente. Não há como ele ser tão assustador quanto dizem as lendas. Com o tempo, você aprenderá que essas histórias costumam ser terrivelmente exageradas. O mais provável é que aquele velho miserável tenha sido vencido pela artrite!\\n\\nDe qualquer maneira, suponho que isso seja o mínimo que poderia fazer para pagar toda a gentileza que demonstrei por aqui.\\n\\nAgora vá embora. Preciso me livrar deste frasco repugnante!"},
    [313384]={d="Agora que você conseguiu a íris de foco, é hora de usar a chave.\\n\\nEmbora eu fosse gostar de ver Malygos voltando para nós, sei que isso não vai acontecer agora. Com tudo o que está em jogo, os outros Aspectos Dragônicos decidiram que o Tecencantos precisa ser eliminado.\\n\\nKrasus diz a última frase com um tremor na voz.\\n\\n$n, siga para o Olho da Eternidade, enfrente Malygos e volte aqui com o Coração da Magia."},
    [354126]={title="Rechaçando as forças invasoras dos Grislíngua"},
    [499997]={d="Escute bem, $r. Coelhos são criaturas magníficas. São gentis e confiantes, além de terem os pelos mais macios dos Reinos do Leste. Dá para fazer praticamente qualquer peça confortável com pele de coelho: botas, luvas, roupas de baixo. Foi por isso que veio, não é? Procurando um belo par de ceroulas de pele de coelho?\
\
[Opção de diálogo: Não, George. Coelhos são amigos, não acessórios.]\
\
Ora, que resposta adorável. Então me diga, $r: se ama tanto os coelhos, estaria disposto a fazer qualquer coisa por eles? Até mesmo provar sua lealdade trazendo uma cenoura bem grande?",o="Prove a George Candarte que você é amigo dos coelhos levando até ele uma Cenoura Grande.",p="Ora, essa é a maior cenoura que já vi na vida."},
    [499998]={title="Em busca de coelhos"},
    [499999]={d="Ah, bom dia, $r. Os espíritos desejam a você uma feliz Jardinova. Pena que a ocasião não seja tão feliz para eles...\
\
Uma estranha tristeza emana dos nobres espíritos, herói. Ao longe, em Mulgore, algo clama em desespero. Você estaria disposto a viajar até lá e descobrir a origem dessa tristeza? A Jardinova deveria ser uma ocasião alegre para todos.",o="Viaje até Mulgore e descubra a origem da tristeza.",p="Jardinova — texto provisório nº 14."},
    [500003]={d="Nas profundezas da Garganta do Sussurro Sombrio, algo profano criou raízes. Entre pedras enegrecidas e terra queimada, Espinhos da Praga Vil rasgam o solo — crescimentos retorcidos saturados de energia vil.\
\
Esses espinhos sangram um icor verde quando cortados, e alguns dizem que sussurram quando o vento passa por eles. Não são naturais. E estão se espalhando.\
\
Acreditamos que possam ser resses — ou prenúncios — de antigos rituais demoníacos enterrados sob a Garganta. Se a Legião estiver tentando despertar algo sob o gelo, esses espinhos podem ser o primeiro sinal.\
\
Traga-me amostras, $n. Mas tome cuidado: onde esses espinhos crescem, as sombras caminham logo atrás."},
    [500005]={d="Mandaram você? Se for mais um daqueles gerentes de contrato imprestáveis, dê meia-volta e volte por onde veio. Estou atolado em encomendas ruins e papelada ainda pior.\
\
Acabamos de receber um pedido extra de Altaforja. Grande e urgente. Em vez de mandarem mais trabalhadores, trocaram toda a equipe de lenhadores. Não há tempo para treinamento nem planejamento; só querem o serviço pronto.\
\
Estou atrasado, e odeio ficar atrasado. Se sabe usar um machado e não se importa com o frio, sua ajuda seria bem-vinda. Precisamos de doze Troncos de Pinheiro Gélido das árvores próximas.\
\
Não é caridade. Garanto que valerá a pena.",o="Derrube árvores próximas ao Acampamento Talhafrio, em Dun Morogh, e traga 12 Troncos de Pinheiro Gélido.",c="Isto serve. Não está perfeito, mas é melhor do que nada. Você acabou de me livrar de um sermão e de uma noite congelante fora do alojamento.\
\
Pegue isto. Você merece mais do que apenas um agradecimento."},
    [580200]={title="Caminho da Ascensão — Curinga: Bilhetes de Negraluna",d="Você recebe Bilhetes de Negraluna ao abrir Pacotes de Cartas Selados.\
\
Troque os bilhetes com Silas Negraluna por Cartas de Habilidade Comuns, Incomuns, Raras e Épicas. Guarde-os para adquirir cartas importantes para sua composição.\
\
Também é possível comprar recompensas cosméticas. As Bolsas de Bilhetes de Negraluna permitem transferir bilhetes entre personagens da mesma conta.",o="Visite Silas Negraluna em uma capital, abra o menu de recompensas e compre uma Bolsa de Bilhetes de Negraluna por 25 bilhetes.",c="Agora você sabe como obter e gastar Bilhetes de Negraluna. Use-os para ampliar sua coleção de Cartas de Habilidade, adquirir recompensas cosméticas ou transferi-los entre personagens da conta."},
    [650142]={c="A arte carmesim agora flui por você, $n. Consigo sentir o poder em suas veias e a disposição para sacrificar a própria vida em troca de uma força mágica maior. Você escolheu o perigoso caminho da magia de sangue.\\n\\nComo Mago de Sangue, aprenderá a manipular a própria essência da vida, transformando sangue em energia mágica bruta. Sua vitalidade alimentará feitiços de poder incrível, enquanto a força vital de seus inimigos se tornará sua arma. Esta é a magia em sua forma mais primordial e perigosa.\\n\\nLembre-se sempre de que cada feitiço lançado tem um preço. Seu sangue, o sangue de seus inimigos e o sangue do sacrifício se tornam componentes de sua arte sombria. Para aqueles corajosos o bastante para pagar esse preço, porém, as recompensas estão além da compreensão comum.\\n\\nO caminho carmesim agora é seu. Que seu poder cresça a cada gota derramada."},
    [650144]={c="Os sussurros ficam mais fortes agora que você se juntou a nós, $n. Consigo ouvir os Antigos falando sobre seu potencial, suas vozes ancestrais carregadas por ventos que mentes comuns não conseguem perceber. Você escolheu o caminho do conhecimento proibido.\\n\\nComo Cultista, aprenderá a comungar com entidades além da compreensão mortal, obtendo poder por meio de pactos perigosos e sabedoria sobrenatural. Sua magia tocará forças anteriores à própria civilização.\\n\\nEsse conhecimento traz grandes riscos. Os sussurros podem levar mentes fracas à loucura, e os seres com quem você entra em contato não se importam com assuntos mortais. Mas, para quem tem força para resistir, os próprios segredos do universo ficam ao alcance.\\n\\nEscute com atenção o que eu ensinar. Os Antigos estão sempre observando e não toleram o fracasso daqueles que os servem."},
    [650145]={c="As energias vis agora reconhecem você, $n. Sua alma carrega a marca de alguém disposto a abraçar o poder demoníaco sem hesitação. Em uma era governada por fogo e ruína, apenas aqueles fortes o bastante para reivindicar a corrupção sobrevivem.\\n\\nComo um dos Juramentados pelo Vil, você vinculará essências demoníacas por meio de dominação e pactos, arrancará aliados infernais da Espiral Etérea e curvará as chamas da Legião Ardente à sua vontade. Esse poder nunca foi criado para ser contido. Ele existe para ser tomado.\\n\\nMuitos dos que percorrem esse caminho são consumidos pela corrupção porque não possuem força de vontade para controlá-la. Você não será. Os sussurros dos demônios não são avisos, mas revelações: verdades oferecidas apenas àqueles implacáveis o bastante para ouvi-las.\\n\\nAs chamas vis agora ardem dentro de você. Deixe que consumam a dúvida, a misericórdia e a fraqueza. O poder é sua própria justificativa. Que este presente refaça o mundo à sua imagem."},
    [650149]={c="Os elementos brutos agora fluem através de você, $n! Você escolheu abraçar as forças mais primitivas da própria criação, tornando-se um canal para a terra, o ar, o fogo e a água em suas formas mais puras.\\n\\nComo Primalista, você aprenderá a comandar a magia elemental com poder e fúria sem precedentes. Seus feitiços provocarão erupções vulcânicas, terremotos devastadores, ventos com força de furacão e inundações repentinas. Os próprios elementos fundamentais da realidade responderão ao seu chamado.\\n\\nEsse poder vem dos alicerces do mundo, sendo mais antigo e perigoso do que qualquer magia concebida por mortais. Os elementos não se importam com as preocupações da civilização: respondem apenas à força e ao respeito. Demonstre fraqueza, e eles consumirão você.\\n\\nAs forças primevas aceitaram você como campeão. Que se mostre digno de empunhar os poderes fundamentais da própria criação."},
    [650150]={c="A natureza reconhece um dos seus, <name>! Vejo em seus olhos a bênção da floresta, o chamado selvagem que marca os verdadeiros Patrulheiros. Você escolheu tornar-se guardião da própria natureza.\
\
Como Patrulheiro, aprenderá a se mover sem ser visto em qualquer terreno, a se comunicar com feras selvagens como irmãos e a atacar das sombras com precisão mortal. As florestas o esconderão, os animais o ajudarão e seus inimigos jamais verão a morte se aproximar.\
\
Os bosques sagrados de Teldrassil têm muito a ensinar. Você aprenderá a ler sinais ignorados por outros, rastrear presas em qualquer superfície e sobreviver nas regiões mais hostis. Seu arco cantará canções de morte, e sua lâmina provará o sangue daqueles que ameaçam o mundo natural.\
\
Os espíritos da floresta recebem seu novo protetor. Que suas flechas voem certeiras e que seu caminho permaneça oculto daqueles que fariam mal."},
    [760001]={d="Seu próximo adversário é Ironhide Gorefist, um brutal guerreiro de sangue ogro do clã Rocha Negra.\
\
Ele abriu caminho na pancada por metade dos Reinos do Leste. Suas correntes características ecoam em cada luta como um sino fúnebre, ficando mais altas a cada golpe. Quando começam a chacoalhar, a multidão sabe que alguém está prestes a cair.\
\
O público já provou o primeiro gosto de sangue. Agora quer um banquete. Dê a eles Ironhide.",c="Então... o brutamontes finalmente caiu. Eu não achava que você duraria mais de um minuto contra ele, mas aqui está: ensanguentado e ainda respirando.\
\
Aquilo não foi apenas uma luta. Você conquistou o respeito dos veteranos, dos apostadores e dos assassinos que já viram de tudo. Está um passo mais perto de conquistar seu lugar na lenda da arena.\
\
Não relaxe. O próximo desafio vai bater ainda mais forte."},
    [900452]={p="Hhh… o ar se tensa quando acho em esse lugar. Você foi a Fortaleza de Ira Rocalarga e você acabou com quem envenena os espíritos."},
    [967027]={p="Extraes sua habilidade para desencantar itens mágicos e canalizas essa energia através da Fulgerita Apretada pelo Eternévoa na tableta diante de você. Relâmpago surgen desde a tableta e se conectam com a energia canalizada antes de descargar um estruendoso trovão. O único rastro da tableta é uma pequena pilha de Pó do Eternévoao que coleta rápido."},
    [967028]={p="Extraes sua habilidade para desencantar itens mágicos e canalizas essa energia através da Fulgerita Apretada pelo Eternévoa na tableta diante de você. Relâmpago surgen desde a tableta e se conectam com a energia canalizada antes de descargar um estruendoso trovão. O único rastro da tableta é uma pequena pilha de Pó do Eternévoao que coleta rápido."},
    [967029]={p="Extraes sua habilidade para desencantar itens mágicos e canalizas essa energia através da Fulgerita Apretada pelo Eternévoa na tableta diante de você. Relâmpago surgen desde a tableta e se conectam com a energia canalizada antes de descargar um estruendoso trovão. O único rastro da tableta é uma pequena pilha de Pó do Eternévoao que coleta rápido."},
    [967492]={d="Você adquiriu poder suficiente para cumprir minha vontade, Forjado pelo Vil. Chegou a hora de massacrar nossos inimigos. Grandes recompensas aguardam quem levar nosso Plano Mestre à conclusão.\
\
Os orcs Mag'har sobreviveram em Terralém por tempo demais. Precisamos agir antes que recebam reforços da Horda. Viaje até o Posto Mag'har e ceife suas almas!",o="Massacre os orcs Mag'har.",p="O Plano Mestre ainda não foi concluído. Volte quando tiver cumprido suas ordens."},
    [980000]={title="Pela Horda: Esmagando os Caçadores (Alto Risco)",o="Colete um Núcleo de Esmagador Corrompido e uma Lança de Ogro Ensanguentada."},
    [980004]={o="Recupere as poções roubadas nos acampamentos dos Défias em Cerro Oeste."},
    [980104]={o="Assassine a Subjugadora Vaz’shir e mate Guardas do Terror dentro de Oshu’gun."},
    [980106]={title="Guerra em Nagrand: Guerra na Crista (Alto Risco)",o="Mate os cultistas Sombra da Morte na Crista do Crepúsculo."},
    [980107]={title="Guerra em Nagrand: Ódio e Medo (Alto Risco)",o="Mate os Supervisores dos Campos-forja e seus seguidores no Campo-forja: Ódio e no Campo-forja: Medo."},
    [980112]={o="Assassine os ogros Giralança nos arredores do Covil de Gruul."},
    [980113]={title="Guerra nas Montanhas da Lâmina Afiada: Armadilha Mortal (Alto Risco)",o="Execute Baelmon, o Mestre dos Cães, e seus lacaios no Portão da Morte."},
    [980114]={title="Guerra nas Montanhas da Lâmina Afiada: Uma Caçada Ogri'norme (Alto Risco)",o="Destrua os Portadores da Chama Abissal, Javalis Cascadura e Cães da Ira no alto do Pináculo do Vórtice."},
    [980115]={title="Guerra nas Montanhas da Lâmina Afiada: A Presa do Corvo (Alto Risco)",o="Elimine Corvos Desprezados e Arautos Grishna e derrote a Matriarca Grishna."},
    [980120]={o="Cace a fauna dentro do Ecodomo do Meio."},
    [980121]={o="Mate Cragskaar e os Rompedores Farahlon em Pedranévoa."},
    [980122]={title="Guerra em Eternévoa: O que é Seu é Meu (Alto Risco)",o="Limpe a Mina Trellium sob a Manaforja Ara e o Poço de Acesso Zeon sob a Manaforja Ultris."},
    [980123]={title="Guerra em Eternévoa: Forjado pela Guerra (Alto Risco)",o="Devaste as forças da Manaforja Duro e da Manaforja Coruu."},
    [980128]={o="Extermine as nagas na Cisterna Serpentália."},
    [980129]={title="Guerra no Vale da Lua Negra: Eu Me Tornei a Morte, Destruidor de Forjas (Alto Risco)",o="Ataque a Forja da Morte. Mate os Guardiões da Forja da Morte e colete o cajado do Evocador Skartax e Estilhaços de Alma Retorcida de seus evocadores."},
    [980130]={title="Guerra no Vale da Lua Negra: Caçando Demônios Illidari (Alto Risco)",o="Derrote os Mestres Caçadores de Demônios nas Ruínas de Karabor."},
    [980131]={o="Massacre os peões Presa do Dragão e os Ascendentes Presa do Dragão que os supervisionam no Arrecife Asa Etérea."},
    [980232]={title="Guerra em Nagrand: Solução Cristalina (Alto Risco)",o="Elimine os etéreos Vir’aani nos arredores de Oshu’gun."},
    [980233]={title="Guerra em Nagrand: Campos de Sombra (Alto Risco)",o="Mate as criaturas do Caos nos arredores de Oshu’gun."},
    [980234]={o="Mate os ogros Punho de Pedra na Fenda do Vento Norte e na Fenda do Vento Sul."},
    [980235]={title="Guerra em Nagrand: Acabe com a Lama (Alto Risco)",o="Extermine as Criaturas de Lama sob Halaa."},
    [980236]={title="Guerra em Nagrand: Limpeza de Primavera (Alto Risco)",o="Extermine os Sangue Turvo no Posto Solavera."},
    [980237]={title="Guerra nas Montanhas da Lâmina Afiada: Ruuan e o Culto das Serpes (Alto Risco)",o="Mate os arakkoas Ruuan’ok e os cultistas do Culto das Serpes Asa Negra no Bosque Ruuan."},
    [980238]={title="Guerra nas Montanhas da Lâmina Afiada: Cânion Malho Sangrento (Alto Risco)",o="Mate os ogros Malho Sangrento no Cânion Malho Sangrento."},
    [980239]={title="Guerra nas Montanhas da Lâmina Afiada: Silenciando a Crista Harmônica (Alto Risco)",o="Extermine os Dracos Etéreos Menores e os Esfoladores de Cristal na Crista Harmônica."},
    [980240]={title="Guerra nas Montanhas da Lâmina Afiada: Ataque Arakkoa (Alto Risco)"},
    [980241]={title="Guerra nas Montanhas da Lâmina Afiada: Patrulheiro da Mata do Corvo (Alto Risco)",o="Elimine os ogros Boulder’mok e os cultistas do Culto das Serpes Asa Negra na Mata do Corvo."},
    [980242]={title="Guerra em Eternévoa: Engenharia 100% de Qualidade (Alto Risco)",o="Mate Engenheiros Gan’arg e Ferreiros da Perdição Mo’arg."},
    [980243]={title="Guerra em Eternévoa: As Ruínas Têm Olhos (Alto Risco)"},
    [980244]={title="Guerra em Eternévoa: Obsolescência Planejada (Alto Risco)"},
    [980245]={title="Guerra em Eternévoa: Enterre os Solfúria (Alto Risco)",o="Mate os elfos sangrentos Solfúria da Manaforja B’naar."},
    [980246]={title="Guerra em Eternévoa: Saqueador de Ruínas (Alto Risco)",o="Mate os draeneis Desencarnados nas Ruínas de Enkaat e os demônios Arklon nas Ruínas de Arklon."},
    [980247]={title="Guerra no Vale da Lua Negra: Baa'ri é um Desafio (Alto Risco)",d="Há uma recompensa pelos Partidos Grislíngua e pelos Supervisores Illidari nas Ruínas de Baa'ri. Illidan ordenou que os Grislíngua escavassem a área em busca de antigos artefatos draeneis que, segundo rumores, guardam segredos do Templo de Karabor, hoje conhecido como Templo Negro. Vá até as Ruínas de Baa'ri e reivindique a recompensa, mas cuidado, <name>: você não é o único aventureiro que aceitou este contrato. Esteja preparado para enfrentar concorrência durante a caçada!",o="Mate os Partidos Grislíngua e os Supervisores Illidari nas Ruínas de Baa’ri."},
    [980248]={title="Guerra no Vale da Lua Negra: Alarme de Sereia (Alto Risco)",o="Mate as Sereias Serpentália que vivem no Pontal Serpentália."},
    [980249]={o="Massacre os Dimetrodontes Fogo Vil e os Javalis Vis nos Campos de Magma."},
    [980250]={title="Guerra no Vale da Lua Negra: Tem um Pontal? (Alto Risco)"},
    [980251]={d="A Fortaleza Presa do Dragão serve como base avançada dos orcs Presa do Dragão no Vale da Lua Negra.\
\
Eles escravizam dracos para fazer sua vontade e usam a fortaleza como centro de suas operações sob as ordens vis de Zuluhed.\
\
Siga até os Campos da Asa Etérea e verá a enorme fortaleza erguida contra as montanhas.\
\
Mate todos os orcs Presa do Dragão que encontrar por lá e garanta que teremos uma ameaça a menos com que lidar."},
    [980252]={title="Guerra no Pântano Zíngaro: Tribos Perdidas (Alto Risco)",o="Elimine os habitantes da Vila Charco das Feras no Pântano Zíngaro."},
    [980253]={title="Guerra no Pântano Zíngaro: A Cristanegra (Alto Risco)",o="Elimine os habitantes da Praia Cristanegra no Pântano Zíngaro."},
    [980254]={title="Guerra no Pântano Zíngaro: O Charco Fantasma (Alto Risco)",o="Elimine os habitantes do Charco Fantasma no Pântano Zíngaro."},
    [980255]={title="Guerra no Pântano Zíngaro: Nagas Sangrescama (Alto Risco)",o="Elimine os habitantes das Terras Sangrescama no Pântano Zíngaro."},
    [980256]={title="Guerra no Pântano Zíngaro: O Vale dos Rebentos (Alto Risco)",o="Elimine os habitantes do Vale dos Rebentos no Pântano Zíngaro."},
    [980257]={title="Guerra no Pântano Zíngaro: Terras de Ango'rosh (Alto Risco)",o="Elimine os habitantes das Terras de Ango’rosh no Pântano Zíngaro."},
    [980258]={title="Guerra no Pântano Zíngaro: Fortaleza Ango'rosh (Alto Risco)",o="Elimine os habitantes da Fortaleza Ango’rosh no Pântano Zíngaro."},
    [980259]={title="Guerra na Mata Terokkar: Picos da Barreira (Alto Risco)",o="Elimine os habitantes dos Picos da Barreira na Mata Terokkar."},
    [980260]={title="Guerra na Mata Terokkar: Tuurem (Alto Risco)",o="Elimine os habitantes de Tuurem na Mata Terokkar."},
    [980261]={title="Guerra na Mata Terokkar: Pontal Asardente (Alto Risco)",o="Elimine os habitantes do Pontal Asardente na Mata Terokkar."},
    [980262]={title="Guerra na Mata Terokkar: Skettis (Alto Risco)",o="Elimine os habitantes de Skettis na Mata Terokkar."},
    [980263]={title="Guerra na Mata Terokkar: Véu Shalas (Alto Risco)",o="Elimine os habitantes do Véu Shalas na Mata Terokkar."},
    [980264]={title="Guerra na Mata Terokkar: Tumba das Luzes (Alto Risco)",o="Elimine os habitantes da Tumba das Luzes na Mata Terokkar."},
    [980265]={title="Guerra na Mata Terokkar: Ruínas dos Olhos Sangrentos (Alto Risco)",o="Elimine os habitantes das Ruínas dos Olhos Sangrentos na Mata Terokkar."},
    [980266]={title="Guerra na Mata Terokkar: Ruínas Mascaosso (Alto Risco)",o="Elimine os habitantes das Ruínas Mascaosso na Mata Terokkar."},
    [980267]={title="Guerra na Mata Terokkar: Tumba Sombria (Alto Risco)",o="Elimine os habitantes da Tumba Sombria na Mata Terokkar."},
    [980268]={title="Guerra no Pântano Zíngaro: Aldeia do Charco Sombrio (Alto Risco)",o="Elimine os habitantes da Aldeia do Charco Sombrio no Pântano Zíngaro."},
    [980269]={title="Guerra no Pântano Zíngaro: Aldeia Lamadaga (Alto Risco)",o="Elimine os habitantes da Aldeia Lamadaga no Pântano Zíngaro."},
    [1005367]={title="Falta de Suprimentos: Pedra de Amolar Grosseira"},
    [1005645]={title="Fazendo a Carne Render: Carne Temperada de Lobo",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 20 Carne Temperada de Lobo para conseguirmos atender à demanda.",o="Colete 20 Carne Temperada de Lobo.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005646]={title="Fazendo a Carne Render: Bife de Coiote",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Bifes de Coiote para conseguirmos atender à demanda.",o="Colete 10 Bifes de Coiote.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005647]={title="Fazendo a Carne Render: Bolinho de Caranguejo",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Bolinhos de Caranguejo para conseguirmos atender à demanda.",o="Colete 10 Bolinhos de Caranguejo.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005648]={title="Fazendo a Carne Render: Costelinhas Suínas Ressecadas",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Costelinhas Suínas Ressecadas para conseguirmos atender à demanda.",o="Colete 10 Costelinhas Suínas Ressecadas.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005649]={title="Fazendo a Carne Render: Mariscos Fervidos",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Mariscos Fervidos para conseguirmos atender à demanda.",o="Colete 10 Mariscos Fervidos.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005650]={title="Fazendo a Carne Render: Mariscos Recheados à Moda Goblínica",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 10 Mariscos Recheados à Moda Goblínica para conseguirmos atender à demanda.",o="Colete 10 Mariscos Recheados à Moda Goblínica.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005651]={title="Fazendo a Carne Render: Linguiça de Aranha",d="Saudações, herói! Estamos enfrentando uma falta de suprimentos e precisamos da ajuda de um artesão do seu nível. Traga 15 Linguiças de Aranha para conseguirmos atender à demanda.",o="Colete 15 Linguiças de Aranha.",c="Excelente. Isso deve aliviar nossa falta de suprimentos por enquanto. Bom trabalho, herói!"},
    [1005652]={title="Finalizando os Curativos: Bandagem de Linho Grossa",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 20 Bandagens de Linho Grossas para ajudar a repor nosso estoque.",o="Colete 20 Bandagens de Linho Grossas.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005653]={title="Finalizando os Curativos: Bandagem de Lã",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 40 Bandagens de Lã para ajudar a repor nosso estoque.",o="Colete 40 Bandagens de Lã.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005654]={title="Finalizando os Curativos: Bandagem Grossa de Lã",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 20 Bandagens Grossas de Lã para ajudar a repor nosso estoque.",o="Colete 20 Bandagens Grossas de Lã.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005655]={title="Finalizando os Curativos: Bandagem de Seda",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 30 Bandagens de Seda para ajudar a repor nosso estoque.",o="Colete 30 Bandagens de Seda.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005656]={title="Finalizando os Curativos: Bandagem Grossa de Seda",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 15 Bandagens Grossas de Seda para ajudar a repor nosso estoque.",o="Colete 15 Bandagens Grossas de Seda.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005657]={title="Finalizando os Curativos: Antipeçonha",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 10 Antipeçonhas para ajudar a repor nosso estoque.",o="Colete 10 Antipeçonhas.",c="Perfeito. Com esse material, nosso estoque volta a ficar em ordem."},
    [1005658]={title="Finalizando os Curativos: Bandagem de Magitrama",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 20 Bandagens de Magitrama para ajudar a repor nosso estoque.",o="Colete 20 Bandagens de Magitrama.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005659]={title="Finalizando os Curativos: Bandagem Grossa de Magitrama",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 10 Bandagens Grossas de Magitrama para ajudar a repor nosso estoque.",o="Colete 10 Bandagens Grossas de Magitrama.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005660]={title="Finalizando os Curativos: Bandagem de Runatrama",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 40 Bandagens de Runatrama para ajudar a repor nosso estoque.",o="Colete 40 Bandagens de Runatrama.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005661]={title="Finalizando os Curativos: Bandagem Grossa de Runatrama",d="Saudações, herói! Estamos com poucos suprimentos médicos. Traga 20 Bandagens Grossas de Runatrama para ajudar a repor nosso estoque.",o="Colete 20 Bandagens Grossas de Runatrama.",c="Perfeito. Com essas bandagens, nosso estoque volta a ficar em ordem."},
    [1005662]={title="Por um Fio: Boca-negra Oleoso",o="Colete 7 Boca-negras Oleosos."},
    [1005663]={title="Por um Fio: Vermelhão Cru",o="Colete 10 Vermelhões Crus."},
    [1005664]={title="Por um Fio: Sabichão Cru",o="Colete 10 Sabichões Crus."},
    [1005665]={title="Por um Fio: Pargo-de-fogo",o="Colete 7 Pargos-de-fogo."},
    [1005666]={title="Por um Fio: Pargo-da-noite Cru",o="Colete 7 Pargos-da-noite Crus."},
    [1005667]={title="Por um Fio: Parrudo Lustroso Cru",o="Colete 10 Parrudos Lustrosos Crus."},
    [1005668]={title="Por um Fio: Bacalhau Escama-de-pedra Cru",o="Colete 10 Bacalhaus Escama-de-pedra Crus."},
    [1005669]={title="Por um Fio: Enguia Petrescama",o="Colete 6 Enguias Petrescama."},
    [1005670]={title="Por um Fio: Sabichão Maior Cru",o="Colete 10 Sabichões Maiores Crus."},
    [1007470]={d="Temos pedidos para entregar e meus joalheiros ainda estão se acostumando com esta nova profissão...\
\
Precisamos da sua ajuda, herói. Pode ser um trabalho simples, mas esses pedidos já estão atrasados.\
\
Colete 1 Colar das Profundezas. Naturalmente, você será muito bem recompensado pela ajuda."},
    [1007495]={d="Parece que acabaram as ervas da nossa mistura mais recente...\
\
Precisamos da sua ajuda, herói. Pode ser um trabalho simples, mas nossa última mistura está vendendo rápido e os ingredientes estão acabando. Produzimos tudo com ervas naturais e sem sabores adicionados. Será que pode nos fazer um favor?\
\
Colete 4 Elixires de Maestria. Naturalmente, você será muito bem recompensado pela ajuda."},
    [1007530]={d="Temos pedidos para entregar e meus joalheiros ainda estão se acostumando com esta nova profissão...\
\
Precisamos da sua ajuda, herói. Pode ser um trabalho simples, mas esses pedidos já estão atrasados.\
\
Colete 1 Anel de Kório das Folhas. Naturalmente, você será muito bem recompensado pela ajuda."},
    [1007534]={d="Temos pedidos para entregar e meus joalheiros ainda estão se acostumando com esta nova profissão...\
\
Precisamos da sua ajuda, herói. Pode ser um trabalho simples, mas esses pedidos já estão atrasados.\
\
Colete 1 Anel de Kório das Sombras. Naturalmente, você será muito bem recompensado pela ajuda."},
    [1008023]={title="Contrato de Demônio: Ouça-os Cair"},
    [1008025]={title="Contrato de Demônio: Queda dos Invernosos"},
    [1100039]={title="Guerreiro: Pergaminhos Místicos"},
    [1100059]={title="Guerreiro: Pergaminhos Místicos"},
    [1313384]={d="Agora que você conseguiu a íris de foco, é hora de usar a chave.\\n\\nEmbora eu fosse gostar de ver Malygos voltando para nós, sei que isso não vai acontecer agora. Com tudo o que está em jogo, os outros Aspectos Dragônicos decidiram que o Tecencantos precisa ser eliminado.\\n\\nKrasus diz a última frase com um tremor na voz.\\n\\n$n, siga para o Olho da Eternidade, enfrente Malygos e volte aqui com o Coração da Magia."},
    [1650006]={d="Então... está se sentindo útil?\
\
Sim, tenho algo para você.\
\
Como provavelmente já percebeu, não é coincidência as docas estarem cheias de espiões. Alguém os avisou. E sabemos que esse alguém está aqui embaixo.\
\
De um jeito ou de outro, os ratos dos esgotos sempre sabem o que acontece neste labirinto fedorento.\
\
Pressione-os.\
\
Intimide quantos forem necessários até que um deles ceda e nos dê o que precisamos. Você não é delicado demais para esse tipo de trabalho, é?"},
    [1650010]={c="Você veio em busca de respostas, mas minha presença provavelmente levantará ainda mais perguntas.\
\
Não tema. Servimos ao SI:7 e à Aliança. Em breve, entenderá tudo o que precisa saber.\
\
Boas-vindas à Sombra, <name>."},
    [1650012]={title="Em Busca do Mago"},
    [1650014]={c="<Diante das criptas ligadas à Catedral de Ventobravo, o corpo de um humano bem-vestido está caído no chão. Suas joias reluzem com a elegância inconfundível da nobreza. Não há dúvida: este é o nobre Silverbrook, que Alaric deveria encontrar para quitar a dívida.>\\n\\n<Ao examinar o corpo mais de perto, você encontra marcas de mordidas e arranhões profundos. O golpe fatal parece ter sido o rompimento da jugular.>\\n\\n<Você pensa no que fazer com os pagamentos de aluguel que recolheu... mas não há dúvida de que esse ouro será mais útil para você do que para um morto.>"},
    [1650021]={o="Acorde os trabalhadores oferecendo o que cada um pedir. Depois, leve um café a Durgan.",p="Quero sentir o rugido das máquinas funcionando a plena potência."},
    [1650026]={o="Elimine os membros da Horda, queime os navios e enfrente o líder da operação no acampamento da Horda na praia.",p="Partir sem expulsar a Horda de nossas praias seria imprudente."},
    [1650027]={o="Neutralize os reservatórios de praga e mate o Necromante Venthral.",p="Uma criação como a Praga dos traidores nunca trará nada de bom. É nosso dever erradicar tudo o que esses monstros fizeram."},
    [1650029]={title="Pedido em Andamento"},
    [1650030]={title="Preparando a Guerra"},
    [1650100]={o="Use o elevador na Fenda das Sombras em Orgrimmar e mostre a carta ao Renegado chamado Caindres, na fonte das Profundezas de Orgrimmar.",p="<A mão do Renegado vai direto ao punhal quando você se aproxima.>"},
    [1650108]={o="Vá até o Refúgio de Vil, o Vesgo, no fim do Distrito do Caldeirão, nas Profundezas de Orgrimmar, e coloque o sedativo nas bebidas dos soldados da Horda.",p="A gente se conhece?"},
    [1650110]={d="A emboscada me custou um punhado de bons guerreiros. Alguns encontraram sua morte verdadeira. Outros se perderam no caos, e ainda não os encontramos.\
\
<Os olhos vermelhos de Lenara brilham como gemas cruéis. O salto da bota dela pressiona a mão do orc, fazendo os ossos estalarem sob o peso.>\
\
Quero que encontre meus homens. Barguist, nosso cão, ajudará a rastreá-los. Não se preocupe: a condição de morto-vivo não prejudicou o faro dele. Basta dar uma pista para seguir.\
\
Certifique-se de que meus guerreiros voltem inteiros — figurativamente falando, é claro.",o="Encontre pistas dos Renegados desaparecidos e use Barguist para rastreá-los.",c="Uma elfa mandou você para ajudar?"},
    [1650111]={o="Derrote 12 Iluminados dos Patriarcas e liberte 4 Pacientes Renegados na Gruta dos Patriarcas."},
    [1650113]={o="Fale com Lucranta no Covil de Lucranta, nas Profundezas de Orgrimmar, e assegure o controle dos pacificados."},
    [1650117]={o="Mostre o selo de Kagtha no quartel dos Dardos e peça uma audiência com a Duquesa."},
    [1650119]={o="Elimine 10 morcegos usando os arpões na Coroa de Madeira, nas Profundezas de Orgrimmar.",p="Ainda consigo ouvir os guinchos daqueles ratos voadores.\
\
Vai se livrar dos morcegos ou devo deixar Ardayn apodrecer na cela?"},
    [1650120]={o="Use a chave para abrir a jaula de Ardayn na Coroa de Madeira, nas Profundezas de Orgrimmar, e desamarre-o."},
    [1650124]={d="Agradeço por ter me libertado. Ainda assim... isto não me parece certo. Esses soldados só estavam seguindo ordens. Espero... que você não tenha matado todos.\
\
<Glotka dá de ombros, claramente abatido. Não é a reação que se esperaria de alguém que acabou de ser libertado de uma cela.>\
\
Kagtha vai querer saber que ainda estou disposto a assinar os papéis. Depois disso, não tenho muitas outras opções. Vá na frente. Preciso de um momento para me recompor...",o="Volte até Kagtha e informe o paradeiro de Glotka e sua disposição para fechar o acordo.",c="Como sempre, você fez um bom trabalho, <name>. Tem meu reconhecimento.\
\
Mas não podemos relaxar. Entre os espiões da Aliança e isto agora, nossa missão está em risco.\
\
Precisamos agir rápido e concluir os preparativos antes que tenham a chance de arruinar nosso plano."},
    [1650127]={p="Lembre-se: coloque os documentos no baú do comandante inimigo. Precisamos que Garrosh e os Kor’kron culpem a Aliança pelos incêndios da Colina Navalha."},
    [1650129]={o="Avise Kagtha quando estiver pronto para partir rumo ao Arquipélago Azzar."},
    [1650131]={p="<A Duquesa boceja, irradiando um tédio verdadeiramente imperial.>\
\
Ah, não, claro... não se preocupe. Leve todo o tempo de que precisar..."},
    [1650236]={o="Distribua 10 garrafas de Água Refrescante da Selma aos apertadores de porcas da montanha-russa."},
    [1650274]={o="Distribua 10 garrafas de Água Refrescante da Selma aos apertadores de porcas da montanha-russa."},
    [1660014]={title="Em busca da carne boa"},
    [1660054]={d="<Parece que você é uma das raras almas curiosas dispostas a ouvir o sermão de uma banshee.>\
\
<Talvez ela tenha algo interessante para compartilhar.>",c="A curiosidade não está entre as Três Virtudes que seguimos no Culto da Sombra Esquecida.\
\
Mas é a antessala delas."},
    [1660058]={d="Sussurros. Eles acham que ninguém percebeu, mas eu durmo com o ouvido no chão! Ha!\
\
Cavam, cavam e cavam. Vão atacar quando você menos esperar... a menos que faça alguma coisa primeiro.\
\
Kobolds, kobolds e mais kobolds. Debaixo dos nossos pés! Cuidado onde pisa!\
\
Encontre as tocas deles e ponha fogo. Esmague tudo. Com um martelo grande e pesado!\
\
<Ela ri sozinha e depois encara o horizonte.>",o="Encontre e destrua as tocas de kobolds ao redor de Vila d’Ouro.",c="<Clara, a Louca, segura uma maçã na mão direita e a admira como se fosse seu bem mais precioso.>\
\
Vila d’Ouro é como esta maçã.\
\
<Devagar, ela gira a fruta e mostra uma mordida; por dentro, apesar da aparência, está podre e cheia de vermes.>"},
    [1660061]={c="<O velho orc ouve seu relato sobre o Vale das Provações com os olhos semicerrados.>\
\
Nunca gostei daquela Hirsutta. E nunca confiei no vodu dela. Uma pena o tempo ter provado que eu estava certo.\
\
É uma bênção que tenha conseguido derrotá-la. Mas temo que o eco da ambição dela não desapareça tão cedo. As consequências do ritual já repercutem até aqui, em Monte Navalha."},
    [1660063]={c="<Os olhos do goblin brilham como os de um criança que receba balas ao ver com as reliquias elficas.>\\\
Espléndido! Maravilha! Incrível!\\\
Vou a fazer uma fortuna com isto. Bem... <se corta antes de mencionar um número>. Talvez me pasé um pouco. Veja isto, o estado é terrível Ninguém pagará o máximo por algo tão desgastado...\\\
Em fim. Não posso dizer o que não cumpla mims promesas. Aqui tem uma pequena recompensa por suas esforços... simbólica, claro esta."},
    [1660071]={d="Espere.\
\
Tem mais uma coisa. <A voz de Thariel sai tensa; as palavras tropeçam em seus lábios.>\
\
Aquele culto. Os lunáticos que atraíram minha irmã. Precisamos fazer alguma coisa.\
\
Vou ficar em Aldrassil e denunciar o culto a Tenaron Punho-da-Tempestade. Você vá até Dolanaar e conte tudo a Tallonkai Raizveloz.\
\
Entre os dois, saberão como acabar com isso."},
    [1660085]={c="<Você abre a mão, revelando o pingente de Elydna. Ao vê-lo, a expressão de luto de Thariel se suaviza um pouco.>\
\
Suponho que... na ausência de um corpo para lamentar, isto terá de bastar.\
\
<Ele pega o pingente com as mãos trêmulas e o pressiona contra o peito.>\
\
Elydna... que loucura levou você a se juntar àqueles degenerados?"},
    [1660100]={o="PROVISÓRIO"},
    [1660101]={o="PROVISÓRIO"},
    [1660102]={o="PROVISÓRIO"},
    [1660103]={o="PROVISÓRIO"},
    [1660104]={o="PROVISÓRIO"},
    [1660105]={o="PROVISÓRIO"},
    [1660106]={o="PROVISÓRIO"},
    [1660107]={o="PROVISÓRIO"},
    [1660108]={o="PROVISÓRIO"},
    [1660109]={o="PROVISÓRIO"},
    [1903546]={d="Você encontra Mestres de Voo nas principais cidades e centros de missões. A maioria das regiões possui um Mestre de Voo que permite viajar rapidamente de e para aquela área.\
\
Para localizar um Mestre de Voo próximo, use a lupa ao lado do minimapa e ative a opção de Mestre de Voo.\
\
Para desbloquear uma nova rota, fale com o Mestre de Voo. Sempre que chegar a uma região nova, procure o Mestre de Voo no centro de missões da sua facção.",o="Fale com o Mestre de Voo e voe até a Encruzilhada.",p="Fale com Doras, o Mestre de Voo no alto da torre ao lado do Banco de Orgrimmar, e depois voe até a Encruzilhada.",c="Os Mestres de Voo são uma parte importante da sua jornada e permitem viajar rapidamente por Azeroth.\
\
Você começa com algumas rotas básicas desbloqueadas. Conforme sobe de nível e explora regiões mais perigosas, fale com os Mestres de Voo encontrados nos centros de missões para liberar viagens de ida e volta àquelas localidades.\
\
Rotas ainda não descobertas aparecem com um ponto de exclamação verde. Fale com o Mestre de Voo para desbloqueá-las. Algumas rotas dependem de conexões intermediárias, e descobrir novos pontos costuma liberar caminhos mais rápidos.\
\
Sempre procure e desbloqueie novas rotas de voo ao explorar uma região pela primeira vez."},
    [1903547]={d="Você encontra Mestres de Voo nas principais cidades e centros de missões. A maioria das regiões possui um Mestre de Voo que permite viajar rapidamente de e para aquela área.\
\
Para localizar um Mestre de Voo próximo, use a lupa ao lado do minimapa e ative a opção de Mestre de Voo.\
\
Para desbloquear uma nova rota, fale com o Mestre de Voo. Sempre que chegar a uma região nova, procure o Mestre de Voo no centro de missões da sua facção.",o="Fale com o Mestre de Voo e voe até Cerro Oeste.",p="Vá até o canto leste do Distrito Comercial, suba a rampa e fale com Dungar Tragolongo. Depois voe até Cerro Oeste.",c="Os Mestres de Voo são uma parte importante da sua jornada e permitem viajar rapidamente por Azeroth.\
\
Você começa com algumas rotas básicas desbloqueadas. Conforme sobe de nível e explora regiões mais perigosas, fale com os Mestres de Voo encontrados nos centros de missões para liberar viagens de ida e volta àquelas localidades.\
\
Rotas ainda não descobertas aparecem com um ponto de exclamação verde. Fale com o Mestre de Voo para desbloqueá-las. Algumas rotas dependem de conexões intermediárias, e descobrir novos pontos costuma liberar caminhos mais rápidos.\
\
Sempre procure e desbloqueie novas rotas de voo ao explorar uma região pela primeira vez."},
    [4420430]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [4420431]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [4420432]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [4420433]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [4420434]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [4420435]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [4420436]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [4420437]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [4420438]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [4420439]={c="Saudações, recruta!\\n\\nComo reconhecimento por suas habilidades e dedicação, você receberá sua primeira montaria. Siga estes passos para aprender a invocar seu novo corcel:\\n\\n- Clique com o botão direito na montaria em sua mochila para aprendê-la.\\n- Abra o menu do personagem pressionando C.\\n- Acesse a aba Mascotes e depois a seção Montarias.\\n- Encontre sua nova montaria e arraste o ícone dela para a barra de ações.\\n\\nAssim você poderá montar rapidamente sempre que precisar viajar. As montarias ajudam você a se deslocar pelo mundo com mais velocidadee.\\n\\nVocê poderá voltar aqui ou procurar outro treinador de montaria para aumentar a velocidadee da sua montaria aprendendo os níveis seguintes de Cavalgar."},
    [8200501]={d="Volte ao Quadro de Chamados."},
    [8200503]={d="Volte ao Quadro de Chamados."},
}
A.QuestData = A.QuestData or {}
A.QuestTitle = A.QuestTitle or {}
for id, fix in pairs(fixes) do
    local row = A.QuestData[id]
    if row then
        for _, field in ipairs({"d", "o", "p", "c"}) do
            if fix[field] then row[field] = fix[field] end
        end
    end
    if fix.title then A.QuestTitle[id] = fix.title end
end
