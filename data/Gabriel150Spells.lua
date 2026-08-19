-- Conteudo seletivo extraido de GabrielBosco/AscensionPTBR 1.5.0.
-- Somente descricoes e tooltips: nomes de habilidades nao sao importados.
AscensionPTBR = AscensionPTBR or {}
local A = AscensionPTBR
A.DescPairs = A.DescPairs or {}
A.DescByID = A.DescByID or {}
A.TipPairs = A.TipPairs or {}
A.TipByID = A.TipByID or {}

local descPairs = {
    {"^Being webed into a cocon%.\
\
Disabled%.\
\
Suffering (.-) Physical damage every second%.%s*$","Você foi envolvido por uma teia e ficou preso em um casulo.\
\
Desativado.\
\
Recebe {{1}} de dano Físico a cada segundo."},
    {"^Webs the target into a cocon%.%s*$","Enreda o alvo em uma casulo."},
    {"^Wraps the target in a tight web, pinning it to the walls of Maexxna's Lair%. While wrapped the atrget is unable to act and slowly suffocates, taking Nature damage every second until released from its cocon%.%s*$","Envolve o alvo em uma teia, cravando-o às paredes do Ninho de Maexxna. Enquanto estiver envolto, o alvo não pode agir e se sufoca lentamente, recebendo dano de Natureza cada segundo até que é liberado de seu casulo."},
    {"^\
Your Preparation is transformed into Weapon Scroll%.\
When Weapon Scroll is used you gain max stacks of Prepared Shuriken%.\
\
Your finishing moves now have a 5%% chance per combo point spent to reduce the cooldown of your Weapon Scroll by 6 seconds%. Or a 20%% chance per combo point to give you a stack of Prepared Shuriken%.\
\
Hitting 5 stacks will give you a stack of Prepared Glaive, this increases the damage of your next Glaive Toss by (.-)%%%. Consuming this will also remove any stacks of Prepared Shuriken%.%s*$","\
Seu Preparação é transformado em Pergaminho de Arma.\
Quando o Pergaminho de Arma se use, obtém a máxima acúmulo de Shuriken Preparados.\
\
Agora seus movimentos finais têm 5% de chance por ponto de combo gastado para reduz a recarga de sua Pergaminho de Arma em 6 segundos. OU 20% de chance por ponto de combo para dar a você um acúmulo de Shuriken Preparados.\
\
Ao alcançar 5 acúmulos, obterá um acúmulo de Guja Preparado, isto aumenta o dano de seu próximo Tiro de Guja em {{1}}%. Consumi-o também excluirá qualquer acúmulo de Shuriken Preparados."},
    {"^Invoca y retira un Gran Oso Polar Bailarin, es muy veloz%.%s*$","Evoca e dispensa um Grande Urso Polar Dançarino, é muito veloz."},
    {"^Invoca y retira un Oso Espectral%. Es una montura extremadamente veloz%.%s*$","Evoca e dispensa um Urso Espectral. É uma montaria extremamente veloz."},
    {"^Invoca y retira un Oso Espectral Dorado%. Es una montura extremadamente veloz%.%s*$","Evoca e dispensa um Urso Espectral Ouro. É uma montaria extremamente rápida."},
    {"^Invoca y retira un Gran Oso de Facebook, es una montura veloz y exclusiva de nuestros seguidores en Facebook%.%s*$","Evoca e dispensa um Grande Urso de Facebook. É uma montaria veloz exclusiva para nossos seguidores em Facebook."},
    {"^Invoca y retira un Gran Oso de Twitter, es una montura veloz y exclusiva de nuestros seguidores en Twitter%.%s*$","Evoca e dispensa um Grande Urso de Twitter. É uma montaria veloz exclusiva para nossos seguidores em Twitter."},
    {"^Invoca y retira un Gran Oso Negro Bailarin, es muy veloz%.%s*$","Evoca e dispensa um Grande Urso Negro Dançarino. É muito veloz."},
    {"^Invoca y retira un Unicornio Acorazado Abisal, es una montura veloz%s*$","Evoca e dispensa um Unicórnio Blindado Asa, é uma montaria veloz."},
    {"^Invoca y retira el Corcel de cólera vil de los Señores abisales, es una montura muy veloz%.%s*$","Evoca e dispensa o Corcel de cólera vil dos Senhores abissais, é uma montaria muito veloz."},
    {"^Invoca y retira el Corcel de cólera maldito de los Señores abisales, es una montura muy veloz%.%s*$","Evoca e dispensa o Corcel de cólera maldito dos Senhores abissais, é uma montaria muito veloz."},
    {"^Invoca y retira el Corcel de cólera ardiente de los Señores abisales, es una montura muy veloz%.%s*$","Evoca e dispensa o Corcel de cólera ardente dos Senhores abissais, é uma montaria muito rápida."},
    {"^Invoca y retira un Oso de guerra sañoso, es una montura muy veloz%.%s*$","Evoca e dispensa um Urso de guerra resfolegante, é uma montaria muito rápida."},
    {"^Invoca y retira a una Can del averno sañoso volador%. Es una montura voladora extremadamente veloz%.%s*$","Evoca e dispensa um Cão do inferno resfolegante voador. É uma montaria voadora extremamente veloz."},
    {"^Invoca y retira una Gran vermis atiborrada de esencia abisal, tiene una velocidad sin parangón%.%s*$","Evoca e dispensa uma Grande vermis abarrotada dessência asa, tem uma velocidade incomparável."},
    {"^Invoca y retira un Oso de Guerra Abisal, es una montura veloz%.%s*$","Evoca e dispensa um Urso de Guerra Asa, é uma montaria veloz."},
    {"^Invoca y retira un Oso de Guerra Akafi, es una montura veloz%.%s*$","Evoca e dispensa um Urso de Guerra Akafi, é uma montaria veloz."},
    {"^Invoca y retira un Oso de Guerra Invernal, es una montura veloz%.%s*$","Evoca e dispensa um Urso de Guerra Invernal, é uma montaria veloz."},
    {"^Invoca y retira un Oso de Guerra Polar, es una montura extremadamente veloz%.%s*$","Evoca e dispensa um Urso de Guerra Polar, é uma montaria extremamente veloz."},
    {"^Invoca y retira un Oso de Guerra Pardo, es una montura veloz%.%s*$","Evoca e dispensa um Urso de Guerra Pardo, é uma montaria veloz."},
    {"^Miel is prepared to cut you all down where you stand%. Their aim is precise, but perhaps too precise%. Even a small shift in position could likely avoid the attack%.\
\
So MOVE!%s*$","Mel está preparado para se livrar de todos vocês onde se encontram Seu pontaria é precisa, mas talvez demais precisa. Inclusive um pequeno caminho na posição poderá estao ataque.\
\
Assim que MOVENSE!"},
    {"^The Forgotten Avatar is prepared to cut you down where you stand%. Their aim is precise, but perhaps too precise%. Even a small shift in position could likely avoid the attack%.\
\
So MOVE!%s*$","O Avatar Olvitado está preparado para remover você onde se encontra. Seu pontaria é precisa, mas talvez demais precisamente assim Inclusive um pequeno caminho de posição poderá estao ataque.\
\
Assim que MORRE!"},
    {"^Increases the effectiveness of |cFFFFFFFFUrsoc's Bellow|r by (.-)%%%.%s*$","Aumenta a eficácia de |cFFFFFFFFGrunhido de Ursoc|r em {{1}}%."},
    {"^Unleashes spell prepared by Magistrix Carinda for Viera Sunwhisper%.  Cannot possibly be pretty%.%s*$","Liberar o feitiço preparado por magistrix Carinda para Viera Seuspirosol. Não pode ser bonito."},
    {"^Take control of the Black Knight's Gryphon, forcing it to show you where the knight trained and prepared for the tournament%.%s*$","Assume o controle do Grifo do Cavaleiro Negro, obrigando-o a mostrar onde o cavaleiro treinou e se preparou para o torneio."},
    {"^Shadow's Edge pulses with Frost energy and is prepared for Sindragosa's demise%.%s*$","Fio das Sombras emite pulsos de Energia de Gelo está preparada para a morte de Sindragosa."},
    {"^Give a speech from one of Toby's prepared speeches%.%s*$","Dá um dos discursos preparados por Toby."},
    {"^Begins the attack upon the warp%-gate%.  Fires a naturalized fel cannonball at the warp%-gate, damaging it%.  Seven shots will destroy a warp%-gate%.%s*$","Inicia o ataque ao portal dimensional. Dispara contra ele uma bala de canhão vil neutralizada, causando dano. Sete disparos destroem o portal dimensional."},
    {"^Each stack increases your parry and dodge chance equal to 1%% of your Stamina, and increases your critical strike chance by (.-)%%%.\
\
Healing yourself with |cffffffffHoly Abdication|r or |cffffffffBenediction|r now consumes the stacks, dealing (.-) Physical Damage to you for each stack consumed, but removing all delayed damage%.%s*$","Cada acúmulo aumenta a chance de aparar e esquiva em 1% do seu Vigor e a chance de acerto crítico em {{1}}%.\
\
Curar-se com |cffffffffAbdicação Sagrada|r ou |cffffffffBênção|r consome os acúmulos, causando {{2}} de dano Físico a você por acúmulo consumido, mas removendo todo o dano adiado."},
    {"^Holy Shock guaranteed to critically strike and increases its damage and healing done by (.-)%%%. And grants of |cFFFFFFFFLight of Ascension|r%.%s*$","Choque Sagrado causa um acerto crítico garantido e aumenta o dano e a cura realizados em {{1}}%. Também concede |cFFFFFFFFLuz da Ascensão|r."},
    {"^Increases the damage of |cffffffffFist of the Ancients|r while you have |cffffffffWeapon Engraving: Fire|r active by (.-)%%%.%s*$","Aumenta em {{1}}% o dano de |cffffffffPunho dos Anciãos|r enquanto |cffffffffGravura de Arma: Fogo|r estiver ativa."},
    {"^Increases your Holy Spell Damage by (.-)%% of your Agility, and your Melee Hit Rating and Expertise Rating by (.-)%% of your Intellect%.\
\
Monks can build Agility to empower their Physical and Weapon attacks, or Intellect and Spell Power to empower their Holy Damage effects%.\
\
As masters of different styles of combat, monks gain special benefits when using specific weapons, and have a different primary attack based on whether they choose to fight Unarmed, with Dual Weapons, with a Staff, or with a Long Blade %(Two%-Handed Sword or Polearm%)%.%s*$","Aumenta seu dano mágico Sagrado em {{1}}% de sua Agilidade, e seu índice de acerto corpo a corpo e seu índice de perícia em {{2}}% de seu Intelecto.\
\
Os monges podem aumentar sua Agilidade para fortalecer seus ataques Físicos e com Armas, ou seu Intelecto e Poder Mágico para fortalecer seus efeitos de Dano Sagrado.\
\
Como mestres de diferentes estilos de combate, os monges obtêm benefício especiais ao usar armas específicas, e têm um ataque principal diferente dependendo de lutarem desarmados, com duas armas, com cajado ou com uma lâmina longa (Espada de duas mãos ou Lança)."},
    {"^Recently been granted a scroll of unlearning%.%s*$","Você recebeu recentemente um Pergaminho do Esquecimento."},
    {"^Recently been granted an ability purge%.%s*$","Você recebeu recentemente uma Purificação de Habilidades."},
    {"^Reduces the cooldown of |cffffffffRam|r by (.-) sec and increases its damage by (.-)%% and critical damage by (.-)%%%.%s*$","Reduz em {{1}} s o tempo de recarga de |cffffffffAríete|r e aumenta seu dano em {{2}}% e seu dano crítico em {{3}}%."},
    {"^Reduces the cooldown of |cffffffffWarplink|r and |cffffffffWarp Shift|r by (.-)%%%.%s*$","Reduz em {{1}}% o tempo de recarga de |cffffffffElo Dimensional|r e |cffffffffDeslocamento Distorcido|r."},
    {"^Your Killing Spree now also damages up to 3 additional nearby targets and weakens the defenses of all targets hit, increasing the damage you deal to them by 3%% %(1%% against players%) for 15 seconds, stacks up to 5 times%. \
\
In addition, killing an enemy that yields experience or honor reduces the cooldown of Killing Spree by 10 seconds%.%s*$","Agora, |cffffffffMatança|r também causa dano até 3 alvos próximos adicionais e enfraquece a defesa de todos alvos atingidos, aumentando em 3% (1% contra jogadores) o dano que você causa a eles por 15 s. Acumula até 5 vezes.\
\
Além disso, matar um inimigo que conceda experiência ou honra reduz em 10 s o tempo de recarga de |cffffffffMatança|r."},
    {"^Increases spell, ranged and melee haste by (.-)%%%.\
\
Reduces the pushback suffered from damaging attacks by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: If hit by an Interrupt when not casting, you become immune to the next Crowd Control, Knockback, Silence, or Interrupt for (.-) and your next Druid Nature spell within (.-) becomes an instant cast%.|r%s*$","aumenta em {{1}}% a celeridade de feitiço, de ataque à distância e corpo a corpo.\
\
reduz em {{2}}% o atraso de lançamento causado por ataques que provocam dano.\
\
|cFFAAAAAABônus de Ápice: Se você sofrer uma Interrupção enquanto não estiver lançando, ficará imune ao próximo Controle Coletivo, Repulsão, Silêncio ou Interrupção durante {{3}}, e seu próximo feitiço de Natureza de Druida lançado em até {{4}} será instantâneo.|r"},
    {"^Increases spell, ranged and melee haste by (.-)%%%.\
\
Reduces the pushback suffered from damaging attacks by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: If hit by an Interrupt when not casting, you become immune to the next Crowd Control, Knockback, Silence, or Interrupt for (.-) and your next Druid Nature spell within (.-) becomes an instant cast%. \
\
This effect can only occur once every (.-)%.|r%s*$","aumenta em {{1}}% a celeridade de feitiço, de ataque à distância e corpo a corpo.\
\
reduz em {{2}}% o atraso de lançamento causado por ataques que provocam dano.\
\
|cFFAAAAAABônus de Ápice: Se você sofrer uma Interrupção enquanto não estiver lançando, ficará imune ao próximo Controle Coletivo, Repulsão, Silêncio ou Interrupção durante {{3}}, e seu próximo feitiço de Natureza de Druida lançado em até {{4}} será instantâneo.\
\
Este efeito só pode ocorrer uma vez a cada {{5}}.|r"},
    {"^Increases spell, ranged and melee haste by (.-)%%%.\
\
Reduces the pushback suffered from damaging attacks by (.-)%%%.\
\
Capstone Bonus: If hit by an Interrupt when not casting, you become immune to the next Crowd Control, Knockback, Silence, or Interrupt for (.-) and your next Druid Nature spell within (.-) becomes an instant cast%.%s*$","aumenta em {{1}}% a celeridade de feitiço, de ataque à distância e corpo a corpo.\
\
reduz em {{2}}% o atraso de lançamento causado por ataques que provocam dano.\
\
Bônus de Ápice: Se você sofrer uma Interrupção enquanto não estiver lançando, ficará imune ao próximo Controle Coletivo, Repulsão, Silêncio ou Interrupção durante {{3}}, e seu próximo feitiço de Natureza de Druida lançado em até {{4}} será instantâneo."},
    {"^Increases spell, ranged and melee haste by (.-)%%%.\
\
Reduces the pushback suffered from damaging attacks by (.-)%%%.\
\
Capstone Bonus: If hit by an Interrupt when not casting, you become immune to the next Crowd Control, Knockback, Silence, or Interrupt for (.-) and your next Druid Nature spell within (.-) becomes an instant cast%. \
\
This effect can only occur once every (.-)%.%s*$","aumenta em {{1}}% a celeridade de feitiço, de ataque à distância e corpo a corpo.\
\
reduz em {{2}}% o atraso de lançamento causado por ataques que provocam dano.\
\
Bônus de Ápice: Se você sofrer uma Interrupção enquanto não estiver lançando, ficará imune ao próximo Controle Coletivo, Repulsão, Silêncio ou Interrupção durante {{3}}, e seu próximo feitiço de Natureza de Druida lançado em até {{4}} será instantâneo.\
\
Este efeito só pode ocorrer uma vez a cada {{5}}."},
    {"^Increases your chance to block by (.-)%%, and your block value by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: Increases your block value by (.-)%% after you block an attack%. Lasts (.-) or (.-) blocks%.|r%s*$","aumenta em {{1}}% sua chance de bloqueio e em {{2}}% seu valor de bloqueio.\
\
|cFFAAAAAABônus de Ápice: Após bloquear um ataque, aumenta seu valor de bloqueio em {{3}}%. Dura {{4}} ou {{5}} bloqueios.|r"},
    {"^Increases your chance to block by (.-)%%, and your block value by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: Increases your block value by (.-)%% after you block an attack%. Lasts (.-) or (.-) blocks%. This effect cannot occur more than once every second%.|r%s*$","aumenta em {{1}}% sua chance de bloqueio e em {{2}}% seu valor de bloqueio.\
\
|cFFAAAAAABônus de Ápice: Após bloquear um ataque, aumenta seu valor de bloqueio em {{3}}%. Dura {{4}} ou {{5}} bloqueios. Este efeito não pode ocorrer mais de uma vez por segundo.|r"},
    {"^Berserker Stance now also increases your damage against targets below 35%% health by (.-)%%%. This effect is doubled while Enrage is active%.\
\
|cFFAAAAAACapstone Bonus: Raging Blow increases the duration of your Recklessness by 1 second%.|r%s*$","Postura de Berserker agora também aumenta em {{1}}% seu dano contra alvos com menos de 35% de vida. Este efeito é duplicado enquanto Enfurecer estiver ativo.\
\
|cFFAAAAAABônus de Ápice: golpe Furioso aumenta em 1 segundo a duração de Temeridade.|r"},
    {"^Increases your total Spirit by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: Your spell damage is increased by 15%% of your Spirit%.\
|r%s*$","aumenta em {{1}}% seu Espírito total.\
\
|cFFAAAAAABônus de Ápice: Seu dano mágico é aumentado em 15% do seu Espírito.\
|r"},
    {"^Instantly Whirlwind up to (.-) nearby targets and for the next (.-) you will perform a whirlwind attack every (.-) sec%.  While under the effects of Bladestorm, you can move but cannot perform any other abilities but you do not feel pity or remorse or fear and you cannot be stopped unless disarmed or killed%.%s*$","Executa instantaneamente Redemoinho contraté {{1}} alvos próximos e, durante os próximos {{2}}, realiza um ataque de Redemoinho a cada {{3}} s. Enquanto estiver sob o efeito de Tornado de Aço, você pode se mover, mas não pode usar outras habilidades. Você não sente piedade, remorso nem medo e só pode ser impedido se for desarmado ou morto."},
    {"^Increases your energy regeneration rate by (.-)%%%.\
\
Cat Form finishing moves that fail to land are refunded (.-)%% of the energy cost%.\
\
|cFFAAAAAACapstone Bonus: Your Cat Form finishing moves reduce the cooldown of Berserk by (.-) sec%. and Tiger's Fury by (.-) sec%.|r%s*$","aumenta em {{1}}% sua taxa de regeneração de Energia.\
\
Golpes de finalização em Forma de Felino que não acertarem devolvem {{2}}% do custo de Energia.\
\
|cFFAAAAAABônus de Ápice: Seus golpes de finalização em Forma de Felino reduzem em {{3}} s a recarga de Berserk e em {{4}} s a recarga de Fúria do Tigre.|r"},
    {"^Increases the critical strike damage bonus of your Lava Burst, Flame Shock, Sundering and Lava Lash by an additional (.-)%%%.\
\
Casting Flame Shock or Lava Burst your spell and melee haste is increased by (.-)%% for (.-)%.\
\
If your Flame Shock is dispelled your haste is increased by (.-)%% for (.-)%.%s*$","aumenta em mais {{1}}% o bônus de dano crítico de Estouro de Lava, Choque Flamejante, Ruptura e Açoite de Lava.\
\
Lançar Choque Flamejante ou Estouro de Lava aumenta em {{2}}% sua celeridade de feitiço e corpo a corpo durante {{3}}.\
\
Se seu Choque Flamejante for dissipado, sua celeridade aumentará em {{4}}% durante {{5}}."},
    {"^Transforms the enemy into a frog%. While hexed, the target cannot attack or cast spells%. Damage caused may interrupt the effect%. Lasts (.-)%. Only one target can be hexed at a time%.  Only works on Humanoids and Beasts%.\
\
|cffFFFFFFThis spell cannot miss%.|r%s*$","Transforma o inimigo em rã. Enquanto estiver enfeitiçado, o alvo não pode atacar nem lançar feitiços. O dano pode interromper o efeito. Dura {{1}}. Apenas um alvo pode ser enfeitiçado por vez. Funciona somente contra Humanoides e Feras."},
    {"^Your melee critical strikes reduce the cooldown of |cffffffffRift|r and |cffffffffGaze of C'Thun|r by (.-) sec%.%s*$","Seus acertos críticos corpo a corpo reduzem em {{1}} s a recarga de |cffffffffFissura|r e |cffffffffOlhar de C'Thun|r."},
    {"^While |cffffffffRighteous Tempest|r is active you gain 20%% increased movement speed%. \
\
Movement speed gained in this way stacks with |cffffffffCourage|r%.%s*$","Enquanto |cffffffffTempestade Justiceira|r estiver ativa, sua velocidade de movimento aumentará em 20%.\
\
a velocidade de movimento recebida dessa forma acumula com |cffffffffCoragem|r."},
    {"^Your next 3 |cFFFFFFFFTitanstrikes|r are usable regardless of your target's health percentage and deal (.-)%% increased damage%. Lasts (.-)%.\
\
Applies |cffffffffSacred Restraint|r for (.-)%.%s*$","Seus próximos 3 |cFFFFFFFFGolpes Titânicos|r poderão ser usados independentemente do percentual de vida do alvo e causarão {{1}}% a mais de dano. Dura {{2}}.\
\
Aplica |cffffffffRestrição Sagrada|r durante {{3}}."},
    {"^You may now tame beasts in Azeroth to aid you as a companion%.%s*$","Agora você pode domar feras de Azeroth para acompanhá-lo e ajudá-lo em combate."},
    {"^Raise a fallen |cffffffffGargoyle|r to aid you in combat, occupying 3 |cffffffffLife Force|r%. \
\
|cff90ee90Command|r: Shoots necrotic bile at an enemy, dealing (.-) Plague damage, dealing 50%% increased damage for each of your diseases on the target%.%s*$","Anima uma |cffffffffGárgula|r caída para ajudar você em combate, ocupando 3 pontos de |cffffffffForça Vital|r.\
\
|cff90ee90Comando|r: dispara bile necrótica contra um inimigo, causando {{1}} de dano de Peste e 50% a mais de dano para cada uma de suas doenças no alvo."},
    {"^Raise a |cffffffffSkeletal Mage|r to aid you in combat, occupying 1 |cffffffffLife Force|r%.\
\
|cff90ee90Command|r: Unleashes ice at your target and enemies within (.-) yds, dealing (.-) Frost damage%.%s*$","Anima um |cffffffffMago Esquelético|r para ajudar você em combate, ocupando 1 ponto de |cffffffffForça Vital|r.\
\
|cff90ee90Comando|r: lança gelo contra o alvo e os inimigos em um raio de {{1}} m, causando {{2}} de dano de Gelo."},
    {"^Raise a |cffffffffSkeletal Mage|r to aid you in combat, occupying 2 |cffffffffLife Force|r%.\
\
|cff90ee90Command|r: Unleashes ice at your target and enemies within (.-) yds, dealing (.-) Frost damage%.%s*$","Anima um |cffffffffMago Esquelético|r para ajudar você em combate, ocupando 2 pontos de |cffffffffForça Vital|r.\
\
|cff90ee90Comando|r: lança gelo contra o alvo e os inimigos em um raio de {{1}} m, causando {{2}} de dano de Gelo."},
    {"^Raise a |cffffffffSkeletal Archer|r to aid you in combat, occupying 1 |cffffffffLife Force|r%.\
\
|cffffffffSkeletal Archers|r attack slowly from afar and their attacks have a (.-)%% chance to reduce enemies armor by (.-)%% for (.-)%.%s*$","Anima um |cffffffffArqueiro Esquelético|r para ajudar você em combate, ocupando 1 ponto de |cffffffffForça Vital|r.\
\
|cffffffffArqueiros Esqueléticos|r atacam lentamente à distância, e seus ataques têm {{1}}% de chance de reduzir em {{2}}% a Armadura dos inimigos durante {{3}}."},
    {"^Raise an |cffffffffAbomination|r to aid you in combat, occupying 3 |cffffffffLife Force|r%.\
\
It is surrounded by a disease cloud, dealing (.-) Nature damage to enemies when they deal damage and reducing their attack speed by (.-)%% for (.-)%.\
\
|cff90ee90Command|r: Instantly unleashes an empowered disease cloud around it%.%s*$","Anima uma |cffffffffAbominação|r para ajudar você em combate, ocupando 3 pontos de |cffffffffForça Vital|r.\
\
Ela é envolvida por uma nuvem de doenças que causa {{1}} de dano de Natureza aos inimigos quando eles causam dano e reduz em {{2}}% a velocidade de ataque deles durante {{3}}.\
\
|cff90ee90Comando|r: libera instantaneamente uma nuvem de doenças fortalecida ao redor dela."},
    {"^Meditate for (.-), restoring (.-)%% of your maximum health every (.-) sec and reducing damage taken by (.-)%%%.\
\
Each second you will also remove 1 disease effect from yourself%. \
\
Applies |cffffffffSacred Restraint|r for (.-)%.%s*$","Medita durante {{1}}, restaurando {{2}}% da sua vida máxima a cada {{3}} s e reduz em {{4}}% o dano recebido.\
\
a cada segundo, também remove de você 1 efeito de doença.\
\
Aplica |cffffffffRestrição Sagrada|r durante {{5}}."},
    {"^Transform enemies at target location into a frog, making them unable to attack or cast spells, and slowing their movement speed by (.-)%% for (.-) %(8 sec vs players%)%. While transformed into a frog the enemy is considered a Beast%.\
\
Damage caused may interrupt the effect%.%s*$","Transforma os inimigos no local selecionado em rãs, impedindo-os de atacar ou lançar feitiços e reduzindo em {{1}}% a velocidade de movimento deles durante {{2}} (8 s contra jogadores). Enquanto estiver transformado em rã, o inimigo será considerado uma Fera.\
\
O dano causado pode interromper o efeito."},
    {"^Smash an enemy for (.-)%% Weapon Damage plus (.-) and heal yourself equal to (.-)%% of the damage dealt%.\
\
Shares a cooldown with other |cffffffffGavels|r%.%s*$","Esmaga um inimigo, causando {{1}}% do dano da arma mais {{2}}, e cura você em um valor equivalente a {{3}}% do dano causado.\
\
Compartilha a recarga com outros |cffffffffMalhetes|r."},
    {"^Channel your life force into an ally player for (.-), increasing the effectiveness of active periodic healing spells by (.-)%%%.\
\
Every (.-) sec, you consume (.-) sec of |cffffffffShadra's Vigil|r from the target to heal them for  (.-) and restore (.-)%% maximum mana%.%s*$","Canaliza sua força vital para um jogador aliado durante {{1}}, aumentando em {{2}}% a eficácia dos efeitos ativos de cura periódica.\
\
A cada {{3}} s, consome {{4}} s de |cffffffffVigília de Shadra|r do alvo para curá-lo em {{5}} e restaurar {{6}}% da mana máxima."},
    {"^Channel your life force into an ally player for (.-), increasing the effectiveness of active periodic healing spells by (.-)%%%.\
\
Every (.-) sec, you consume (.-) sec of |cffffffffShadra's Vigil|r from the target to heal them for  (.-)%.%s*$","Canaliza sua força vital para um jogador aliado durante {{1}}, aumentando em {{2}}% a eficácia dos efeitos ativos de cura periódica.\
\
A cada {{3}} s, consome {{4}} s de |cffffffffVigília de Shadra|r do alvo para curá-lo em {{5}}."},
    {"^Effectively healing with |cFFFFFFFFRadiant Cascade|r has a (.-)%% chance to increase the healing of your next |cFFFFFFFFIllumination|r by (.-)%%%. \
\
Effectively healing with |cFFFFFFFFIllumination|r has a (.-)%% chance to increase the healing of your next |cFFFFFFFFRadiant Cascade|r by (.-)%%%.%s*$","a cura efetiva de |cFFFFFFFFCascata Radiante|r tem {{1}}% de chance de aumentar em {{2}}% a cura da sua próxima |cFFFFFFFFIluminação|r.\
\
a cura efetiva de |cFFFFFFFFIluminação|r tem {{3}}% de chance de aumentar em {{4}}% a cura da sua próxima |cFFFFFFFFCascata Radiante|r."},
    {"^Increases the damage dealt by your |cFFFFFFFFSearing|r and |cFFFFFFFFPoison Quivers|r by (.-)%%%.\
\
In addition, dealing damage with |cFFFFFFFFSearing|r or |cffffffffPoison Quiver|r now grants a stack of |cFFFFFFFFElven Enchantments|r%.%s*$","aumenta em {{1}}% o dano causado por |cFFFFFFFFCauterização|r e |cFFFFFFFFAljavas Venenosas|r.\
\
Além disso, causar dano com |cFFFFFFFFCauterização|r ou |cffffffffAljava Venenoso|r agora concede uma aplicação de |cFFFFFFFFEncantamentos elfos|r."},
    {"^After using a |cffffffffPalm Sigil|r, the duration of your crowd control effects is increased by (.-)%%%.\
\
Reduces the cast time of all |cffffffffPalm Sigils|r by (.-) sec and increases the duration of your |cffffffffPalm Sigil|r buffs by (.-)%%%.%s*$","Após usar um |cffffffffSelo da Palma|r, a duração dos seus efeitos de controle coletivo aumenta em {{1}}%.\
\
reduz em {{2}} s o tempo de lançamento de todos |cffffffffSelos da Palma|r e aumenta em {{3}}% a duração dos benefício dos seus |cffffffffSelos da Palma|r."},
    {"^Your |cffffffffPotion Toss|r and |cffffffffSplash Potion|r cooldown is reset, and the next use within (.-) now applies |cffffffffFish Bones|r to affected allies%.\
\
Instantly swaps your |cffffffffIngredients|r to |cffffffffFish Oil|r and |cffffffffFrog Bones|r%.%s*$","a recarga de |cffffffffArremesso de Poção|r e |cffffffffPoção de Salpico|r é reiniciada, e o próximo uso realizado em até {{1}} aplica |cffffffffOssos de Peixe|r aos aliados afetados.\
\
Substitui instantaneamente seus |cffffffffIngredientes|r por |cffffffffÓleo de Peixe|r e |cffffffffOssos de Rã|r."},
    {"^Your |cffffffffPotion Toss|r and |cffffffffSplash Potion|r cooldown is reset, and the next use within (.-) now applies |cffffffffFrog Shrooms|r to affected allies%.\
\
Instantly swaps your |cffffffffIngredients|r to |cffffffffJungle Shrooms|r and |cffffffffFrog Bones|r%.%s*$","a recarga de |cffffffffArremesso de Poção|r e |cffffffffPoção de Salpico|r é reiniciada, e o próximo uso realizado em até {{1}} aplica |cffffffffCogumelos de Sapo|r aos aliados afetados.\
\
Substitui instantaneamente seus |cffffffffIngredientes|r por |cffffffffCogumelos da Selva|r e |cffffffffOssos de Rã|r."},
    {"^Reduces the cooldown of your |cFFFFFFFFShield of Ages|r by (.-) sec and increases its effectiveness by (.-)%%%.%s*$","reduz em {{1}} s a recarga de |cFFFFFFFFEscudo das Eras|r e aumenta em {{2}}% sua eficácia."},
    {"^Physical and Nature damage increased by (.-)%%, ranged attack power reduced by (.-)%%%. \
\
Critical strikes with |cffffffffWild Strike|r and |cffffffffFlank|r have a (.-)%% chance to apply |cffffffffRoughed Up|r, reducing Armor, and |cffffffffCounterstruck|r, reducing attack power%.%s*$","Aumenta em {{1}}% o dano Físico e de Natureza, mas reduz em {{2}}% o poder de ataque à distância.\
\
Acertos críticos com |cffffffffGolpe Selvagem|r e |cffffffffFlanqueamento|r têm {{3}}% de chance de aplicar |cffffffffMachucado|r, reduzindo a Armadura, e |cffffffffContra-ataqueado|r, reduzindo o poder de ataque."},
    {"^Ascend into a celestial form for (.-), increasing your critical strike chance by (.-)%%%.\
\
While active, critical strikes now reduce the remaining cooldown of all healing spells by 10%% and apply a |cff66ccffScattered Star|r to your target and up to 4 enemies within 5 yds of them%.%s*$","Ascende a uma Forma Celestial durante {{1}}, aumentando em {{2}}% sua chance de acerto crítico.\
\
Enquanto estiver ativa, seus acertos críticos reduzem em 10% a recarga restante de todos os feitiços de cura e aplicam uma |cff66ccffEstrela Dispersa|r ao alvo e até 4 inimigos em um raio de 5 m dele."},
    {"^Creates a clone of an ally for (.-) which will mimic their spells and abilities %(except this spell%) on a 2 sec delay%.\
\
After being targeted by this spell, |cffffffffPast Self|r cannot be cast on the ally again for (.-)%.\
\
If you cast this spell on yourself, you cannot cast it again at all for another (.-)%.%s*$","Cria durante {{1}} um clone de um aliado, que imita os feitiços e habilidades dele (exceto este feitiço) com 2 s de atraso.\
\
Depois de ser alvo deste feitiço, o aliado não poderá receber |cffffffffEu do passado|r novamente durante {{2}}.\
\
Se você lançar este feitiço em si mesmo, não poderá lançá-lo novamente durante {{3}}."},
    {"^Hasten time for an ally, increasing movement speed and haste by (.-)%%%. Lasts (.-)%.\
\
While active the cooldowns of |cffffffffDimensional Divergence|r, |cffffffffBacktrack|r, and |cffffffffTimeguard|r are reduced by (.-)%% every (.-) sec%.%s*$","Acelera o tempo de um aliado, aumenta em {{1}}% a velocidade de movimento e a celeridade dele. Dura {{2}}.\
\
Enquanto estiver ativo, a recarga de |cffffffffDivergência dimensional|r, |cffffffffRetroceder|r e |cffffffffGuardião do Tempo|r é reduzida em {{3}}% a cada {{4}} s."},
    {"^Brew |cffffffffFish Oil|r into your |cffffffffCauldron|r%.\
\
|cffffffffCauldron|r: Increases the movement speed and swim speed of allies within (.-) yds by (.-)%%%.\
\
|cffffffffPotion|r: Increases the target ally's movement speed by (.-)%% and dodge chance by (.-)%% for (.-)%.%s*$","Prepara |cffffffffÓleo de Peixe|r em seu |cffffffffCaldeirão|r.\
\
|cffffffffCaldeirão|r: aumenta em {{2}}% a velocidade de movimento e de natação dos aliados em um raio de {{1}} m.\
\
|cffffffffPoção|r: aumenta em {{3}}% a velocidade de movimento e em {{4}}% a chance de esquiva do aliado durante {{5}}."},
    {"^Brew |cffffffffFrog Bones|r into your |cffffffffCauldron|r%.\
\
|cffffffffCauldron|r: Grants allies within (.-) yds (.-)%% reduced damage taken%.\
\
|cffffffffPotion|r: Grants target ally an absorption shield, absorbing (.-) damage, scaling with Spirit%.%s*$","Prepara |cffffffffOssos de Rã|r em seu |cffffffffCaldeirão|r.\
\
|cffffffffCaldeirão|r: reduz em {{2}}% o dano recebido pelos aliados em um raio de {{1}} m.\
\
|cffffffffPoção|r: Concede ao aliado selecionado um escudo que absorve {{3}} de dano e escala com O Espírito."},
    {"^Devote to Bethekk, granting (.-)%% increased movement speed%.\
\
Abilities that |cffffffffInvoke Bethekk|r have (.-)%% reduced cooldown and (.-)%% increased effectiveness and grant |cffffffffAppeasement of Bethekk|r%.\
\
Shares a 5 sec cooldown with other |cffffffffDevotions|r%.%s*$","Consagra-se a Bethekk, aumenta em {{1}}% sua velocidade de movimento.\
\
Habilidades que |cffffffffInvocam Bethekk|r têm a recarga reduzida em {{2}}%, à eficácia aumentada em {{3}}% e concedem |cffffffffApaziguamento de Bethekk|r.\
\
Compartilha uma recarga de 5 s com outras |cffffffffDevoções|r."},
    {"^Devote to Sseratus, increasing healing by (.-)%%%.\
\
Abilities that |cffffffffInvoke Sseratus|r have (.-)%% reduced cooldown and (.-)%% increased effectiveness and grant |cffffffffAppeasement of Sseratus|r%.\
\
Shares a 5 sec cooldown with other |cffffffffDevotions|r%.%s*$","Consagra-se a Sseratus, aumenta em {{1}}% a cura realizada.\
\
Habilidades que |cffffffffInvocam Sseratus|r têm a recarga reduzida em {{2}}%, à eficácia aumentada em {{3}}% e concedem |cffffffffConciliação com Sseratus|r.\
\
Compartilha uma recarga de 5 s com outras |cffffffffDevoções|r."},
    {"^Devote to Sseratus, increasing healing by (.-)%%%.\
\
Abilities that |cffffffffInvoke Sseratus|r have (.-)%% reduced cooldown and (.-)%% increased effectiveness and grant |cffffffffAppeasement of Sseratus|r%.\
\
Shares a 5 sec cooldown with other |cffffffffDevotions|r%.\
This does not affect |cFFFFFFFFHealing Wards|r%.%s*$","Consagra-se a Sseratus, aumenta em {{1}}% a cura realizada.\
\
Habilidades que |cffffffffInvocam Sseratus|r têm a recarga reduzida em {{2}}%, à eficácia aumentada em {{3}}% e concedem |cffffffffConciliação com Sseratus|r.\
\
Compartilha uma recarga de 5 s com outras |cffffffffDevoções|r.\
Isso não afeta |cFFFFFFFFTotens de cura|r."},
    {"^Animate a |cffffffffCrypt Fiend|r to aid you in combat for (.-)%.\
\
|cff90ee90Command|r: Deals (.-) Shadow damage to an enemy, slowing movement speed by (.-)%% and reducing their armor by (.-)%% for (.-)%.%s*$","Anima um |cffffffffDemônio da Cripta|r para ajudar você em combate durante {{1}}.\
\
|cff90ee90Comando|r: Causa {{2}} de dano de Sombra um inimigo, reduzindo em {{3}}% a velocidade de movimento e em {{4}}% a armadura dele durante {{5}}."},
    {"^|cffffffffRequires Blade Stance|r\
Quickly strike your target every (.-) sec for (.-), Slowing their movement speed by (.-)%%%. Each strike deals (.-)%% Weapon Damage plus (.-)%.\
\
|cffffffffWickedness|r: Each strike consumes a stack of |cffffffffSensed Evil|r from the target dealing bonus Fire Damage%.\
\
|cffffffffPurity|r: While channeling, you take (.-)%% reduced damage%.%s*$","|cffffffffRequer Postura da Lâmina|r\
Golpeia rapidamente o alvo a cada {{1}} s durante {{2}}, reduzindo em {{3}}% a velocidade de movimento dele. Cada golpe causa {{4}}% do dano da arma mais {{5}}.\
\
|cffffffffMalícia|r: Cada golpe consome uma aplicação de |cffffffffSensação de mal|r do alvo para causar dano de Fogo adicional.\
\
|cffffffffPureza|r: Enquanto estiver canalizando, você recebe {{6}}% a menos de dano."},
    {"^|cffff3232Requires Blade Stance|r\
Quickly strike your target every (.-) sec for (.-), Slowing their movement speed by (.-)%%%. Each strike deals (.-)%% Weapon Damage plus (.-)%.\
\
|cffffffffWickedness|r: Each strike consumes a stack of |cffffffffSensed Evil|r from the target dealing bonus Fire Damage%.\
\
|cffffffffPurity|r: While channeling, you take (.-)%% reduced damage%.%s*$","|cffff3232Requer Postura da Lâmina|r\
Golpeia rapidamente o alvo a cada {{1}} s durante {{2}}, reduzindo em {{3}}% a velocidade de movimento dele. Cada golpe causa {{4}}% do dano da arma mais {{5}}.\
\
|cffffffffMalícia|r: Cada golpe consome uma aplicação de |cffffffffSensação de mal|r do alvo para causar dano de Fogo adicional.\
\
|cffffffffPureza|r: Enquanto estiver canalizando, você recebe {{6}}% a menos de dano."},
    {"^|cff32cd32Consumes 2 Felfury|r \
Blast an enemy for (.-) Shadowflame Damage and generate (.-) Energy%. \
\
|cff32cd32Inner Demon|r: This spell casts an additional time free of cost%.%s*$","|cff32cd32Consome 2 de Fúria Vil|r\
Explode um inimigo, causando {{1}} de dano de Chama Sombria e gerando {{2}} de Energia.\
\
|cff32cd32Demônio Interior|r: Este feitiço é lançado uma vez adicional sem custo."},
    {"^Your melee auto attacks have a (.-)%% chance to deal additional (.-) Shadow damage to their target, scaling with how many |cffffffffShadow Marks|r are applied%.%s*$","Seus ataques automáticos corpo a corpo têm {{1}}% de chance de causar {{2}} de dano de Sombra adicional ao alvo. O dano aumenta de acordo com a quantidade de |cffffffffMarcas Sombrias|r aplicadas."},
    {"^Assume a powerful |cFFFFFFFFPresence|r, giving damage dealt a (.-)%% chance to curse the ground for (.-), dealing (.-) Shadow damage every (.-) sec to enemies within%.%s*$","Assume uma poderosa |cFFFFFFFFPresença|r, concedendo ao dano causado {{1}}% de chance de amaldiçoar o chão durante {{2}} e causar {{3}} de dano de Sombra a cada {{4}} s os inimigos na zona."},
    {"^Assume a powerful |cFFFFFFFFPresence|r, giving damage dealt a (.-)%% chance to curse the ground for (.-), dealing (.-) Shadow damage every (.-) sec to enemies within%.\
\
You may only have 1 |cFFFFFFFFPresence|r active at a time%.%s*$","Assume uma poderosa |cFFFFFFFFPresença|r, concedendo ao dano causado {{1}}% de chance de amaldiçoar o chão durante {{2}} e causar {{3}} de dano de Sombra a cada {{4}} s os inimigos na zona.\
\
Você só pode manter 1 |cFFFFFFFFPresença|r ativa por vez."},
    {"^Summons a |cffffffffMindbender|r to aid you in battle until dismissed%.\
\
This minion excels at supporting allies and can periodically heal allies within (.-) yds%.%s*$","Invoca um |cffffffffDeformador mental|r para ajudar você em combate até ser dispensado.\
\
Este lacaio é especializado em auxiliar aliados e pode curar periodicamente aliados em um raio de {{1}} m."},
    {"^Increases parry chance by (.-)%%%.\
\
Grants dodges, parries and melee damage dealt a chance to apply |cffff8100Counterstruck|r%.%s*$","aumenta em {{1}}% sua chance de aparar.\
\
Esquivas, aparos e dano corpo a corpo causado têm chance de aplicar |cffff8100Contra-ataqueado|r."},
    {"^Snatch an enemy's melee weapons, disarming them for (.-)%.\
\
If you are disarmed, you also return your weapon to yourself%.%s*$","Arranca as armas corpo a corpo de um inimigo, desarmando-o durante {{1}}.\
\
Se você estiver desarmado, também recupera sua própria arma."},
    {"^Increases the damage and healing of |cFFFFFFFFSerpent's Coil|r by (.-)%%%.\
\
Critical heals with |cFFFFFFFFAlkahest|r now reduce the cooldown of |cFFFFFFFFSerpent's Coil|r by (.-) sec%.%s*$","aumenta em {{1}}% o dano e a cura de |cFFFFFFFFEspiral da Serpente|r.\
\
Curas críticas com |cFFFFFFFFAlcaesto|r agora reduzem em {{2}} s a recarga de |cFFFFFFFFEspiral da Serpente|r."},
    {"^You link yourself with an ally, reducing all damage they take by (.-)%% and redirecting (.-)%% of all damage they take to you%.\
\
Lasts (.-)%. This effect will fall off if you are more than 30 yds from the ally%.%s*$","Vincula você um aliado, reduzindo em {{1}}% todo o dano que ele recebe e redirecionando {{2}}% desse dano para você.\
\
Dura {{3}}. O efeito termina se você se afastar mais de 30 m do aliado."},
    {"^Call an |cffffffffAir Elemental|r to aid you in combat that  gains a stack of |cffffffffInvigoration|r whenever it deals damage%.%s*$","Invoca um |cffffffffElemental Aéreo|r para ajudar você em combate. Ele recebe uma aplicação de |cffffffffVigorização|r sempre que causa dano."},
    {"^|cFF66DDFFLevel 30 Passive|r\
While |cffffffffRunic Tattoos: Fire|r is active, your |cffffffffGlyphic Ruin|r now has (.-)%% increased critical damage%.\
\
While |cffffffffRunic Tattoos: Water|r is active, the cost of your |cffffffffGlyphic Ruin|r is now reduced by (.-)%%%.%s*$","|cFF66DDFFPassivo de Nível 30|r\
Enquanto |cffffffffTatuagens Rúnicas: Fogo|r estiver ativa, o dano crítico de |cffffffffRuína Glífica|r aumenta em {{1}}%.\
\
Enquanto |cffffffffTatuagens Rúnicas: Água|r estiver ativa, o custo de |cffffffffRuína Glífica|r é reduzido em {{2}}%."},
    {"^Creates a zone blessed by moonwell waters for (.-) at the target location%. \
\
All allied players standing within the well receive (.-)%% more healing, and their mana regeneration is increased by (.-)%%%.\
\
|cffffffffFull Moon|r: This is instant%.\
\
|cffffffffNew Moon|r: Triggers a (.-) sec reduced cooldown%.%s*$","Cria no local selecionado uma zona abençoada pelas águas de um poço lunar durante {{1}}.\
\
Todos jogadores aliados dentro do poço recebem {{2}}% a mais de cura, e a regeneração de mana deles aumenta em {{3}}%.\
\
|cffffffffLua Cheia|r: O lançamento é instantâneo.\
\
|cffffffffLua nova|r: reduz a recarga em {{4}} s."},
    {"^Call an |cffffffffHonored Ancestor|r to aid you in battle until dismissed that scales with your Agility and attack power%.\
\
Whenever you use |cffffffffBarbaric Whirl|r or |cffffffffWhirling Advance|r, your |cffffffffHonored Ancestor|r mimics it%.%s*$","Invoca um |cffffffffAncestral Honrado|r para ajudar você em combate até ser dispensado. Seus atributos escalam com sua Agilidade e seu poder de ataque.\
\
Sempre que você usa |cffffffffRedemoinho Bárbaro|r ou |cffffffffAvanço Giratório|r, seu |cffffffffAncestral Honrado|r imita a habilidade."},
    {"^|cffff9933Generates 2 Demonfire|r\
Beckon (.-) |cffffffffHellfire Imps|r to aid you in battle for (.-) and generate (.-) Rage%.\
\
Threat generated by |cffffffffHellfire Imps|r is transferred to you%.%s*$","|cffff9933Gera 2 de Fogo Demoníaco|r\
Convoca {{1}} |cffffffffDiabretes do Fogo do Inferno|r para ajudar você em combate durante {{2}} e gera {{3}} de Raiva.\
\
a ameaça gerada pelos |cffffffffDiabretes do Fogo do Inferno|r é transferida para você."},
    {"^|cffff9933Generates 2 Demonfire|r\
Beckon (.-) |cffffffffHellfire Imp|r to aid you in battle for (.-) and generate (.-) Rage%.\
\
Threat generated by |cffffffffHellfire Imps|r is transferred to you%.%s*$","|cffff9933Gera 2 de Fogo Demoníaco|r\
Convoca {{1}} |cffffffffDiabrete do Fogo Infernal|r para ajudar você em combate durante {{2}} e gera {{3}} de Raiva.\
\
a ameaça gerada pelos |cffffffffDiabretes do Fogo do Inferno|r é transferida para você."},
    {"^Animate a |cffffffffBone Wraith|r to aid you in combat for (.-)%.\
\
While active, it will periodically unleash a |cffffffffBonestorm|r, striking up to (.-) nearby enemies for (.-) Physical damage every (.-) sec for (.-)%.%s*$","Anima um |cffffffffEspectro Ósseo|r para ajudar você em combate durante {{1}}.\
\
Enquanto estiver ativo, ele lançará periodicamente uma |cffffffffTempestade Óssea|r, atingindo até {{2}} inimigos próximos e causando {{3}} de dano Físico a cada {{4}} s durante {{5}}."},
    {"^Animate (.-) |cffffffffSkeletal Archers|r to aid you in combat for (.-)%.%s*$","Anima {{1}} |cffffffffArqueiros Esqueléticos|r para ajudar você em combate durante {{2}}."},
    {"^Animate a |cffffffffTomb King|r to aid you in combat for (.-)%.\
\
While active, all of your Undead minion's attacks deal an additional (.-)%% of the damage dealt as Plague damage%.%s*$","Anima um |cffffffffRei da Tumba|r para ajudar você em combate durante {{1}}.\
\
Enquanto estiver ativo, todos ataques dos seus lacaios Mortos-vivos causarão como dano de Peste um valor adicional equivalente a {{2}}% do dano causado."},
    {"^Animate a |cffffffffPlaguefather|r to aid you in combat for (.-)%. \
\
Damage dealt by this minion will emit |cffffffffZombie Plague|r, dealing (.-) Plague damage to nearby enemies, and reducing their attack power by (.-)%.%s*$","Anima um |cffffffffPai da Peste|r para ajudar você em combate durante {{1}}.\
\
O dano causado por este lacaio emitirá |cffffffffPeste Zumbi|r, causando {{2}} de dano de Peste os inimigos próximos e reduz o poder de ataque deles em {{3}}."},
    {"^Reduces the duration of any stun or snare effects used on you by (.-)%% and increases your dodge chance by (.-)%%%.%s*$","reduz em {{1}}% a duração dos efeitos de atordoamento e imobilização usados contra você e aumenta em {{2}}% sua chance de esquiva."},
    {"^Call down a streak of sun light to smite your target, dealing (.-) Fire damage to them and nearby enemies, piercing all immunities, but dealing less damage with each enemy struck%.%s*$","Faz um raio de luz solar atingir o alvo, causando {{1}} de dano de Fogo à ele e os inimigos próximos. Atravessa todas as imunidades, mas causa menos dano a cada inimigo atingido."},
    {"^Increases all damage you deal by (.-)%% and while your pet is under the effects of Bestial Wrath, you also go into a rage causing (.-)%% additional damage and reducing mana costs of all spells by (.-)%% for (.-)%.  While enraged, you do not feel pity or remorse or fear and you cannot be stopped unless killed%.%s*$","aumenta em {{1}}% todo o dano causado. Enquanto seu ajudante estiver sob o efeito de Cólera Bestial, você também entra em fúria, causando {{2}}% a mais de dano e reduz em {{3}}% o custo de mana de todos feitiços durante {{4}}. Enquanto estiver enfurecido, você não sente piedade, remorso nem medo e só pode ser impedido se for morto."},
    {"^Chance on landing a direct damage spell to deal (.-) Shadow damage and restore (.-) mana to you%.%s*$","Ao lançar um feitiço de dano direto, há uma chance de causar {{1}} de dano de Sombra e restaurar {{2}} de mana."},
    {"^Permanently enchant a shield to increase Intellect by (.-)%. Requires level 35 or higher to gain this benefit%.%s*$","Encanta permanentemente um escudo, aumenta em {{1}} O Intelecto. Requer nível 35 ou superior para receber este benefício."},
    {"^Attacks with both weapons, inflicting damage to an enemy, and weakening their attacks%.\
\
Deals triple damage to stunned targets%.%s*$","Ataca com as duas armas, causando dano um inimigo e enfraquecendo os ataques dele.\
\
Causa o triplo de dano contra alvos atordoados."},
    {"^Removes the Amani hex from a forest frog in Zul'Aman%.\
\
|cffff0000Removed from inventory upon leaving Zul'Aman!|r%s*$","Remove o feitiço Amani de uma rã da floresta em Zul'Aman.\
\
|cffff0000Removido do inventário ao sair de Zul'Aman!|r"},
    {"^Reduces the cooldown of your Hammer of Wrath spell by (.-)%% while Avenging Wrath is active%.%s*$","reduz em {{1}}% a recarga de Martelo da Ira enquanto Ira Vingativa estiver ativa."},
    {"^Permanently adds (.-) spell power and (.-) mana every 5 sec to shoulder armor%.\
\
Can only be applied to your own armor, and doing so will cause it to become soulbound%. Requires level 70 or higher to gain this benefit%.%s*$","Adiciona permanentemente {{1}} de poder mágico e {{2}} de mana a cada 5 s à uma armadura de ombros.\
\
Só pode ser aplicado à sua própria armadura, fazendo com que ela se torne vinculada à alma. Requer nível 70 ou superior para receber este benefício."},
    {"^Permanently adds (.-) spell power and (.-) critical strike rating to shoulder armor%.\
\
Can only be applied to your own armor, and doing so will cause it to become soulbound%. Requires level 70 or higher to gain this benefit%.%s*$","Adiciona permanentemente {{1}} de poder mágico e {{2}} de índice de acerto crítico à uma armadura de ombros.\
\
Só pode ser aplicado à sua própria armadura, fazendo com que ela se torne vinculada à alma. Requer nível 70 ou superior para receber este benefício."},
    {"^When activated, your next Druid Nature spell with a base casting time less than 10 sec%. becomes an instant cast spell%. Your Healing Touch will heal for 25%% less while this buff is active%.%s*$","Quando ativado, seu próximo feitiço de Natureza de Druida com tempo-base de lançamento inferior a 10 s será instantâneo. Seu Toque de cura curará 25% a menos enquanto este benefício estiver ativo."},
    {"^Your non%-periodic Fire damage increases by 1%%%(0%.5%% vs%. players%) per |cFFFFFFFFInner Fire|r charge but consumes 2 charges%.\
\
|cFFFFFFFFInner Fire|r grants (.-)%% less charges%. Cooldown of Holy Fire is reduced by (.-) sec\
\
Consuming charges grants a |cFFFFFFFFRighteous Flames|r stack%. At max stacks, Holy Fire deals Radiant Damage to 5 nearby targets, restores 15 Inner Fire charges per target, and makes your next 3 Fire spells extend Holy Fire by 1 second%.\
\
Casting |cFFFFFFFFInner Fire|r also deals Radiant damage in an 8%-yard area %(8%.5 sec cooldown%)%. \
\
Radiant damage benefits from the higher modifier of Fire or Holy%.%s*$","Seu dano de Fogo não periódico aumenta em 1% (0,5% contra jogadores) por carga de |cFFFFFFFFFogo Interior|r, mas consome 2 cargas.\
\
|cFFFFFFFFFogo Interior|r concede {{1}}% menos cargas. a recarga de Fogo Sagrado é reduzida em {{2}} s.\
\
Consumir cargas concede uma aplicação de |cFFFFFFFFChamas Íntegras|r. Com o máximo de aplicações, Fogo Sagrado causa dano Radiante a 5 alvos próximos, restaura 15 cargas de Fogo Interior por alvo e faz seus próximos 3 feitiços de Fogo prolongarem Fogo Sagrado em 1 s.\
\
Lançar |cFFFFFFFFFogo Interior|r também causa dano Radiante em uma zona de 8 m (8,5 s de recarga).\
\
O dano Radiante recebe o maior modificador entre Fogo e Sagrado."},
    {"^Shock the target with frost, causing Frost damage and slowing the target's movement speed%.%s*$","Atinge o alvo com gelo, causando dano de Gelo e reduz a velocidade de movimento dele."},
    {"^Places a Totem that removes fears, charms and sleep effect from your allies%.%s*$","Posiciona um Totem que remove efeitos de medo, encantamento e sono dos seus aliados."},
    {"^Take on the Aspects of a Beast, becoming untrackable and increasing melee attack power by for you and your pet%.%s*$","Assume os Aspectos de uma Fera, tornando você indetectável e aumenta o poder de ataque corpo a corpo seu e do seu ajudante."},
    {"^Dealing Physical damage with a Hunter ability on targets affected by your |cFFFFFFFFBlack Arrow|r has a (.-)%% chance of granting you |cFFFFFFFFWidowmaker|r%.\
\
This effect can only occur every 5 seconds%.%s*$","Causar dano Físico com uma habilidade de Caçador alvos afetados por |cFFFFFFFFFlecha Negra|r tem {{1}}% de chance de conceder |cFFFFFFFFFaz-Viúvas|r.\
\
Este efeito só pode ocorrer uma vez a cada 5 s."},
    {"^|cFFFFFFFFThis spell belongs to |r|cFF6EFF00Witch Doctor|r\
\
Transform enemies at target location into a frog, making them unable to attack or cast spells, and slowing their movement speed by (.-)%% for (.-)%. While transformed into a frog the enemy is considered a Beast%.\
\
Damage caused may interrupt the effect%.%s*$","|cFFFFFFFFEste feitiço pertence a |r|cFF6EFF00Mandingueiro|r\
\
Transformos inimigos no local selecionado em rãs, impedindo-os de atacar ou lançar feitiços e reduz em {{1}}% a velocidade de movimento deles durante {{2}}. Enquanto estiver transformado em rã, o inimigo será considerado uma Fera.\
\
O dano causado pode interromper o efeito."},
    {"^Transforms an enemie into a frog, rendering him unable to attack or cast spells for (.-)%.%s*$","Transforma um inimigo em uma rã, impedindo-o de atacar ou lançar feitiços durante {{1}}."},
    {"^Increases your spell haste by (.-)%% and reduces the pushback suffered from damaging attacks by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: If hit by an Interrupt when not casting, you become immune to the next Crowd Control, Knockback, Silence, or Interrupt for (.-) and your next Druid Nature spell within (.-) becomes an instant cast%. This effect can only occur once every (.-)%.|r%s*$","aumenta em {{1}}% sua celeridade de feitiço e reduz em {{2}}% o atraso de lançamento causado por ataques que provocam dano.\
\
|cFFAAAAAABônus de Ápice: Se você sofrer uma Interrupção enquanto não estiver lançando, ficará imune ao próximo Controle Coletivo, Repulsão, Silêncio ou Interrupção durante {{3}}, e seu próximo feitiço de Natureza de Druida lançado em até {{4}} será instantâneo. Este efeito só pode ocorrer uma vez a cada {{5}}.|r"},
    {"^Increases your spell haste by (.-)%% and reduces the pushback suffered from damaging attacks by (.-)%%%.\
\
Capstone Bonus: If hit by an Interrupt when not casting, you become immune to the next Crowd Control, Knockback, Silence, or Interrupt for (.-) and your next Druid Nature spell within (.-) becomes an instant cast%. This effect can only occur once every (.-)%.%s*$","aumenta em {{1}}% sua celeridade de feitiço e reduz em {{2}}% o atraso de lançamento causado por ataques que provocam dano.\
\
Bônus de Ápice: Se você sofrer uma Interrupção enquanto não estiver lançando, ficará imune ao próximo Controle Coletivo, Repulsão, Silêncio ou Interrupção durante {{3}}, e seu próximo feitiço de Natureza de Druida lançado em até {{4}} será instantâneo. Este efeito só pode ocorrer uma vez a cada {{5}}."},
    {"^You become Enlightned, causing you to generate 4 Rage every second if you are moving%. If you are not moving, you will instead generate 10 Energy%.If you have the 'Fury of the Tiger' spell, apply its effect as well%.%s*$","Você alcança à Iluminação, fazendo com que gere 4 de Raiva a cada segundo enquanto estiver em movimento. Se estiver parado, gerará 10 de Energia. Se conhecer o feitiço 'Fúria do Tigre', também aplicará o efeito dele."},
    {"^|cff32cd32Consumes 2 Felfury|r\
Blast an enemy for (.-) Shadowflame Damage and generate (.-) Energy%.\
\
|cff32cd32Inner Demon|r: This spell casts an additional time free of cost%.%s*$","|cff32cd32Consome 2 de Fúria Vil|r\
Explode um inimigo, causando {{1}} de dano de Chama Sombria e gerando {{2}} de Energia.\
\
|cff32cd32Demônio Interior|r: Este feitiço é lançado uma vez adicional sem custo."},
    {"^You are granted 8 charges of |cffffffffCounter Stance|r, increasing your chance to block by (.-)%% and your block value by (.-)%% for (.-) and dealing (.-) damage to attackers whenever you take Physical Damage or block a physical attack%.\
\
Each attack expends a charge%.%s*$","Concede 8 cargas de |cffffffffPostura contraria|r, aumenta em {{1}}% sua chance de bloqueio e em {{2}}% seu valor de bloqueio durante {{3}}, além de causar {{4}} de dano aos atacantes sempre que você recebe dano Físico ou bloqueia um ataque físico.\
\
Cada ataque consome uma carga."},
    {"^Utter your most |cffffffffInspiring Speech|r, reducing an allies damage taken by (.-)%% for (.-)%. Can be used while moving%.\
\
Also reduces the damage taken of party and raid members within (.-)|r yds that are affected by |cff66ccffMotivation|r, and cleanses 1 harmful Magic Effect from them%.%s*$","Profere seu mais |cffffffffDiscurso Inspirador|r, reduzindo em {{1}}% o dano recebido por um aliado durante {{2}}. Pode ser usado em movimento.\
\
Também reduz o dano recebido pelos membros do grupo e da raide em um raio de {{3}}|r m afetados por |cff66ccffMotivação|r e remove deles 1 efeito Mágico nocivo."},
    {"^Increases the leech of |cFFFFFFFFVampiric Feast|r by (.-)%%%.\
\
Consuming at least 9 stacks of |cffffffffThirst|r with |cffffffffVampiric Fang|r now extends the duration of |cffffffffTransgression|r by (.-) sec%.%s*$","aumenta em {{1}}% a drenagem de |cFFFFFFFFBanquete vampírico|r.\
\
Consumir pelo menos 9 aplicações de |cffffffffSede|r com |cffffffffPresa Vampírica|r agora prolonga em {{2}} s a duração de |cffffffffTransgressão|r."},
    {"^You imbue your weapon with ghostly power for (.-), causing melee attacks to deal additional (.-) Spellshadow Damage%. \
\
While this effect is active, weapon attacks also generate (.-)%% of your maximum mana%.%s*$","Imbui sua arma com poder espectral durante {{1}}, fazendo com que ataques corpo a corpo causem {{2}} de dano de Sombra Mágica adicional.\
\
Enquanto este efeito estiver ativo, ataques com arma também geram {{3}}% do seu mana máximo."},
    {"^Transform into a |cffffffffHerald of the Depths|r for (.-), increasing damage and healing done by (.-)%% and the duration of absorption and healing over time effects by (.-)%%%.\
\
At the end of the duration, your |cffcfa6ffInsanity|r is reduced to 0%.%s*$","Transforma você em um |cffffffffArauto do abismo|r durante {{1}}, aumenta em {{2}}% o dano e a cura realizados e em {{3}}% a duração dos efeitos de absorção e cura periódica.\
\
Ao final da duração, sua |cffcfa6ffDemência|r é reduzida a 0."},
    {"^Increases all party and raid member's melee and ranged haste by (.-)%%%. Does not stack with similar effects%.\
\
Damage dealt with auto attacks reduce the cooldown of |cFFFFFFFFLibram|r spells by (.-) sec%.%s*$","aumenta em {{1}}% a celeridade corpo a corpo e de ataque à distância de todos membros do grupo e da raide. Não acumula com efeitos semelhantes.\
\
O dano causado por ataques automáticos reduz em {{2}} s a recarga dos feitiços de |cFFFFFFFFTratado|r."},
    {"^Summons a Rotling to aid you in combat for (.-)%.\
\
Rotlings do not occupy any Life Force%.%s*$","Invoca um |cffffffffPútrido|r para ajudar você em combate durante {{1}}.\
\
Pútridos não ocupam Força Vital."},
    {"^Imbue primal power into your weapon, increasing attack power by (.-)%%%. \
\
While active, |cffffffffWildclaw|r now reduces the remaining cooldown of |cffffffffBear's Maw|r by (.-) sec%.%s*$","Imbui sua arma com poder primevo, aumenta em {{1}}% o poder de ataque.\
\
Enquanto estiver ativo, |cffffffffGarra Selvagem|r reduz em {{2}} s a recarga restante de |cffffffffMandíbula do Urso|r."},
    {"^Damage dealt by |cffffffffEruption|r on enemies below 35%% health is increased by (.-)%%%.\
\
In addition, |cffffffffEruption|r now reduces your damage taken by (.-)%% for the duration%.%s*$","O dano de |cffffffffErupção|r contra inimigos com menos de 35% de vida aumenta em {{1}}%.\
\
Além disso, |cffffffffErupção|r agora reduz em {{2}}% o dano recebido durante sua duração."},
    {"^Enter a unique |cffa966f0Cursed Form|r for (.-) that does not disable the use of |cffffffffMortal Form|r abilities and casts a free |cffffffffVampiric Fang|r on your target, granting spell damage equal to (.-)%% of your Spirit%.\
\
While active, direct spell damage triggers a |cffffffffVampiric Feast|r, dealing (.-)%% additional Shadow damage to enemies, healing you equal to 50%% of the damage dealt%.\
\
While in a |cffa966f0Cursed Form|r you are treated as if you were a Demon%.%s*$","Assume uma |cffa966f0Forma Amaldiçoada|r única durante {{1}}, sem impedir o uso das habilidades da |cffffffffForma Mortal|r, e lança gratuitamente |cffffffffColmilho vampírico|r no alvo, concedendo poder mágico equivalente a {{2}}% do seu Espírito.\
\
Enquanto estiver ativa, o dano direto de feitiço ativa |cffffffffBanquete vampírico|r, causando {{3}}% de dano de Sombra adicional os inimigos e curando você em 50% do dano causado.\
\
Enquanto estiver em uma |cffa966f0Forma Amaldiçoada|r, você será considerado um Demônio."},
    {"^Enter a unique |cffa966f0Cursed Form|r for (.-) that does not disable the use of |cffffffffMortal Form|r abilities and casts a free |cffffffffVampiric Fang|r on your target%.\
\
While active, direct spell damage triggers a |cffffffffVampiric Feast|r, dealing (.-)%% additional Shadow damage to enemies, healing you equal to 50%% of the damage dealt%.\
\
While in a |cffa966f0Cursed Form|r you are treated as if you were a Demon%.%s*$","Assume uma |cffa966f0Forma Amaldiçoada|r única durante {{1}}, sem impedir o uso das habilidades da |cffffffffForma Mortal|r, e lança gratuitamente |cffffffffColmilho vampírico|r no alvo.\
\
Enquanto estiver ativa, o dano direto de feitiço ativa |cffffffffBanquete vampírico|r, causando {{2}}% de dano de Sombra adicional os inimigos e curando você em 50% do dano causado.\
\
Enquanto estiver em uma |cffa966f0Forma Amaldiçoada|r, você será considerado um Demônio."},
    {"^Enter a unique |cffa966f0Cursed Form|r for (.-) that does not disable the use of |cffffffffMortal Form|r abilities and casts a free |cffffffffVampiric Fang|r on your target, granting spell damage equal to (.-)%% of your Spirit%.\
\
While active, direct spell damage triggers a |cffffffffVampiric Feast|r, dealing (.-)%% additional Shadow Damage to enemies, healing you equal to 50%% of the damage dealt%.\
\
While in a |cffa966f0Cursed Form|r you are treated as if you were a Demon%.%s*$","Assume uma |cffa966f0Forma Amaldiçoada|r única durante {{1}}, sem impedir o uso das habilidades da |cffffffffForma Mortal|r, e lança gratuitamente |cffffffffColmilho vampírico|r no alvo, concedendo poder mágico equivalente a {{2}}% do seu Espírito.\
\
Enquanto estiver ativa, o dano direto de feitiço ativa |cffffffffBanquete vampírico|r, causando {{3}}% de dano de Sombra adicional os inimigos e curando você em 50% do dano causado.\
\
Enquanto estiver em uma |cffa966f0Forma Amaldiçoada|r, você será considerado um Demônio."},
    {"^Enter a unique |cffa966f0Cursed Form|r for (.-) that does not disable the use of |cffffffffMortal Form|r abilities and casts a free |cffffffffVampiric Fang|r on your target%.\
\
While active, direct spell damage triggers a |cffffffffVampiric Feast|r, dealing (.-)%% additional Shadow Damage to enemies, healing you equal to 50%% of the damage dealt%.\
\
While in a |cffa966f0Cursed Form|r you are treated as if you were a Demon%.%s*$","Assume uma |cffa966f0Forma Amaldiçoada|r única durante {{1}}, sem impedir o uso das habilidades da |cffffffffForma Mortal|r, e lança gratuitamente |cffffffffColmilho vampírico|r no alvo.\
\
Enquanto estiver ativa, o dano direto de feitiço ativa |cffffffffBanquete vampírico|r, causando {{2}}% de dano de Sombra adicional os inimigos e curando você em 50% do dano causado.\
\
Enquanto estiver em uma |cffa966f0Forma Amaldiçoada|r, você será considerado um Demônio."},
    {"^You |cffe600e6Summon|r an Abomination to assist you in combat%.\
\
Abominations |cffff3232Taunt|r enemies in an area around them and have very high |cfffeff9e|cfffeff9eHealth|r|r%.\
\
Lasts |cfffeff9e(.-)|r%.%s*$","Você |cffe600e6Evocar|r uma Abominação para ajudar em combate.\
\
Abominações |cffff3232Provocar|r os inimigos em uma área ao redor e possuem |cfffeff9e|cfffeff9eVida|r|r extremamente alta.\
\
Dura |cfffeff9e{{1}}|r."},
    {"^Ascend into a celestial humanoid form for (.-), increasing your critical strike chance by (.-)%%%.\
\
While active, ranged critical strikes now reduce the cooldown of all healing spells by 10%% and apply a |cff66ccffScattered Star|r to your target and up to 4 enemies within 5 yds of them%.%s*$","Ascende à uma forma humanoide celestial durante {{1}}, aumenta em {{2}}% sua chance de acerto crítico.\
\
Enquanto estiver ativa, seus acertos críticos à distância reduzem em 10% a recarga de todos feitiços de cura e aplicam uma |cff66ccffEstrela Dispersa|r ao alvo e à até 4 inimigos em um raio de 5 m dele."},
    {"^Increases maximum Rage, Energy and mana by (.-)%%%.\
\
In addition, while |cffffffffSpider Form|r or |cffffffffScorpid|r form is active your attacks are unable to be parried or dodged%.%s*$","aumenta em {{1}}% o máximo de Raiva, Energia e mana.\
\
Além disso, enquanto |cffffffffForma de Aranha|r ou |cffffffffForma de Escorpídeo|r estiver ativa, seus ataques não poderão ser aparados nem esquivados."},
    {"^Shields your spellcasting for (.-)%. If you are Interrupted during this time, you gain (.-)%% increased Spell Haste and (.-)%% increased Spell Damage for (.-)%.\
\
This spell is usable while Casting or Channeling another spell%.%s*$","proteja seus lançamentos de feitiço durante {{1}}. Se você for Interrompido nesse período, recebe {{2}}% de celeridade de feitiço e {{3}}% de dano mágico adicionais durante {{4}}.\
\
Este feitiço pode ser usado enquanto você lança ou canaliza outro feitiço."},
    {"^Apply a dark boon to yourself for (.-), causing your next (.-) |cffffffffHammer of Twilight|r to deal an additional (.-)%% of its damage dealt to the enemy%.%s*$","Concede a você uma dádiva sombria durante {{1}}, fazendo seus próximos {{2}} |cffffffffMartelo do Crepúsculo|r causarem ao inimigo dano adicional equivalente a {{3}}% do dano causado."},
    {"^While your tamed pet is under the effects of Bestial Wrath, you have a 50%% chance to also go into a rage causing (.-)%% additional damage and reducing mana costs of all spells by (.-)%% for (.-)%.  While enraged, you do not feel pity or remorse or fear and you cannot be stopped unless killed%.\
\
Does not stack with other similar effects%.%s*$","Enquanto seu ajudante domesticado estiver sob o efeito de Cólera Bestial, você terá 50% de chance de também entrar em fúria, causando {{1}}% a mais de dano e reduz em {{2}}% o custo de mana de todos feitiços durante {{3}}. Enquanto estiver enfurecido, você não sente piedade, remorso nem medo e só pode ser impedido se for morto.\
\
Não acumula com outros efeitos semelhantes."},
    {"^Throw a keg into the distance, upon impact it deals Physical damage in a 8%- yard area, reducing attack speed by (.-)%%%. Lasts (.-)%.\
\
Hitting a target affected by |cFFFFFFFFKeg Smash|r has a 20%% chance to apply Soaked%.\
\
Hitting a Soaked target has a chance to grant you a stack of |cFFFFFFFFDrunken Brawler|r%.%s*$","Arremessa um barril à distância. Ao atingir o local, causa dano Físico em uma zona de 8 m e reduz em {{1}}% a velocidade de ataque. Dura {{2}}.\
\
Atingir um alvo afetado por |cFFFFFFFFDestruidor de barris|r tem 20% de chance de aplicar Encharcado.\
\
Atingir um alvo Encharcado tem chance de conceder uma aplicação de |cFFFFFFFFLutador bêbado|r."},
    {"^\
Transforms the enemy into a frogduck, forcing it to wander around for up to 50 seconds %(8 seconds on players%)%.  While wandering, the frogduck cannot attack or cast spells but will regenerate very quickly%. Any damage will transform the target back into its normal form%.  Only one target can be polymorphed at a time%. Only works on Beasts, Humanoids and Critters%.%s*$","\
Transforma o inimigo em uma pato-rã, obrigando-o a vagar por até 50 s (8 s contra jogadores). Enquanto estiver vagando, a pato-rã não poderá atacar nem lançar feitiços, mas se regenerará muito rapidamente. Qualquer dano fará o alvo voltar em forma normal. Apenas um alvo pode ser polimorfado por vez. Funciona somente em Feras, Humanoides e Bichos."},
    {"^Transforms up to 5 enemies into frogs, rendering them unable to attack or cast spells for (.-)%.%s*$","Transforma até 5 inimigos em rãs, impedindo-os de atacar ou lançar feitiços durante {{1}}."},
    {"^Increases the Fel Power gained by you and your party by (.-)%%%. If you are slain, you will grant (.-)%% additional Souls to your killer%.%s*$","aumenta em {{1}}% O Poder Vil recebido por você e seu grupo. Se você for morto, concederá {{2}}% a mais de Almas ao responsável por sua morte."},
    {"^Increases the Felforged Souls gained by you and your party by (.-)%%%. If you are slain, you will grant (.-)%% additional Souls to your killer%.%s*$","aumenta em {{1}}% as Almas Forjadas em Vil recebidas por você e seu grupo. Se você for morto, concederá {{2}}% a mais de Almas ao responsável por sua morte."},
    {"^Granted when you |cFFFFFFFFdeal damage|r with |cFFFFFFFFFrostbolt|r or |cFFFFFFFFIce Lance|r%. Stacks to 5%.\
\
|cFFFFFFFFFlash Heal|r, |cFFFFFFFFGreater Heal|r and |cFFFFFFFFPrayer of Healing|r consume up to 2 stacks to reduce their cast time by 50%% and reduce their mana cost by 10%% per stack%.\
\
|cFFFFFFFFIcy Penance|r strikes heal nearby allies%. Consumes 1 stack when the channel ends%.%s*$","Concedido quando você |cFFFFFFFFcausa dano|r com |cFFFFFFFFSeta de Gelo|r ou |cFFFFFFFFLança de Gelo|r. Acumula até 5 vezes.\
\
|cFFFFFFFFCura Célere|r, |cFFFFFFFFCura Maior|r e |cFFFFFFFFPrece de Cura|r consomem até 2 aplicações para reduzir em 50% o tempo de lançamento e em 10% o custo de mana por aplicação.\
\
Os golpes de |cFFFFFFFFPenitência gélida|r curam aliados próximos. Consome 1 aplicação quando a canalização termina."},
    {"^Summons and dismisses your Vicious War Croaker %(Horde%)%.%s*$","Evoca e dispensa Vicious War Croaker (Horde)."},
    {"^Summons and dismisses your Vicious War Croaker %(Alliance%)%.%s*$","Evoca e dispensa Vicious War Croaker (Alliance)."},
    {"^Reduces the cooldown of your Strangulate by (.-) sec%.%s*$","reduz em {{1}} s a recarga de Estrangular."},
    {"^Increases the damage of your Glaive Toss by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: Your Glaive Toss reduces the movement speed of the target by (.-)%% for (.-)%.|r%s*$","aumenta em {{1}}% o dano de Arremesso de Guja.\
\
|cFFAAAAAABônus de Ápice: Arremesso de Guja reduz em {{2}}% a velocidade de movimento do alvo durante {{3}}.|r"},
    {"^Your blade is empowered for (.-)%.\
\
%- |cFFFFFFFFDevastate|r: Deals (.-)%% additional damage to nearby enemies and reduces their armor by an additional (.-)%%%. \
\
%- |cFFFFFFFFRiposte|r: Increases your damage staggered, if known, by (.-)%% for (.-)%. \
\
%- |cFFFFFFFFDivine Storm|r: Increases your Armor by (.-)%% of your Strength and your Holy Spell Damage by (.-)%% of your Strength%. Lasts (.-)%.%s*$","Sua lâmina é fortalecida durante {{1}}.\
\
- |cFFFFFFFFDevastar|r: Causa {{2}}% de dano adicional os inimigos próximos e reduz a armadura deles em mais {{3}}%.\
\
- |cFFFFFFFFContra-ataque|r: aumenta em {{4}}% seu dano escalonado, caso conheça esse efeito, durante {{5}}.\
\
- |cFFFFFFFFTempestade Divina|r: aumenta sua Armadura em {{6}}% da sua Força e seu dano mágico Sagrado em {{7}}% da sua Força. Dura {{8}}."},
    {"^Your blade is empowered for (.-)%.\
\
%- |cFFFFFFFFDevastate|r: Deals (.-)%% additional damage to nearby enemies and reduces their armor by an additional (.-)%%%. \
\
%- |cFFFFFFFFRiposte|r: Increases your damage staggered, if known, by (.-)%% for (.-)%.%s*$","Sua lâmina é fortalecida durante {{1}}.\
\
- |cFFFFFFFFDevastar|r: Causa {{2}}% de dano adicional os inimigos próximos e reduz a armadura deles em mais {{3}}%.\
\
- |cFFFFFFFFContra-ataque|r: aumenta em {{4}}% seu dano escalonado, caso conheça esse efeito, durante {{5}}."},
    {"^Your blade is empowered for (.-)%.\
\
Increases your critical strike rating by (.-)%% of your Strength%.\
\
%- |cFFFFFFFFDevastate|r: Deals (.-)%% additional damage to nearby enemies and reduces their armor by an additional (.-)%%%.\
\
%- |cFFFFFFFFRiposte|r: Increases your damage staggered, if known, by (.-)%% for (.-)%. \
\
%- |cFFFFFFFFDivine Storm|r: Increases your Armor by (.-)%% of your Strength and your Holy Spell Damage by (.-)%% of your Strength%. Lasts (.-)%.%s*$","Sua lâmina é fortalecida durante {{1}}.\
\
aumenta seu índice de acerto crítico em {{2}}% da sua Força.\
\
- |cFFFFFFFFDevastar|r: Causa {{3}}% de dano adicional os inimigos próximos e reduz a armadura deles em mais {{4}}%.\
\
- |cFFFFFFFFContra-ataque|r: aumenta em {{5}}% seu dano escalonado, caso conheça esse efeito, durante {{6}}.\
\
- |cFFFFFFFFTempestade Divina|r: aumenta sua Armadura em {{7}}% da sua Força e seu dano mágico Sagrado em {{8}}% da sua Força. Dura {{9}}."},
    {"^Your blade is empowered for (.-)%.\
\
Increases your critical strike rating by (.-)%% of your Strength%.\
\
%- |cFFFFFFFFDevastate|r: Deals (.-)%% additional damage to nearby enemies and reduces their armor by an additional (.-)%%%.\
\
%- |cFFFFFFFFRiposte|r: Increases your damage staggered, if known, by (.-)%% for (.-)%.%s*$","Sua lâmina é fortalecida durante {{1}}.\
\
aumenta seu índice de acerto crítico em {{2}}% da sua Força.\
\
- |cFFFFFFFFDevastar|r: Causa {{3}}% de dano adicional os inimigos próximos e reduz a armadura deles em mais {{4}}%.\
\
- |cFFFFFFFFContra-ataque|r: aumenta em {{5}}% seu dano escalonado, caso conheça esse efeito, durante {{6}}."},
    {"^Increases the damage done by your Bloodthirst, Raging Blow, Siegebreaker, Slam, Victory Rush and Whirlwind abilities by (.-)%%%. \
\
Increases the duration of Bloodrage by 2 seconds%. \
\
Increases the duration of Intercept by 0%.33 sec%.\
\
|cFFAAAAAACapstone Bonus: While Bloodrage is active Fear effect durations are reduced by 30%% and a successful Whirlwind reduces the cooldown of your next Whirlwind by 3 seconds%.|r%s*$","Aumenta em {{1}}% o dano causado por suas habilidades Sede de Sangue, Golpe Furioso, Rompe-Cercos, Batida, Ímpeto da Vitória e Redemoinho.\
\
Aumenta em 2 segundos a duração de Raiva Sangrenta.\
\
Aumenta em 0,33 s a duração de Interceptar.\
\
|cFFAAAAAABônus de Ápice: Enquanto Raiva Sangrenta estiver ativa, a duração dos efeitos de medo será reduzida em 30%, e um Redemoinho bem-sucedido reduzirá em 3 segundos a recarga do seu próximo Redemoinho.|r"},
    {"^Increases the damage done by your Bloodthirst, Raging Blow, Siegebreaker, Slam, Victory Rush and Whirlwind abilities by (.-)%%%. \
\
Increases the duration of Bloodrage by 4 seconds%.\
\
increases the duration of Intercept by 0%.66 sec%.\
\
|cFFAAAAAACapstone Bonus: While Bloodrage is active Fear effect durations are reduced by 30%% and a successful Whirlwind reduces the cooldown of your next Whirlwind by 3 seconds%.|r%s*$","Aumenta em {{1}}% o dano causado por suas habilidades Sede de Sangue, Golpe Furioso, Rompe-Cercos, Batida, Ímpeto da Vitória e Redemoinho.\
\
Aumenta em 4 segundos a duração de Raiva Sangrenta.\
\
Aumenta em 0,66 s a duração de Interceptar.\
\
|cFFAAAAAABônus de Ápice: Enquanto Raiva Sangrenta estiver ativa, a duração dos efeitos de medo será reduzida em 30%, e um Redemoinho bem-sucedido reduzirá em 3 segundos a recarga do seu próximo Redemoinho.|r"},
    {"^Your blade is empowered for (.-)%.\
\
%- |cFFFFFFFFDevastate|r: Deals (.-)%% additional damage to nearby enemies and reduces their armor by an additional (.-)%%%.\
\
%- |cFFFFFFFFRiposte|r: Increases your damage staggered, if known, by (.-)%% for (.-)%. \
\
%- |cFFFFFFFFDivine Storm|r: Increases your Armor by (.-)%% of your Strength and your Holy Spell Damage by (.-)%% of your Strength%. Lasts (.-)%.%s*$","Seu lâmina está fortalecida durante {{1}}.\
\
- |cFFFFFFFFDevastar|r: Causa {{2}}% de dano adicional os inimigos próximos e reduz sua armadura {{3}}% adicional.\
\
- |cFFFFFFFFContra-ataque|r: aumenta seu dano escalonado, caso conheça, em {{4}}% durante {{5}}. \
\
- |cFFFFFFFFTempestade Divina|r: aumenta seu armadura em {{6}}% de seu Força e seu dano com feitiços sagrados em {{7}}% de seu Força. Dura {{8}}."},
    {"^Your blade is empowered for (.-)%.\
\
%- |cFFFFFFFFDevastate|r: Deals (.-)%% additional damage to nearby enemies and reduces their armor by an additional (.-)%%%.\
\
%- |cFFFFFFFFRiposte|r: Increases your damage staggered, if known, by (.-)%% for (.-)%.%s*$","Seu lâmina está fortalecida durante {{1}}.\
\
- |cFFFFFFFFDevastar|r: Causa {{2}}% de dano adicional os inimigos próximos e reduz sua armadura {{3}}% adicional.\
\
- |cFFFFFFFFContra-ataque|r: aumenta seu dano escalonado, caso conheça, em {{4}}% durante {{5}}."},
    {"^Your maximum health is increased by (.-)%%, and your chance to be critically hit is reduced by (.-)%%%.\
\
|cFFFFFFFFImmolation Aura|r increases the percentage of damage shared via your |cFFFFFFFFSoul Link|r by 10%% and protects you against most effects that would interrupt your ongoing spell cast%.%s*$","Seu Vida máxima aumenta {{1}}%, e sua chance de receber um acerto crítico é reduzida {{2}}%.\
\
|cFFFFFFFFAura de Imolação|r aumenta o percentual de dano compartilhado por meio de seu |cFFFFFFFFVínculo da Alma|r em 10% e proteja você contra a maioria dos efeitos que interromperiam seu lançamento de feitiço em curso."},
    {"^Increases your Maximum Health by (.-)%%, Armor Contribution from Cloth Items by 250%%, Dodge Rating by (.-)%% of your Spell Power, and all resistances by (.-)%.\
\
Significantly increases threat and makes you immune to interrupt effects, but reduces your damage done by (.-)%% and healing done by (.-)%%%.\
\
While in Dark Apotheosis, your Immolate is instant, grants you |cFFFFFFFFImmolation Aura|r for 8 sec and restores (.-)%% base mana, but has a 6 sec cooldown%.%s*$","Aumenta em {{1}}% sua vida máxima, em 250% a contribuição de armadura dos itens de tecido, em {{2}}% do poder mágico seu índice de esquiva e em {{3}} todas as resistências.\
\
Aumenta significativamente a ameaça e torna você imune a efeitos de interrupção, mas reduz em {{4}}% o dano causado e em {{5}}% a cura realizada.\
\
Enquanto estiver em Apoteose Sombria, Imolar é instantâneo, concede |cFFFFFFFFAura de Imolação|r durante 8 s e restaura {{6}}% da mana base, mas possui 6 s de recarga."},
    {"^Increases your Maximum Health by (.-)%%, Armor Contribution from Cloth Items by 250%%, Dodge Rating by (.-)%% of your Spell Power, and all resistances by (.-)%.\
\
Significantly increases threat and makes you immune to interrupt effects, but reduces your damage done by (.-)%% and healing done by (.-)%%%.\
\
While in Dark Apotheosis, your Immolate is instant, grants you |cFFFFFFFFImmolation Aura|r for 8 sec and restores (.-)%% base mana, but has a 6 sec cooldown%.\
You can use all schools and spells in Dark Apotheosis%. Demons never hide behind cover against a foe, as such you cannot wear a shield%.\
\
You take 25%% increased damage versus players%.%s*$","Aumenta sua vida máxima em {{1}}%, a contribuição de armadura dos itens de tecido em 250%, o índice de esquiva em {{2}}% do seu poder mágico e todas as resistências em {{3}}.\
\
Aumenta significativamente A ameaça e torna você imune a efeitos de interrupção, mas reduz em {{4}}% o dano causado e em {{5}}% a cura realizada.\
\
Enquanto estiver em Apoteose Sombria, sua Imolar será instantânea, concederá |cFFFFFFFFAura de Imolação|r durante 8 s e restaurará {{6}}% da mana básica, mas terá 6 s de recarga.\
Você pode usar todas as escolas e feitiços durante Apoteose Sombria. Demônios nunca se escondem atrás de cobertura diante de um inimigo; portanto, você não pode usar escudo.\
\
Você recebe 25% a mais de dano de jogadores."},
    {"^Reaching (.-) stacks of |cFFFFFFFFSeething Growth|r now resets the cooldown of Sundering and Ground Slam and increases the critical chance and critical damage of its next cast by (.-)%%%. And makes Ground Slam trigger |cFFFFFFFFImpending Mortality|r if known%.%s*$","Ao alcançar {{1}} aplicações de |cFFFFFFFFCrescimento Furibundo|r agora reinicia a recarga de Ruptura e golpe ao Chão e aumenta a chance de acerto crítico e dano do próximo lançamento em {{2}}%. E faz com que golpe ao Chão ativa |cFFFFFFFFMortalidade Iminente|r caso conheça."},
    {"^Reaching (.-) stacks of |cFFFFFFFFSeething Growth|r now resets the cooldown of Sundering and Ground Slam and increases the critical chance and critical damage of its next cast by (.-)%%%. And makes Ground Slam trigger |cFFFFFFFFImpending Mortality|r if known%. Impending Mortality can only be triggered through Shattering Slam once every 20 seconds%.%s*$","Ao alcançar {{1}} aplicações de |cFFFFFFFFCrescimento Furibundo|r agora reinicia a recarga de Ruptura e golpe ao Chão e aumenta a chance de acerto crítico e dano do próximo lançamento em {{2}}%. E faz com que golpe ao Chão ativa |cFFFFFFFFMortalidade Iminente|r caso conheça. à Mortalidade Iminente só pode ser ativado por meio de Golpe Desintegrador uma vez a cada 20 segundos."},
    {"^Casting Align, Renew and Synchronize now grants you |cFFFFFFFFBorrowed Time|r%. If you also know the talent, you are granted the highest known rank%.%s*$","Lançar Alinhar, Renovar e Sincronizar agora concede a você |cFFFFFFFFTempo emprestado|r. Caso também conheça o talento, você receberá o grau mais alto conhecido."},
    {"^While at 3 stacks or more, your |cFFFFFFFFVoltaic Bite|r discharges Chain Lightning and increases its damage by (.-)%%%. Can stack up to (.-) times and lasts for (.-)%.\
\
Consuming at least 3 stacks grants |cFFFFFFFFThunder Hide|r max charges, if already active%.%s*$","Com 3 ou mais aplicações, sua |cFFFFFFFFMordida Voltaica|r dispara Cadeia de Raios e aumenta o dano dela em {{1}}%. Acumula até {{2}} vezes e dura {{3}}.\
\
Consumir pelo menos 3 aplicações concede o máximo de cargas de |cFFFFFFFFEsconderijo trovão|r, caso já esteja ativa."},
    {"^While affected by Avatar your chance to trigger Thunderburst is increased by (.-)%%, and its damage is increased by (.-)%%%. \
\
Thunderburst, Slam, Shield Slam, Execute, Chain Lightning, and Lightning Bolt hits grant you |cFFFFFFFFThunderlord|r%.%s*$","Enquanto estiver afetado por Avatar, sua chance de ativar Explosão Trovejante aumenta em {{1}}%, e o dano dela aumenta em {{2}}%.\
\
Os impactos de Explosão Trovejante, Impacto, Impacto com Escudo, Executar, Cadeia de Raios e Raio concedem a você |cFFFFFFFFSenhor do Trovão|r."},
    {"^|cFFFFFFFFHaunt|r %- Causes your target to take (.-)%% increased Shadow damage from you%.\
\
|cFFFFFFFFHand of Gul'dan|r %- Sends your Tamed Pet into a fury, increasing its damage and critical strike chance by (.-)%%%.\
\
|cFFFFFFFFConflagrate|r %- Increases the critical strike damage bonus of your Shadow and Fire spells by (.-)%%%.\
\
These effects last (.-)%.%s*$","|cFFFFFFFFAssombrar|r - Faz o alvo receber {{1}}% a mais de dano de Sombra causado por você.\
\
|cFFFFFFFFMão de Gul'dan|r - Faz seu ajudante domado entrar em fúria, aumentando em {{2}}% seu dano e sua chance de acerto crítico.\
\
|cFFFFFFFFConflagrar|r - Aumenta em {{3}}% o bônus de dano dos acertos críticos de seus feitiços de Sombra e Fogo.\
\
Esses efeitos duram {{4}}."},
    {"^|cFFFFFFFFHaunt|r %- Causes your target to take (.-)%% increased Shadow damage from you%.\
\
|cFFFFFFFFHand of Gul'dan|r %- Sends your Tamed Pet into a fury, increasing its damage and critical strike chance by (.-)%%%.\
\
|cFFFFFFFFConflagrate|r %- Increases the critical strike damage bonus of your Shadow and Fire spells by (.-)%%%.\
\
These effects last (.-)%.\
\
The critical strike damage bonus is increased by 10%% versus players%.%s*$","|cFFFFFFFFAssombrar|r - Faz o alvo receber {{1}}% a mais de dano de Sombra causado por você.\
\
|cFFFFFFFFMão de Gul'dan|r - Faz seu ajudante domado entrar em fúria, aumentando em {{2}}% seu dano e sua chance de acerto crítico.\
\
|cFFFFFFFFConflagrar|r - Aumenta em {{3}}% o bônus de dano dos acertos críticos de seus feitiços de Sombra e Fogo.\
\
Esses efeitos duram {{4}}.\
\
O bônus de dano de acerto crítico aumenta em 10% contra jogadores."},
    {"^|cFFFFFFFFHaunt|r %- Causes your target to take (.-)%% increased Shadow damage from you%.\
\
|cFFFFFFFFHand of Gul'dan|r %- Sends your Pet into a fury, increasing its damage and critical strike chance by (.-)%%%.\
\
|cFFFFFFFFConflagrate|r %- Increases the critical strike damage bonus of your Shadow and Fire spells by (.-)%%%.\
\
These last (.-)%.%s*$","|cFFFFFFFFAssombrar|r - Faz o alvo receber {{1}}% a mais de dano de Sombra causado por você.\
\
|cFFFFFFFFMão de Gul'dan|r - Faz seu ajudante entrar em fúria, aumentando em {{2}}% seu dano e sua chance de acerto crítico.\
\
|cFFFFFFFFConflagrar|r - Aumenta em {{3}}% o bônus de dano dos acertos críticos de seus feitiços de Sombra e Fogo.\
\
Esses efeitos duram {{4}}."},
    {"^Dealing damage with Thrash and Lacerate has a (.-)%% chance to grant you |cFFFFFFFFUrsine Frenzy|r%.\
\
This effect can only occur once every 10 seconds%.%s*$","Causar dano com Surra e Lacerar tem {{1}}% de chance de conceder |cFFFFFFFFFúria ursina|r.\
\
Este efeito só pode ocorrer uma vez a cada 10 segundos."},
    {"^Increases the damage of Arcane Shot against monsters and its critical strike chance by (.-)%%%.\
\
Casting Arcane Shot grants you |cFFFFFFFFArcane Infusion|r%.%s*$","aumenta o dano de Disparo Arcano contra monstros e sua chance de acerto crítico em {{1}}%.\
\
Lançar Disparo Arcano concede a você |cFFFFFFFFInfusão Arcana|r."},
    {"^Increases the damage dealt by your next |cFFFFFFFFSeed of Corruption|r by (.-)%%%. Stacks (.-) times and lasts for (.-)%.\
\
At 5 stacks, your next |cFFFFFFFFWave of Despair|r applies Despairing Affliction to all targets hit%.%s*$","aumenta o dano causado por sua próxima |cFFFFFFFFSemente da Corrupção|r em {{1}}%. Acumula {{2}} vezes e dura {{3}}.\
\
às 5 aplicações, sua próxima |cFFFFFFFFOnda de desesperação|r aplica Aflição Desesperadora a todos alvos atingidos."},
    {"^Increases the damage dealt by your next |cFFFFFFFFSeed of Corruption|r by (.-)%%%. Stacks (.-) times and lasts for (.-)%.\
\
At 5 stacks, your next |cFFFFFFFFWave of Despair|r applies Despairing Affliction to all targets hit%.\
\
Despairing Affliction scales with Unstable Affliction damage modifiers, but does not silence when dispelled%.%s*$","Aumenta em {{1}}% o dano causado por sua próxima |cFFFFFFFFSemente da Corrupção|r. Acumula até {{2}} vezes e dura {{3}}.\
\
Com 5 aplicações, sua próxima |cFFFFFFFFOnda de desesperação|r aplica Aflição Desesperadora a todos alvos atingidos.\
\
Aflição Desesperadora escala com os modificadores de dano de Agonia Instável, mas não silencia quando é dissipada."},
    {"^Phantom blades haunts the target while you remain within 8 yards, dealing (.-) Shadow damage every 3 seconds and reducing your Ghostly Strike's cooldown by (.-) second%.%s*$","As lâminas fantasmagóricas assombram o alvo enquanto permanecer a menos de 8 m, causando {{1}} de dano de Sombra cada 3 segundos e reduz a recarga de seu golpe fantasmagórico em {{2}} segundo."},
    {"^Hurls a holy buckler at the enemy, dealing (.-) to (.-) Holy damage%. It bounces off the enemy, landing on the ground, remaining there for 5 sec%. If you move over the buckler, you gain (.-) movement speed and take (.-)%% less damage for (.-)%. It also reduces its cooldown by 10 sec%.%s*$","Lança um broquel Sagrado ao inimigo, causando {{1}} de dano Sagrado a {{2}}. Rebota no inimigo, caindo no chão e permanecendo ali durante 5 seg. Se você se mover sobre o broquel, recebe {{3}} de velocidade de movimento e você recebe {{4}}% menos de dano durante {{5}}. Também reduz sua recarga em 10 seg."},
    {"^\
This improved Sinister Strike deals Spellstorm damage and grants you |cFFFFFFFFKnight of the Eclipse|r%.\
\
While |cFFFFFFFFEclipse %(Solar%)|r is active this ability grants you |cFFFFFFFFSolar Knight|r, increasing the damage of your next by |cFFFFFFFFWrath|r or |cFFFFFFFFStarsurge|r by (.-)%%%. Stacks up to 2%.\
\
While |cFFFFFFFFEclipse %(Lunar%)|r is active this ability grants you |cFFFFFFFFLunar Knight|r, increasing the damage of your next by |cFFFFFFFFStarfire|r or |cFFFFFFFFStarsurge|r by (.-)%%%. Stacks up to 2%.%s*$","\
Este Golpe Sinistro aprimorado causa dano de Tempestade Mágica e concede |cFFFFFFFFCavaleiro do Eclipse|r.\
\
Enquanto |cFFFFFFFFEclipse (Solar)|r estiver ativo, esta habilidade concede |cFFFFFFFFCavaleiro Solar|r, aumentando em {{1}}% o dano de sua próxima |cFFFFFFFFIra|r ou |cFFFFFFFFSurto Estelar|r. Acumula até 2 vezes.\
\
Enquanto |cFFFFFFFFEclipse (Lunar)|r estiver ativo, esta habilidade concede |cFFFFFFFFCavaleiro Lunar|r, aumentando em {{2}}% o dano de seu próximo |cFFFFFFFFFogo Estelar|r ou |cFFFFFFFFSurto Estelar|r. Acumula até 2 vezes."},
    {"^Devote to Gonk, increasing the damage of your summoned creatures by (.-)%%%.\
\
Abilities that |cffffffffInvoke Gonk|r have (.-)%% reduced cooldown, and (.-)%% increased effectiveness and grant |cffffffffAppeasement of Gonk|r%.\
\
Shares a 5 sec cooldown with other |cffffffffDevotions|r%.%s*$","Consagrado a Gonk, aumenta o dano de seus bichos invocadas em {{1}}%.\
\
Habilidades que |cffffffffInvocam a Gonk|r têm uma recarga reduzida em {{2}}%, e são mais efetivas em {{3}}% e concedem |cffffffffConciliação de Gonk|r.\
\
Compartilha uma 5 seg recarga com outras |cffffffffConsagrações|r."},
    {"^Reduces the mana cost of |cFFFFFFFFLichfrost|r and |cFFFFFFFFCrypt Swarm|r by (.-)%%%. |cFFFFFFFFBlight|r now refunds 25%% of its base mana cost if it lasts the full duration%.%s*$","Reduz em {{1}}% o custo de mana de |cFFFFFFFFGeada do Lich|r e |cFFFFFFFFEnxame da Cripta|r. |cFFFFFFFFPraga|r agora devolve 25% do custo de mana base caso dure por toda a duração."},
    {"^Reduces the mana cost of |cFFFFFFFFLichfrost|r and |cFFFFFFFFCrypt Swarm|r by (.-)%%%. |cFFFFFFFFBlight|r now refunds 50%% of its base mana cost if it lasts the full duration%.%s*$","Reduz em {{1}}% o custo de mana de |cFFFFFFFFGeada do Lich|r e |cFFFFFFFFEnxame da Cripta|r. |cFFFFFFFFPraga|r agora devolve 50% do custo básico de mana caso dure por toda a duração."},
    {"^Transforms the enemy creature into a frog%. While hexed, the target cannot attack or cast spells for (.-)%.%s*$","Transforma a criatura inimiga em uma rã. Enquanto estiver enfeitiçado, o alvo não pode atacar nem lançar feitiços durante {{1}}."},
    {"^Call upon a Silverwing Treant to aid you in combat%.%s*$","Evoca um Antárvore de Asa de Prata para ajudar você em combate."},
    {"^Summon a Furious Mama Bear to aid you in combat%.%s*$","Evoca uma Ursa-Mãe Furiosa para ajudar você em combate."},
    {"^Call upon the Echoes of Aessinna to aid you in combat%.%s*$","Invoca os Ecos de Aessinna para ajudar você em combate."},
    {"^Summons Glutton to follow you around%.\
\
If Glutton is already summoned, using this item will unsummon him%.%s*$","Evoca Glutton para seguir você.\
\
Se Glutton já estiver evocado, usar este item o dispensará."},
    {"^Summons Gorger to follow you around%.\
\
If Glutton is already summoned, using this item will unsummon him%.%s*$","Evoca Gorger para seguir você.\
\
Se Gorger já estiver evocado, usar este item o dispensará."},
    {"^Summons and dismisses your Ebony Spiteful Frog%.%s*$","Evoca e dispensa Ebony Spiteful Frog."},
    {"^Summons and dismisses your Cerulean Spiteful Frog%.%s*$","Evoca e dispensa Cerulean Spiteful Frog."},
    {"^Summons and dismisses your Lemon Spiteful Frog%.%s*$","Evoca e dispensa Lemon Spiteful Frog."},
    {"^Summons and dismisses your Verdant Spiteful Frog%.%s*$","Evoca e dispensa Verdant Spiteful Frog."},
    {"^Summons and dismisses your Amber Spiteful Frog%.%s*$","Evoca e dispensa Amber Spiteful Frog."},
    {"^Summons and dismisses your Crimson Spiteful Frog%.%s*$","Evoca e dispensa Crimson Spiteful Frog."},
    {"^Summons 1 |cffffffffSpectral Scythe|r for each |cff5ee2ffReaped Soul|r active which attack a nearby enemy for (.-)%. For the duration, damage dealt by |cffffffffSoul Strike|r is increased by (.-)%%%.\
\
Striking enemies with |cffffffffSoul Strike|r causes the |cFFFFFFFFSpectral Scythe|r to attack that enemy and 5 nearby enemies%. \
\
Consumes |cff5ee2ffReaped Souls|r and |cff5ee2ffSoul Infusion|r%.%s*$","Evoca 1 |cffffffffFoice Espectral|r para cada |cff5ee2ffAlma Ceifada|r ativa. Cada foice ataca um inimigo próximo durante {{1}}. Nesse período, o dano de |cffffffffGolpe da Alma|r aumenta em {{2}}%.\
\
Atingir inimigos com |cffffffffGolpe da Alma|r faz a |cFFFFFFFFFoice Espectral|r atacar esse inimigo e mais 5 inimigos próximos.\
\
Consome |cff5ee2ffAlmas Ceifadas|r e |cff5ee2ffInfusão de Alma|r."},
    {"^Summons 1 |cffffffffSpectral Scythe|r for each |cff5ee2ffReaped Soul|r active which attack a nearby enemy for (.-)%. For the duration, damage dealt by |cffffffffSoul Strike|r is increased by (.-)%%%.\
\
Striking enemies with |cffffffffSoul Strike|r causes the |cFFFFFFFFSpectral Scythe|r to attack that enemy and 5 nearby enemies%. \
\
Consumes |cff5ee2ffReaped Souls|r and |cff5ee2ffSoul Infusion|r%.\
\
Threat generated by the |cFFFFFFFFSpectral Scythe|r is redirected to the Reaper%.%s*$","Evoca 1 |cffffffffFoice Espectral|r para cada |cff5ee2ffAlma Ceifada|r ativa, atacando um inimigo próximo durante {{1}}. Durante esse tempo, o dano causado por |cffffffffGolpe da Alma|r aumenta em {{2}}%.\
\
Atingir inimigos com |cffffffffGolpe da Alma|r faz a |cFFFFFFFFFoice Espectral|r atacar esse inimigo e mais 5 inimigos próximos.\
\
Consome |cff5ee2ffAlmas Ceifadas|r e |cff5ee2ffInfusão de Alma|r.\
\
A ameaça gerada pela |cFFFFFFFFFoice Espectral|r é redirecionada para o Ceifador."},
    {"^Summons 1 |cffffffffSpectral Scythe|r for each |cffffffffReaped Soul|r active, which attack a nearby enemy for (.-)%. For the duration, damage dealt by |cffffffffSoul Strike|r is increased by (.-)%%%.\
\
Striking enemies with |cffffffffSoul Strike|r causes the |cFFFFFFFFSpectral Scythe|r to attack that enemy and 5 nearby enemies%. Damage dealt this way redirects the threat to you%.\
\
Consumes |cff5ee2ffReaped Souls|r and |cff5ee2ffSoul Infusion|r%.%s*$","Evoca 1 |cffffffffFoice Espectral|r para cada |cffffffffAlma Ceifada|r ativa. Cada foice ataca um inimigo próximo durante {{1}}. Nesse período, o dano de |cffffffffGolpe da Alma|r aumenta em {{2}}%.\
\
Atingir inimigos com |cffffffffGolpe da Alma|r faz a |cFFFFFFFFFoice Espectral|r atacar esse inimigo e mais 5 inimigos próximos. O dano causado dessa forma redireciona a ameaça para você.\
\
Consome |cff5ee2ffAlmas Ceifadas|r e |cff5ee2ffInfusão de Alma|r."},
    {"^Strike up to (.-) enemies within (.-) yds for (.-)%% Weapon Damage plus (.-) and mark them for (.-)%.\
\
Using |cFFFFFFFFEntropic Slam|r on a marked enemy consumes the mark to deal (.-)%% increased damage%.\
\
Generates 15 |cffffffffInsanity|r and 2 |cffffffffVoid Runes|r%.%s*$","Atinge até {{1}} inimigos dentro de {{2}} m por {{3}}% dano de Arma mais {{4}} e marca os inimigos para {{5}}.\
\
Utilizar |cFFFFFFFFAplastamento Entropico|r sobre um inimigo marcado consome a marca para causar dano aumentado em {{6}}%.\
\
Gera 15 |cffffffffDemência|r e 2 |cffffffffRuna do vazio|r."},
    {"^Summons a |cffffffffTentacle of N'Zoth|r at the target location for (.-) that will attack nearby enemies, and reduces their movement speed by (.-)%%%.\
\
Generates 10 |cffcfa6ffInsanity|r%.\
\
|cffffffffHerald of N'Zoth|r: Has (.-)%% reduced cooldown%.%s*$","Evoca um |cffffffffTentáculo de N'Zoth|r no local selecionado durante {{1}}. Ele ataca os inimigos próximos e reduz em {{2}}% a velocidade de movimento deles.\
\
Gera 10 de |cffcfa6ffDemência|r.\
\
|cffffffffArauto de N'Zoth|r: reduz em {{3}}% a recarga."},
    {"^Increases all damage dealt by party and raid members by (.-)%%%. Does not stack with similar effects%.\
\
In addition, increases the damage of |cffffffffCorpse Explosion|r by (.-)%%%.%s*$","aumenta todo o dano causado por os membros do grupo e da banda em {{1}}%. Não acumula com efeitos semelhantes.\
\
Além disso, aumenta o dano de |cffffffffExplosão de Cadáver|r em {{2}}%."},
    {"^Reduces the cooldowns of |cffffffffCommand: Abomination|r, |cffffffffCommand: Ghouls|r, |cffffffffCommand: Putrid Geists|r and |cffffffffCommand: Unholy Colossus|r by (.-)%%%.%s*$","Reduz em {{1}}% a recarga de |cffffffffComando: Abominação|r, |cffffffffComando: Carniçais|r, |cffffffffComando: Geists Pútridos|r e |cffffffffComando: Colosso Profano|r."},
    {"^Animate (.-) |cffffffffZombies|r to aid you in combat for (.-)%.\
\
Every (.-) sec, |cffffffffZombies|r emit |cffffffffZombie Plague|r, dealing (.-) Plague Damage to nearby enemies%.%s*$","Anima {{1}} |cffffffffZumbis|r para ajudar você em combate durante {{2}}.\
\
A cada {{3}} s, os |cffffffffZumbis|r emitem |cffffffffPeste Zumbi|r, causando {{4}} de dano de Peste aos inimigos próximos."},
    {"^Transform enemies at target location into a frog, making them unable to attack or cast spells, and slowing their movement speed by (.-)%% for (.-)%. %(8 sec vs players%)\
\
Damage dealt may interrupt this effect%.%s*$","Transforma os inimigos no local selecionado em rãs, impedindo-os de atacar ou lançar feitiços e reduzindo em {{1}}% a velocidade de movimento deles durante {{2}} (8 s contra jogadores).\
\
O dano causado pode interromper o efeito."},
    {"^Raise a |cffffffffBanshee|r to aid you in combat, occupying 2 |cffffffffLife Force|r%.\
\
It will channel on your target, dealing damage and draining their mana over time%.\
\
|cff90ee90Command|r: Drains (.-)%% of your target's mana %(up to a maximum of (.-)%% of their own maximum mana%) and deals Frost damage equal to the mana drained%.%s*$","Anima uma |cffffffffBanshee|r para ajudar você em combate, ocupando 2 pontos de |cffffffffForça Vital|r.\
\
Ela canaliza no alvo, causando dano e drenando mana ao longo do tempo.\
\
|cff90ee90Comando|r: drena {{1}}% da mana do alvo (até o máximo de {{2}}% da mana máxima dele) e causa dano de Gelo igual à mana drenada."},
    {"^Transform enemies at target location into a frog, making them unable to attack or cast spells, and slowing their movement speed by (.-)%% for (.-)%. %(8 sec vs players%)\
\
Damage dealt may interrupt this effect%. \
\
While transformed into a frog the enemy is considered a Beast%.%s*$","Transforma os inimigos no local selecionado em rãs, impedindo-os de atacar ou lançar feitiços e reduzindo em {{1}}% a velocidade de movimento deles durante {{2}} (8 s contra jogadores).\
\
O dano causado pode interromper o efeito.\
\
Enquanto estiverem transformados em rãs, os inimigos serão considerados Feras."},
    {"^Drop a |cffffffffHexing Effigy|r near you for (.-)%.\
\
The next enemy that casts a spell on you is transformed into a frog for (.-)%. \
\
While transformed, they are unable to move, attack or cast spells%. Damage dealt may interrupt this effect%.%s*$","Coloca uma |cffffffffEfígie Enfeitiçadora|r perto de você durante {{1}}.\
\
O próximo inimigo em quem você lançar um feitiço será transformado em rã durante {{2}}.\
\
Enquanto estiver transformado, não poderá se mover, atacar nem lançar feitiços. O dano causado pode interromper o efeito."},
    {"^Drop a |cffffffffHexing Effigy|r near you for (.-)%.\
\
The next enemy that casts a spell on you is transformed into a frog for (.-)%. \
\
While transformed, they are unable to move, attack or cast spells%. Damage dealt may interrupt this effect%.\
\
Can only have 1 |cffffffffEffigy|r active at a time%.%s*$","Coloca uma |cffffffffEfígie Enfeitiçadora|r perto de você durante {{1}}.\
\
O próximo inimigo que lançar um feitiço em você será transformado em rã durante {{2}}.\
\
Enquanto estiver transformado, não poderá se mover, atacar nem lançar feitiços. O dano causado pode interromper este efeito.\
\
Só pode haver 1 |cffffffffEfígie|r ativa por vez."},
    {"^|cffffffffRunic Tattoos|r now increases your mana regeneration by (.-)%%%.\
\
Arcane and Fire Damage dealt now has a (.-)%% chance to unleash the damage from |cffffffffRunic Tattoos|r%.%s*$","|cffffffffTatuagens Rúnicos|r agora aumentam em {{1}}% sua regeneração de mana.\
\
O dano Arcano e de Fogo causado agora tem {{2}}% de chance de liberar o dano de |cffffffffTatuagens Rúnicos|r."},
    {"^|cff32cd32Consumes 2 Felfury|r\
Blast an enemy and all enemies near them with fel magic, dealing (.-) Shadowflame Damage%.\
\
|cff32cd32Inner Demon|r: Striking at least 5 enemies with this spell causes it to deal an additional (.-) Shadowflame Damage over (.-), stacking (.-) times%.%s*$","|cff32cd32Consome 2 de Fúria Vil|r\
Atinge um inimigo e todos inimigos próximos com magia vil, causando {{1}} de dano de Chama Sombria.\
\
|cff32cd32Demônio Interior|r: Atingir pelo menos 5 inimigos com este feitiço faz com que ele cause mais {{2}} de dano de Chama Sombria durante {{3}}, acumulando até {{4}} vezes."},
    {"^Summon a |cffffffffGreater Imp|r to aid you in combat%.\
\
|cffffffffGreater Imp|r has various combat abilities that provide excellent single target damage and control%.%s*$","Evoca um |cffffffffDiabrete (Versão Maior)|r para ajudar você em combate.\
\
O |cffffffffDiabrete (Versão Maior)|r possui várias habilidades de combate que oferecem excelente dano contra um único alvo e controle."},
    {"^Transforms the enemy into a frog%. While hexed, the target cannot attack or cast spells%. Damage caused may interrupt the effect%. Lasts (.-)%. \
\
Only one target can be hexed at a time%.  Only works on Humanoids and Beasts%.%s*$","Transforma o inimigo em rã. Enquanto estiver enfeitiçado, o alvo não pode atacar nem lançar feitiços. O dano pode interromper o efeito. Dura {{1}}. Apenas um alvo pode ser enfeitiçado por vez. Funciona somente contra Humanoides e Feras."},
    {"^Intellect and spell haste increased by (.-)%%%.\
\
Only 1 |cffffffffLesser Boon|r may be active on an ally at a time%.%s*$","O Intelecto e a aceleração de feitiços aumentam em {{1}}%.\
\
Apenas uma |cffffffffDádiva Menor|r pode permanecer ativa em um aliado por vez."},
    {"^Critical strike chance increased by (.-)%%%. Resource costs reduced by (.-)%%%.\
\
Healing for (.-)%% maximum health every (.-) sec%.\
\
Only 1 |cffffffffLesser Boon|r may be active on an ally at a time%.%s*$","A chance de acerto crítico aumenta em {{1}}%, os custos de recursos são reduzidos em {{2}}% e você recupera {{3}}% da vida máxima a cada {{4}} s.\
\
Apenas uma |cffffffffDádiva Menor|r pode permanecer ativa em um aliado por vez."},
    {"^Melee and ranged attack power increased by (.-)%%%.\
\
Only 1 |cffffffffLesser Boon|r may be active on an ally at a time%.%s*$","O poder de ataque corpo a corpo e à distância aumenta em {{1}}%.\
\
Apenas uma |cffffffffDádiva Menor|r pode permanecer ativa em um aliado por vez."},
    {"^Summon a Lesser Treant Protector to aid you in combat for (.-)%.%s*$","Evoca um Protetor Antárvore Menor para ajudar você em combate durante {{1}}."},
    {"^Heals you for an equal amount of the damage dealt by |cfffffffMurder|r%.%s*$","Cura você em um valor igual ao dano causado por |cffffffffAssassinato|r."},
    {"^Each |cffffffffUndead Stance|r now provides an additional bonus:\
\
|cFFFFFFFFUndead: Assault|r: Increases your critical strike chance against Humanoids by (.-)%%%.\
\
|cFFFFFFFFUndead: Protect|r: Reduces your threat generated by (.-)%%%.\
\
|cFFFFFFFFUndead: Pacify|r: Reduces your damage taken by (.-)%%%.%s*$","Cada |cffffffffPostura de Morto-Vivo|r agora concede um bônus adicional:\
\
|cFFFFFFFFmorto-vivo: Ataque|r: aumenta em {{1}}% sua chance de acerto crítico contra Humanoides.\
\
|cFFFFFFFFmorto-vivo: Proteção|r: reduz em {{2}}% a ameaça gerada.\
\
|cFFFFFFFFmorto-vivo: Acalmar|r: reduz em {{3}}% o dano recebido."},
    {"^Your next |cFFFFFFFFGaze of C'thun|r, |cFFFFFFFFDarkwither|r or |cFFFFFFFFWrath of the Black Empire|r will be empowered%.\
\
|cFFFFFFFFGaze of C'thun:|r Critical strike chance increased by (.-)%%%.\
\
|cFFFFFFFFDarkwither:|r Shadow damage dealt increased by (.-)%% and damage of |cFFFFFFFFDarkwither|r by an additional (.-)%% for (.-)%.\
\
|cFFFFFFFFWrath of the Black Empire:|r Deals (.-)%% increased damage%.%s*$","Seu próximo |cFFFFFFFFOlhar de C'Thun|r, |cFFFFFFFFDefinhamento Sombrio|r ou |cFFFFFFFFIra do Império Negro|r será fortalecido.\
\
|cFFFFFFFFOlhar de C'Thun:|r aumenta em {{1}}% a chance de acerto crítico.\
\
|cFFFFFFFFDefinhamento Sombrio:|r aumenta em {{2}}% o dano de Sombra causado e em mais {{3}}% o dano de |cFFFFFFFFDefinhamento Sombrio|r durante {{4}}.\
\
|cFFFFFFFFIra do Império Negro:|r causa {{5}}% a mais de dano."},
    {"^When |cffffffffHateforged Barrier|r is removed from you, you now reduce (.-)%% of all Magic Damage taken for 8 sec%.\
\
In addition, |cFFFFFFFFHateforged Barrier|r now heals for an additional (.-)%% of your maximum health each tick%.%s*$","Quando |cffffffffBarreira forjada com ódio|r for removida de você, o dano mágico recebido será reduzido em {{1}}% durante 8 s.\
\
Além disso, |cFFFFFFFFBarreira forjada com ódio|r agora cura mais {{2}}% da sua vida máxima a cada pulso."},
    {"^While wielding a Two%-Handed Weapon, the chance to trigger |cFFFFFFFFWild Carnage|r is increased by (.-)%%%.\
\
Requires the |cffffffffWild Carnage|r talent%.%s*$","Enquanto empunhar uma arma de duas mãos, a chance de ativar |cFFFFFFFFCarne Assassina (Versão Selvagem)|r aumenta em {{1}}%.\
\
Requer o talento |cffffffffCarne Assassina (Versão Selvagem)|r."},
    {"^Embrace your demonic curse for (.-), entering an improved |cffa966f0Cursed Form|r, increasing your attack power by (.-)%% of your Agility and causing your melee attacks to reduce all healing done to the target by (.-)%% for (.-), stacking (.-) times%.\
\
While in a |cffa966f0Cursed Form|r you are treated as if you were a Demon, and you are protected from Polymorph spells%. This ability goes on cooldown upon returning to |cFFFFFFFFMortal Form|r%.%s*$","Abraça sua maldição demoníaca durante {{1}}, assumindo uma |cffa966f0Forma Amaldiçoada|r aprimorada. A forma aumenta seu poder de ataque em {{2}}% da Agilidade e faz seus ataques corpo a corpo reduzirem em {{3}}% toda a cura realizada no alvo durante {{4}}, acumulando até {{5}} vezes.\
\
Enquanto estiver em |cffa966f0Forma Amaldiçoada|r, você será considerado um Demônio e ficará protegido contra feitiços de Polimorfia. Esta habilidade entra em recarga ao retornar à |cFFFFFFFFForma Mortal|r."},
    {"^Ascend into a |cffa966f0Cursed Form|r for (.-), enabling the use of unique abilities, causing you to generate health and Rage over time%. This ability goes on cooldown upon returning to |cFFFFFFFFMortal Form|r%.\
\
While in a |cffa966f0Cursed Form|r you are treated as if you were a Demon%.%s*$","Ascende a uma |cffa966f0Forma Amaldiçoada|r durante {{1}}, permitindo o uso de habilidades únicas e gerando Vida e Fúria ao longo do tempo. Esta habilidade entra em recarga ao retornar à |cFFFFFFFFForma Mortal|r.\
\
Enquanto estiver em |cffa966f0Forma Amaldiçoada|r, você será considerado um Demônio."},
    {"^Reduces the cooldown of |cffffffffChill of the Grave|r by (.-) sec and increases the duration of |cFFFFFFFFWinds of Northrend|r by (.-)%%%.%s*$","Reduz em {{1}} s a recarga de |cffffffffCalafrio da Tumba|r e aumenta em {{2}}% a duração de |cFFFFFFFFVentos de Nortúndria|r."},
    {"^|cFFFFFFFFVoid Shield|r now applies to an additional nearby ally but its duration is reduced by (.-)%%%.\
\
Killing an opponent that yields experience or honor removes |cFFFFFFFFWracked Mind|r from you%.%s*$","|cFFFFFFFFEscudo de vazio|r agora também é aplicado a mais um aliado próximo, mas sua duração é reduzida em {{1}}%.\
\
Matar um oponente que conceda experiência ou honra remove |cFFFFFFFFMente desgarrada|r de você."},
    {"^Marked for (.-)%. Damage taken from |cffffffffWand of Time|r is increased by (.-)%%%.\
\
You may consume this debuff with |cffffffffWand of Time|r to gain an additional effect based on your active |cFFC49A6CContinuum Spell|r%.\
\
|cFFFFFFFFSingularity Core|r: Triggers 3 instances of |cFFFFFFFFSingularity Core|r damage%.\
\
|cFFFFFFFFFlux Emitter|r: Explodes on the enemy, dealing 50%% of the damage dealt to all enemies within 8 yds%.\
\
|cFFFFFFFFParadox Cannon|r: Increases the damage of your next |cFFFFFFFFShatter Echo|r within 6 sec by 25%%%.%s*$","Marca o alvo durante {{1}}. O dano recebido de |cffffffffVarinha do Tempo|r aumenta em {{2}}%.\
\
Você pode consumir este efeito negativo com |cffffffffVarinha do Tempo|r para receber um efeito adicional baseado no |cFFC49A6CFeitiço do Contínuo|r ativo.\
\
|cFFFFFFFFNúcleo Singular|r: ativa 3 ocorrências do dano de |cFFFFFFFFNúcleo Singular|r.\
\
|cFFFFFFFFEmissor de Fluxo|r: explode no inimigo, causando a todos os inimigos em um raio de 8 m 50% do dano causado.\
\
|cFFFFFFFFCanhão Paradoxal|r: aumenta em 25% o dano de seu próximo |cFFFFFFFFEstilhaçar Eco|r usado em até 6 s."},
    {"^Reduces Magic damage taken by party and raid members by (.-)%%%.\
\
Does not stack with similar effects%.\
\
Additionally, allows |cFFFFFFFFGhastly Form|r to trigger from successfully interrupting an enemy with |cFFFFFFFFWithering Touch|r and |cFFFFFFFFGhastly Screech|r%.%s*$","Reduz em {{1}}% o dano mágico recebido pelos membros do grupo e da raide.\
\
Não acumula com efeitos semelhantes.\
\
Além disso, permite ativar |cFFFFFFFFForma Atroz|r ao interromper um inimigo com sucesso usando |cFFFFFFFFToque Murcho|r ou |cFFFFFFFFGuincho Sinistro|r."},
    {"^Animate a bloody amalgam to aid you in combat for (.-)%. \
\
The amalgam will periodically unleash a |cffffffffBlood Strike|r on its target, dealing (.-) Shadow damage, healing you for (.-)%% of the damage dealt%.\
\
|cFFE53935Empowered|r: Duration increased by (.-) sec and you summon 1 additional amalgam%. \
\
Duration increased by (.-) sec per stack of |cFFFFFFFFThirst|r%.%s*$","Anima um Amálgama Sanguíneo para ajudar você em combate durante {{1}}.\
\
O amálgama desfere periodicamente um |cffffffffGolpe Sangrento|r no alvo, causando {{2}} de dano de Sombra e curando você em {{3}}% do dano causado.\
\
|cFFE53935Potencializado|r: A duração aumenta em {{4}} s e você evoca mais 1 amálgama.\
\
A duração aumenta em {{5}} s por aplicação de |cFFFFFFFF/sede|r."},
    {"^Animate a bloody amalgam to aid you in combat for (.-)%. \
\
The amalgam will periodically unleash a |cffffffffBlood Strike|r on its target, dealing (.-) Shadow damage, healing you for (.-)%% of the damage dealt%.\
\
|cFFE53935Empowered|r: Duration increased by (.-) sec and you summon 1 additional amalgam%.%s*$","Anima um Amálgama Sanguíneo para ajudar você em combate durante {{1}}.\
\
O amálgama desfere periodicamente um |cffffffffGolpe Sangrento|r no alvo, causando {{2}} de dano de Sombra e curando você em {{3}}% do dano causado.\
\
|cFFE53935Potencializado|r: A duração aumenta em {{4}} s e você evoca mais 1 amálgama."},
    {"^Animate a bloody amalgam to aid you in combat for (.-)%. \
\
The amalgam will periodically unleash a |cffffffffBlood Strike|r on its target, dealing (.-) Shadow damage, healing you for (.-)%% of the damage dealt%. \
\
Duration increased by (.-) sec per stack of |cFFFFFFFFThirst|r%.%s*$","Anima um Amálgama Sanguíneo para ajudar você em combate durante {{1}}.\
\
O amálgama desfere periodicamente um |cffffffffGolpe Sangrento|r no alvo, causando {{2}} de dano de Sombra e curando você em {{3}}% do dano causado.\
\
A duração aumenta em {{4}} s por aplicação de |cFFFFFFFF/sede|r."},
    {"^Animate a bloody amalgam to aid you in combat for (.-)%. \
\
The amalgam will periodically unleash a |cffffffffBlood Strike|r on its target, dealing (.-) Shadow damage, healing you for (.-)%% of the damage dealt%.%s*$","Anima um Amálgama Sanguíneo para ajudar você em combate durante {{1}}.\
\
O amálgama desfere periodicamente um |cffffffffGolpe Sangrento|r no alvo, causando {{2}} de dano de Sombra e curando você em {{3}}% do dano causado."},
    {"^Summon an Outrunner to assist you in combat for (.-)%.%s*$","Evoca um Explorador para ajudar você em combate durante {{1}}."},
    {"^Transforms the enemy into a frog%. While hexed, the target cannot attack or cast spells%. Damage caused removes the effect%.%s*$","Transforma o inimigo em rã. Enquanto estiver enfeitiçado, o alvo não pode atacar nem lançar feitiços. Qualquer dano remove o efeito."},
    {"^Increases your Magic damage dealt by (.-)%% and |cFFFFFFFFHammer of Twilight|r now increases the target's spell damage taken by (.-)%% for (.-)%.%s*$","Aumenta em {{1}}% o dano mágico causado, e |cFFFFFFFFMartelo do Crepúsculo|r agora aumenta em {{2}}% o dano mágico recebido pelo alvo durante {{3}}."},
    {"^Damage dealt by |cffffffffDusk Blade|r now has a (.-)%% chance to reduce the mana cost of your next |cffffffffPurifier's Edge|r by (.-)%%%. This effect has a 25%% chance to not be consumed by |cffffffffPurifier's Edge|r%.%s*$","O dano de |cffffffffLâmina do Crepúsculo|r agora tem {{1}}% de chance de reduzir em {{2}}% o custo de mana de sua próxima |cffffffffBorda do Purificador|r. Há 25% de chance de o efeito não ser consumido por |cffffffffBorda do Purificador|r."},
    {"^Increases your block value by (.-)%%%.\
\
While above 60 |cffcfa6ffInsanity|r, the value of this effect is doubled%.%s*$","aumenta sua valor de bloqueio em {{1}}%.\
\
Enquanto tiver mais de 60 |cffcfa6ffDemência|r, o valor deste efeito se duplica."},
    {"^Increases the critical strike chance of abilities that require |cffa966f0Cursed Form|r on enemies above 75%% or below 35%% health by (.-)%%%.\
\
In addition, melee critical strikes now have a (.-)%% chance to make your next |cFFFFFFFFDark Liturgy|r or |cFFFFFFFFBloodmoon Blast|r instant cast%.%s*$","Aumenta em {{1}}% a chance de acerto crítico das habilidades que requerem |cffa966f0Forma Amaldiçoada|r contra inimigos com mais de 75% ou menos de 35% de vida.\
\
Além disso, acertos críticos corpo a corpo têm {{2}}% de chance de tornar instantâneo seu próximo |cFFFFFFFFLiturgia sombria|r ou |cFFFFFFFFExplosão da Lua de Sangue|r."},
    {"^Spells that cost health now grant a stack of |cFFE53935Pooled Vitality|r, stacking (.-) times, for (.-)%.\
\
Each stack of |cFFE53935Pooled Vitality|r increases your Spirit by (.-)%%%.\
\
Healing spells that cost Rage consume 10 stacks of |cFFE53935Pooled Vitality|r to become empowered%.%s*$","Feitiços que custam vida agora concedem uma aplicação de |cFFE53935Vitalidade Acumulada|r, que acumula até {{1}} vezes durante {{2}}.\
\
Cada aplicação aumenta em {{3}}% seu Espírito. Feitiços de cura que custam Fúria consomem 10 aplicações para serem fortalecidos."},
    {"^Enter a unique |cffa966f0Cursed Form|r that does not disable |cffffffffMortal Form|r abilties, coalescing a blood orb that will float beside you%.\
\
While active, you replicate (.-)%% of healing or damage done by |cFFFFFFFFSanguine Mend|r and |cffffffffBloodmoon Blast|r on the target every (.-) sec for (.-)%.\
\
While in a |cffa966f0Cursed Form|r you are treated as if you were a Demon%.%s*$","Assume uma |cffa966f0Forma Amaldiçoada|r única que não desativa as habilidades da |cffffffffForma Mortal|r, formando um orbe de sangue que flutua ao seu lado.\
\
Enquanto estiver ativa, replica no alvo, a cada {{2}} s durante {{3}}, {{1}}% da cura ou do dano realizado por |cFFFFFFFFCura Sanguínea|r e |cffffffffExplosão da Lua de Sangue|r.\
\
Enquanto estiver em uma |cffa966f0Forma Amaldiçoada|r, você será considerado um Demônio."},
    {"^Teaches you the ability to summon: Imp, Voidwalker, Felhunter, Succubus to command by your side%. Voidwalker, Felhunter and Succubus require Drain Soul or Shadowburn to summon%.%s*$","Ensina a evocar Diabrete, Emissário do Caos, Caçador Vil e Súcubo para acompanhar você. Emissário do Caos, Caçador Vil e Súcubo exigem Drenar Alma ou Queimadura Sombria para serem evocados."},
    {"^Tether yourself to an ally for (.-), increasing all damage they deal and reducing all damage they take by (.-)%%%.\
\
Every (.-) sec while active, you trigger a |cFFFFFFFFHorrific Revelation|r on the target and generate 5 |cffcfa6ffInsanity|r%.%s*$","Vincula você a um aliado durante {{1}}, aumentando em {{2}}% todo o dano causado por ele e reduzindo em {{2}}% todo o dano recebido.\
\
A cada {{3}} s enquanto estiver ativo, você provoca uma |cFFFFFFFFRevelação horripilante|r no alvo e gera 5 de |cffcfa6ffDemência|r."},
    {"^Augments |cffffffffSpider Form|r into a |cffffffffBrood Lord|r, causing your |cff66ff66Brood Mark|r spenders to launch webs at the target, sticking to them for (.-)%.\
\
Each webbed target has their movement speed slowed by (.-)%%%.\
\
Critically striking an enemy who is webbed summons (.-) |cffffffffSpiderlings|r to aid you in combat for (.-)%.%s*$","Transforma a |cffffffffForma de Aranha|r em |cffffffffSenhor do Ninho|r, fazendo suas habilidades que consomem |cff66ff66Marca da Prole|r lançarem teias no alvo durante {{1}}.\
\
Cada alvo coberto por teias tem a velocidade de movimento reduzida em {{2}}%. Causar um acerto crítico em um inimigo coberto por teias evoca {{3}} |cffffffffAranhotes|r para ajudar você em combate durante {{4}}."},
    {"^At (.-) stacks, your next |cffffffffGaze of C'Thun|r will pull targets to you, and deal (.-) additional Shadow Damage if they're an enemy%.%s*$","Com {{1}} aplicações, seu próximo |cffffffffOlhar de C'Thun|r puxará os alvos até você e causará {{2}} de dano de Sombra adicional caso sejam inimigos."},
    {"^Call a service bot to deliver ice cold brews for you and your companions! Lasts (.-)%s*$","Chama um robô de serviço para trazer bebidas geladas a você e aos seus companheiros. Dura {{1}}."},
    {"^Attune yourself with water, restoring (.-) mana every 5 seconds and reduces the mana cost of your spells and abilities by (.-)%% and increases the mana restored through |cffffffffLeystone Springs|r by (.-)%%%.\
\
While active, |cffffffffPrimordial Blast|r restores (.-)%% of your maximum mana on cast%.%s*$","Sintoniza você com a água, restaurando {{1}} de mana a cada 5 s, reduzindo em {{2}}% o custo de mana de seus feitiços e habilidades e aumentando em {{3}}% a mana restaurada por |cffffffffFonte de Pedra Limite|r.\
\
Enquanto estiver ativo, |cffffffffExplosão Primal|r restaura {{4}}% da mana máxima ao ser lançada."},
    {"^Attune yourself with water, restoring (.-) mana every 5 seconds and reduces the mana cost of your spells and abilities by (.-)%%%.\
\
While active, |cffffffffPrimordial Blast|r restores (.-)%% of your maximum mana on cast%.%s*$","Sintoniza você com a água, restaurando {{1}} de mana a cada 5 s e reduzindo em {{2}}% o custo de mana de seus feitiços e habilidades.\
\
Enquanto estiver ativo, |cffffffffExplosão Primal|r restaura {{3}}% da mana máxima ao ser lançada."},
    {"^If your Potion has at least 2 |cffffffffBloodthistle|r and 1 |cffffffffFrog Venom|r, reduce the target's magical resistances by (.-) for (.-)%.%s*$","Se sua poção tiver pelo menos 2 |cffffffffCardo-sangue|r e 1 |cffffffffVeneno de Rã|r, reduz as resistências mágicas do alvo em {{1}} durante {{2}}."},
    {"^If your Potion has at least 1 |cffffffffFrog Venom|r, 1 |cffffffffBloodthistle|r and 1 |cffffffffJungle Shrooms|r, increase the target's movement speed by (.-)%% and damage by (.-)%% for (.-)%.%s*$","Caso sua Poção tenha pelo menos 1 |cffffffffVeneno de Rã|r, 1 |cffffffffCardo-sangue|r e 1 |cffffffffCogumelos da Selva|r, aumenta em {{1}}% a velocidade de movimento do alvo e em {{2}}% o dano dele durante {{3}}."},
    {"^You |cfffeff9eSummon|r a Claw Bot to assist you in combat%.\
\
The Claw Bot is capable of tanking enemies, but requires other abilities that command it to unleash its full potential%. It also generates increased Threat and takes (.-)%% increased healing from the Repair spell%.\
\
This pet gains Health based on your Intellect and Stamina, and Attack Power based on your Intellect and Ranged Attack Power%.%s*$","|cfffeff9eEvocar|r um Claw Bot para ajudar você em combate.\
\
O Claw Bot pode atuar como tanque, mas exige outras habilidades para liberar todo o seu potencial. Ele também gera mais ameaça e recebe {{1}}% a mais de cura de Reparar.\
\
Este mascote recebe vida conforme seu Intelecto e Vigor, e poder de ataque conforme seu Intelecto e poder de ataque à distância."},
    {"^You twist the soul of your Shackled Husk, consuming 10%% of its Maximum Health to assault an enemy target with a terrible scream, dealing (.-) Shadow Damage%.%s*$","Retorce a alma de sua Casca Acorrentada, consumindo 10% da vida máxima dela para atacar um alvo inimigo com um grito terrível, causando {{1}} de dano de Sombra."},
    {"^Empowers your next spell within (.-)%.\
\
|cffffffffIllumination|r: (.-)%% increased critical strike chance%.\
\
|cffffffffShine|r: Heals for (.-)%% more%.\
\
|cffffffffSunshine|r: Increases Armor and magic resistance based on Intellect for (.-)%.%s*$","Fortalece seu próximo feitiço usado em até {{1}}.\
\
|cffffffffIluminação|r: Aumenta em {{2}}% a chance de acerto crítico.\
\
|cffffffffBrilho|r: Cura {{3}}% a mais.\
\
|cffffffffLuz do Sol|r: Aumenta a armadura e a resistência mágica conforme o Intelecto durante {{4}}."},
    {"^Thicken the air around you, slowing the movement speed of enemies by (.-)%% and reducing their casting speed by (.-)%%%.\
\
Only 1 |cffffffffPressure|r spell can be active at a time%.%.%s*$","Adensa o ar ao seu redor, reduzindo em {{1}}% a velocidade de movimento dos inimigos e em {{2}}% a velocidade de lançamento deles.\
\
Só pode haver 1 feitiço de |cffffffffPressão|r ativo por vez."},
    {"^Embolden the air around you, increasing the duration of movement impairing, fear, and horrify effects on enemies by (.-)%%%. \
\
Only 1 |cffffffffPressure|r spell can be active at a time%.%.%s*$","Aumenta em {{1}}% a duração dos efeitos de imobilização, Medo e Horror nos inimigos.\
\
Apenas um feitiço de |cffffffffPressão|r pode permanecer ativo por vez."},
    {"^You summon a Skeletal Warrior to assist you in combat%. Consumes 1 Life Force while active%. Life Force is returned to you when this minion dies%.%s*$","Evoca um Guerreiro Esquelético para ajudar você em combate. Consome 1 de Força Vital enquanto estiver ativo. A Força Vital é devolvida quando o lacaio morre."},
    {"^You summon a Skeletal Warrior to assist you in combat%. Consumes 5 Life Force while active%. Life Force is returned to you when this minion dies%.%s*$","Evoca um Guerreiro Esquelético para ajudar você em combate. Consome 5 de Força Vital enquanto estiver ativo. A Força Vital é devolvida quando o lacaio morre."},
    {"^You summon a Skeletal Warrior to assist you in combat%. Consumes 2 Life Force while active%. Life Force is returned to you when this minion dies%.%s*$","Evoca um Guerreiro Esquelético para ajudar você em combate. Consome 2 de Força Vital enquanto estiver ativo. A Força Vital é devolvida quando o lacaio morre."},
    {"^You summon a Skeletal Horror to assist you in combat%. Consumes 5 Life Force while active%. Life Force is returned to you when this minion dies%.%s*$","Evoca um Horror Esquelético para ajudar você em combate. Consome 5 de Força Vital enquanto estiver ativo. A Força Vital é devolvida quando o lacaio morre."},
    {"^Your dual scythes fracture a Soul Fragment from the target%.%s*$","Suas foices duplas fraturam um Fragmento de Alma do alvo."},
    {"^Empowers an ally for (.-), reducing all damage they take by (.-)%% and increasing all healing they take by (.-)%%%. Grants |cff66ccffMotivation|r to all nearby allies%.\
\
Applies |cffffffffConfidence|r to the target for (.-)%.%s*$","Fortalece um aliado durante {{1}}, reduzindo em {{2}}% todo o dano recebido por ele e aumentando em {{3}}% toda a cura recebida. Concede |cff66ccffMotivação|r a todos aliados próximos.\
\
Aplica |cffffffffConfiança|r ao alvo durante {{4}}."},
    {"^Your |cffffffffPotion Toss|r and |cffffffffSplash Potion|r within (.-) now apply |cffffffffBlood Frog|r to affected allies%.\
\
Instantly swaps your |cffffffffIngredients|r to |cffffffffBloodthistle|r and |cffffffffFrog Bones|r%.%s*$","Seu |cffffffffArremesso de Poção|r e sua |cffffffffPoção de Salpico|r usados dentro de {{1}} agora aplicam |cffffffffCardo Sangrento|r aos aliados afetados.\
\
Substitui instantaneamente seus |cffffffffIngredientes|r por |cffffffffCardo-sangue|r e |cffffffffOssos de Rã|r."},
    {"^Brews (.-) |cFFFFFFFFFrog Fondue|r providing the Witch Doctor and their allies with something to eat%.\
\
Brewed items disappear if logged out for more than 15 minutes%.%s*$","Prepara {{1}} |cFFFFFFFFFondue de Rã|r, fornecendo alimento ao Mandingueiro e aos aliados.\
\
Os itens preparados desaparecem se você permanecer desconectado por mais de 15 minutos."},
    {"^Increases the critical strike chance of |cFFFFFFFFBlaze|r and |cFFFFFFFFIgnite|r by (.-)%% and increases their tick rate by (.-)%% and reduces their durations by (.-)%%%.\
\
Periodic critical strikes apply |cFFFFFFFFSulfur Fumes|r%.%s*$","Aumenta em {{1}}% a chance de acerto crítico de |cFFFFFFFFLabareda|r e |cFFFFFFFFIgnição|r, aumenta em {{2}}% a frequência dos pulsos e reduz em {{3}}% a duração desses efeitos.\
\
Acertos críticos periódicos aplicam |cFFFFFFFFVapores de Enxofre|r."},
    {"^Auto attacks generate 1 |cFFFF9800Solar Power|r and deal (.-)%% increased damage%.\
\
|cffffffffFulfillment|r: Melee ability damage triggers an auto attack with each weapon%.\
\
Only 1 |cffffffffVow|r can be active at a time%.%s*$","Os ataques automáticos geram 1 |cFFFF9800Poder Solar|r e causam {{1}}% de dano aumentado.\
\
|cffffffffCumprimento|r: o dano das habilidades de corpo a corpo ativa um ataque automático com cada arma.\
\
Somente 1 |cffffffffVow|r pode estar ativo por vez."},
    {"^Auto attacks generate 1 |cFFFF9800Solar Power|r, deal (.-)%% increased damage, and have a (.-)%% increased chance to critically strike%.\
\
|cffffffffFulfillment|r: Next instance of melee ability damage triggers an auto attack%.\
\
Only 1 |cffffffffVow|r can be active at a time%.%s*$","Os ataques automáticos geram 1 |cFFFF9800Poder Solar|r, causam {{1}}% de dano aumentado e têm {{2}}% de chance de acerto crítico aumentada.\
\
|cffffffffCumprimento|r: a próxima ocorrência de dano de habilidade de corpo a corpo ativa um ataque automático.\
\
Somente 1 |cffffffffVow|r pode estar ativo por vez."},
    {"^Increases the damage of Moonfire spell by (.-)%% and the critical strike chance of Starfire by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: Dealing direct Arcane damage to a target afflicted by your Moonfire deals bonus damage equal to an extra tick of Moonfire%.|r%s*$","Aumenta em {{1}}% o dano de Fogo Lunar e em {{2}}% a chance de acerto crítico de Fogo Estelar.\
\
|cFFAAAAAABônus de Ápice: Causar dano Arcano direto a um alvo afetado por seu Fogo Lunar causa dano adicional equivalente a um pulso extra de Fogo Lunar.|r"},
    {"^Increases the damage done by your Hurricane and Typhoon spells by (.-)%%, and increases the range of your Cyclone and Entangling Roots spells by (.-) yards%. Reduces the mana cost of your Hurricane and Typhoon by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: The knockback force of your Typhoon is doubled%.|r%s*$","Aumenta em {{1}}% o dano causado por Furacão e Tufão e em {{2}} m o alcance de Ciclone e Raízes Enredantes. Reduz em {{3}}% o custo de mana de Furacão e Tufão.\
\
|cFFAAAAAABônus de Ápice: A força de repulsão de Tufão é duplicada.|r"},
    {"^Powers up your next ranged shot%. The longer you channel, the more damage the shot will deal%. However, channeling past the middle point will overstrain you, reducing your chance to hit%.%s*$","Fortalece seu próximo disparo à distância. Quanto mais tempo canalizar, mais dano causará o disparo. Entretanto, canalizar além do ponto médio você sobrecarregará, reduzindo sua chance de acertar."},
    {"^Increases the direct damage done by your Earth Shock, Flame Shock, and Frost Shock spells by an additional (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: Dealing damage with a Shock spell increases your damage with that magic school by 5%% for 10 seconds%. |r%s*$","Aumenta em mais {{1}}% o dano direto causado por Choque Terreno, Choque Flamejante e Choque Gélido.\
\
|cFFAAAAAABônus de Ápice: Causar dano com um feitiço de Choque aumenta em 5% o dano dessa escola de magia durante 10 segundos.|r"},
    {"^Increases your Parry chance by (.-)%% and Stamina by (.-)%%%.\
\
|cFFAAAAAACapstone Bonus: You gain damage reduction against direct damage spells equal to 33%% of your Parry chance%. This does not work against players%. \
\
The Capstone effect is only active while wielding a single Two%-Handed Weapon %(Does not work with Titan's Grip%.%)|r%s*$","Aumenta em {{1}}% sua chance de aparar e em {{2}}% seu Vigor.\
\
|cFFAAAAAABônus de Ápice: Você recebe redução de dano contra feitiços de dano direto equivalente a 33% da sua chance de aparar. Não funciona contra jogadores.\
\
O efeito final só fica ativo ao empunhar uma única arma de duas mãos (não funciona com Empunhadura do Titã).|r"},
    {"^Instantly Whirlwind up to (.-) nearby targets for (.-)%% weapon damage as Froststrike and for the next (.-) you will perform a whirlwind attack every (.-) sec%. While under the effects of Blades of Frost, you can move but cannot perform any other abilities and you cannot be stopped unless disarmed or killed%.%s*$","Realiza instantaneamente um Redemoinho à até {{1}} alvos próximos por {{2}}% de dano de arma como um golpe de Gelo e, durante os próximos {{3}}, você realizará um ataque de Redemoinho cada {{4}} seg. Enquanto estiver sob os efeitos de Lâminas de Gelo, você pode se mover mas não pode usar nenhuma outra habilidade e não pode ser impedido a menos que seja desarmado ou seja morto."},
    {"^Instantly Whirlwind up to (.-) nearby targets for (.-)%% weapon damage as Froststrike and for the next (.-) you will perform a whirlwind attack every (.-) sec%. While under the effects of Blades of Frost, you can move but cannot perform any other abilities and you cannot be stopped unless disarmed or killed%.\
\
This uses Bladestorm modifiers%.%s*$","Instantaneamente, você desfere um redemoinho contraté {{1}} alvos próximos, causando {{2}}% do dano da arma como Golpe Gélido. Durante os próximos {{3}}, você realiza um ataque de redemoinho a cada {{4}} s.\
\
Enquanto estiver sob o efeito de Lâminas de Gelo, pode se mover, mas não pode usar outras habilidades e só pode ser interrompido se for desarmado ou morto.\
\
Usa os modificadores de Tornado de Aço."},
    {"^Instantly Whirlwind up to (.-) nearby targets for (.-)%% weapon damage as Stormstrike and for the next (.-) you will perform a whirlwind attack every (.-) sec%. While under the effects of Blades of Lightning, you can move but cannot perform any other abilities and you cannot be stopped unless disarmed or killed%.%s*$","Realiza instantaneamente um Redemoinho à até {{1}} alvos próximos por {{2}}% de dano de arma como Golpe da Tempestade e, durante os próximos {{3}}, você realizará um ataque de Redemoinho cada {{4}} seg. Enquanto estiver sob os efeitos de Lâminas de raio, você pode se mover mas não pode realizar nenhuma outra habilidade e não pode ser impedido a menos que seja desarmado ou seja morto."},
    {"^Instantly Whirlwind up to (.-) nearby targets for (.-)%% weapon damage as Stormstrike and for the next (.-) you will perform a whirlwind attack every (.-) sec%. While under the effects of Blades of Lightning, you can move but cannot perform any other abilities and you cannot be stopped unless disarmed or killed%.\
\
This uses Bladestorm modifiers%.%s*$","Instantaneamente, você envolve em um redemoinho que atinge até {{1}} alvos próximos por {{2}}% de dano de arma como Golpe da Tempestade. Durante os próximos {{3}} você realizará ataques de redemoinho cada {{4}} seg.\
\
Enquanto estiver sob o efeito de Lâminas de Trovão, você pode se mover mas não pode usar outras habilidades e somenvocê deterão se você desarmam ou matam.\
\
Este usaos modificadores de Golpe da Tempestade."},
    {"^Increases the chance to trigger |cFFFFFFFFMissile Barrage|r and |cFFFFFFFFBrain Freeze|r by (.-)%%%.\
\
Consuming |cFFFFFFFFMissile Barrage|r increases the chance to trigger your next |cFFFFFFFFBrain Freeze|r by (.-)%%%.\
\
Consuming |cFFFFFFFFBrain Freeze|r with |cFFFFFFFFFireball|r increases the chance to trigger your next |cFFFFFFFFMissile Barrage|r by (.-)%%%.\
\
Consuming these effects reduces casting speed of |cFFFFFFFFFrost Bolt|r by (.-)%% and casting it grants |cFFFFFFFFEvoker|r%. Both effects stack up to (.-) times and last (.-)%.%s*$","Aumenta em {{1}}% a chance de ativar |cFFFFFFFFBarragem de Mísseis|r e |cFFFFFFFFCongelamento Cerebral|r.\
\
Consumir |cFFFFFFFFBarragem de Mísseis|r aumenta em {{2}}% a chance de ativar seu próximo |cFFFFFFFFCongelamento Cerebral|r.\
\
Consumir |cFFFFFFFFCongelamento Cerebral|r com |cFFFFFFFFBola de Fogo|r aumenta em {{3}}% a chance de ativar sua próxima |cFFFFFFFFBarragem de Mísseis|r.\
\
Consumir esses efeitos reduz em {{4}}% o tempo de lançamento de |cFFFFFFFFSeta de Gelo|r, e lançá-la concede |cFFFFFFFFEvoque|r. Ambos os efeitos acumulam até {{5}} vezes e duram {{6}}."},
    {"^Places a Frost Bomb on the target for 6 seconds%.\
\
Dealing damage with |cFFFFFFFFFrostbolt,|r |cFFFFFFFFCone of Cold|r, or |cFFFFFFFFDeep Freeze|r triggers a wave of freezing ice, dealing Frost damage and slowing enemies within 10 yards by 30%%%.\
\
When the effect ends or is dispelled, the Frost Bomb detonates, dealing damage and reducing enemy movement speed by 60%%%.\
\
Grants a stack of |cFFFFFFFFFrozen Haste|r per enemy hit%.%s*$","Coloca uma Bomba de Gelo no alvo durante 6 segundos.\
\
Causar dano com |cFFFFFFFFSeta de Gelo|r, |cFFFFFFFFCone de Frio|r ou |cFFFFFFFFCongelamento Profundo|r libera uma onda de gelo, causando dano de Gelo e reduzindo em 30% a velocidade dos inimigos em um raio de 10 metros.\
\
Quando o efeito termina ou é dissipado, a Bomba de Gelo explode, causando dano e reduzindo em 60% a velocidade de movimento do inimigo.\
\
Concede uma aplicação de |cFFFFFFFFAceleração sob Congelamento|r para cada inimigo atingido."},
    {"^Places a Frost Bomb on the target for 6 seconds%.\
\
Dealing damage with |cFFFFFFFFFrostbolt,|r |cFFFFFFFFCone of Cold|r, or |cFFFFFFFFDeep Freeze|r triggers a wave of freezing ice, dealing Frost damage and slowing enemies within 10 yards by 30%%%.\
\
When the effect ends or is dispelled, the Frost Bomb detonates, dealing damage and reducing enemy movement speed by 60%%%.\
\
Grants a stack of |cFFFFFFFFFrozen Haste|r per enemy hit%.\
\
 Can't be reflected%.%s*$","Coloca uma Bomba de Gelo no alvo durante 6 s.\
\
Causar dano com |cFFFFFFFFSeta de Gelo|r, |cFFFFFFFFCone de Frio|r ou |cFFFFFFFFCongelamento Profundo|r libera uma onda congelante, causando dano de Gelo e reduzindo em 30% a velocidade dos inimigos em um raio de 10 m.\
\
Quando o efeito termina ou é dissipado, a Bomba de Gelo explode, causando dano e reduzindo em 60% a velocidade de movimento dos inimigos.\
\
Concede uma aplicação de |cFFFFFFFFAceleração sob Congelamento|r para cada inimigo atingido.\
\
Não pode ser refletida."},
    {"^Hurls a holy buckler at the enemy, dealing (.-) to (.-) Holy damage%. It bounces off the enemy, landing on the ground, remaining there for 5 sec%. If you move over the buckler, you gain (.-)%% movement speed and take (.-)%% less damage for (.-)%. It also reduces its cooldown by 10 sec%.%s*$","Lança um escudo Sagrado ao inimigo, causando {{1}} de dano Sagrado a {{2}}. Rebota no inimigo e cai ao chão, permanecendo ali durante 5 seg. Se você se mover sobre o escudo, recebe {{3}}% de velocidade de movimento e você recebe {{4}}% menos de dano durante {{5}}. Também reduz sua recarga em 10 seg."},
    {"^Deliver a crushing blow to the target, dealing (.-) damage and reducing the target's armor by (.-)%% for (.-)%. Requires Maces%.%s*$","desfere um golpe devastador ao alvo, causando {{1}} de dano e reduz a armadura do alvo em {{2}}% durante {{3}}. Requer maças."},
    {"^Granted by dealing damage with |cFFFFFFFFMutilate%.|r\
\
Healing done by your |cFFFFFFFFCircle of Healing|r is increased by (.-)%%%.\
\
Your |cFFFFFFFFdamaging Rogue Finishing moves|r have a 10%% %(per stack%) chance per combo point to trigger a |cFFFFFFFFLesser Circle of Healing|r healing for (.-) and an additional (.-) over 3 seconds%. Stacks up to (.-) times and lasts (.-)%.%s*$","É concedido ao causar dano com |cFFFFFFFFMutilar.|r\
\
A cura realizada por seu |cFFFFFFFFCírculo de Cura|r aumenta {{1}}%.\
\
Seus |cFFFFFFFFremates de Ladino que causam dano|r têm chance de 10% (por aplicação) para cada ponto de combo de ativar um |cFFFFFFFFCírculo de Cura menor|r que cura {{2}} e um adicional de {{3}} durante 3 segundos. Acumula até {{4}} vezes e dura {{5}}."},
    {"^|cFFFFFFFFCharge|r and |cFFFFFFFFBattle Charge|r apply Crushing Impact to enemies within (.-) yards%.\
\
Your |cFFFFFFFFWarrior Abilities|r deal (.-)%% additional damage and |cFFFFFFFFVictory Rush|r deals (.-)%% additional damage to crushed targets%.\
\
Crushing Impact increases the damage taken from the casters Warrior abilities by (.-)%% against players, and (.-)%%%.\
\
Hitting crushed targets with a Physical melee ability reduces the cooldown of |cFFFFFFFFBattle Charge|r by 3 seconds%. Can only trigger once per 3 seconds%.%s*$","|cFFFFFFFFInvestida|r e |cFFFFFFFFInvestida de Batalha|r aplicam Impacto Esmagador aos inimigos em um raio de {{1}} m.\
\
Suas |cFFFFFFFFHabilidades de Guerreiro|r causam {{2}}% de dano adicional, e |cFFFFFFFFÍmpeto da Vitória|r causa {{3}}% de dano adicional aos alvos esmagados.\
\
Impacto Esmagador aumenta em {{4}}% contra jogadores e em {{5}}% contra outros alvos o dano recebido pelas habilidades de Guerreiro do conjurador.\
\
Atingir alvos esmagados com uma habilidade física corpo a corpo reduz em 3 segundos a recarga de |cFFFFFFFFInvestida de Batalha|r. Só pode ocorrer uma vez a cada 3 segundos."},
    {"^Casting Kill Shot triggers |cFFFFFFFFSic 'em|r making your pet deal additional Physical damage with its next attack, hitting up to (.-) targets for 50%% of the damage if Beast Cleave is active%.\
\
Casting Frenzy Shot allows your next Kill Shot to be cast regardless of the target's health and resets its cooldown if the target is below 20%%%.\
\
@ext:The damage of Sic 'em scales with Kill Command modifiers, and Marked for Death%.:ext@%s*$","Lançar Tiro Mortal ativa |cFFFFFFFFLance-se|r, fazendo seu mascote causar dano Físico adicional no próximo ataque. Se Talho da Fera estiver ativo, atinge até {{1}} alvos adicionais, causando 50% do dano.\
\
Lançar Disparo Frenético permite usar o próximo Tiro Mortal independentemente da vida do alvo e reinicia sua recarga se o alvo estiver abaixo de 20% de vida.\
\
@ext:O dano de Ataque! escala com os modificadores de Comando para Matar e Marcado para Morrer.:ext@"},
    {"^Hunter Shots reduce Frozen Orb's cooldown by (.-) sec%.\
\
Frozen Orb deals (.-)%% increased damage%. Casting it increases your ranged haste by (.-)%%%.%s*$","Os disparos de caçador reduzem a recarga de Orbe gélido em {{1}} seg.\
\
Orbe gélido causa {{2}}% mais de dano. Lançá-lo aumenta sua celeridade à distância em {{3}}%."},
    {"^Calls forth Pepe to ride on your head as you adventure together%.%s*$","Invoca a Pepe para que cavalgue sobre sua cabeça enquanto se aventuram juntos."},
    {"^Transforms the enemy into a frogduck, forcing it to wander around for up to 50 seconds%. While wandering, the frogduck cannot attack or cast spells but will regenerate very quickly%. Any damage will transform the target back into its normal form%. Only one target can be polymorphed at a time%. Only works on Beasts, Humanoids and Critters%.%s*$","Transforma o inimigo em um sapo-pato, obrigando-o a vagar por até 50 s. Enquanto vaga, o sapo-pato não pode atacar nem lançar feitiços, mas regenera vida muito rapidamente. Qualquer dano devolve o alvo à forma normal. Apenas um alvo pode ser transformado por vez. Funciona somente contra Feras, Humanoides e Bichos."},
    {"^Granted by casting |cFFFFFFFFArctis|r%.\
\
Increases the damage of your next |cFFFFFFFFFuego|r by (.-)%% %((.-)%% versus players%), critical strike chance by (.-)%% and reduces the mana cost by (.-)%%%.\
\
|cFFFFFFFFFireball|r and |cFFFFFFFFFire Blast|r grants additional stacks of |cFFFFFFFFGathering Will|r%. Upon reaching 4 stacks your Fuego deals additional damage to nearby enemies%.%s*$","Concedido ao lançar |cFFFFFFFFArctis|r.\
\
Aumenta em {{1}}% ({{2}}% contra jogadores) o dano do seu próximo |cFFFFFFFFFogo|r, em {{3}}% a chance de acerto crítico e reduz em {{4}}% o custo de mana.\
\
|cFFFFFFFFBola de Fogo|r e |cFFFFFFFFImpacto de Fogo|r concedem aplicações adicionais de |cFFFFFFFFCONCENTRAÇÃO DE VONTADE|r. Ao alcançar 4 aplicações, seu Fogo causa dano adicional aos inimigos próximos."},
    {"^Reduces your magic damage taken by (.-)%% and increases your armor by (.-)%%%. Lasts (.-)%.\
\
|cFFFFFFFFEmpowered:|r Your resistences are increased and your physical damage taken is reduced by (.-)%%%.%s*$","Reduz em {{1}}% o dano mágico recebido e aumenta em {{2}}% sua armadura. Dura {{3}}.\
\
|cFFFFFFFFFortalecido:|r suas resistências aumentam e o dano Físico recebido é reduzido em {{4}}%."},
    {"^Inflicts Shadow damage to nearby enemies%.\
Deals damage to enemies every second%.%s*$","Causa dano de Sombra os inimigos próximos.\
Causa dano os inimigos a cada segundo."},
    {"^Armor contribution from items by (.-)%% and Stamina increased by (.-)%%%. Damage dealt reduced by 30%% and threat generation increased by 100%%%.\
\
Energy cost of |cFFFFFFFFFan of Knives|r and |cFFFFFFFFRiposte|r reduced by 10%.\
\
You can no longer be critically struck by monsters%.%s*$","a contribuição de armadura dos itens aumenta {{1}}% e O Vigor aumenta {{2}}%. o dano causado é reduzida um 30% e a geração de ameaça aumenta um 100%.\
\
o custo de Energia de |cFFFFFFFFLeque de Facas|r e |cFFFFFFFFContra-ataque|r é reduzida em 10.\
\
Não pode receber acertos críticos dos monstros."},
    {"^You shift into an Arcane dimension increasing your healing by (.-)%% and reduces your damage by 50%%%.\
\
Enables the use of |cFFFFFFFFArcane Mending|r and |cFFFFFFFFArcane Resonance|r%.\
\
While shifted your spells cannot miss and your hit rating is converted into Intellect%.%s*$","Você se desloca para uma dimensão Arcana, aumentando sua cura em {{1}}% e reduzindo seu dano em 50%.\
\
Permite o uso de |cFFFFFFFFCura Arcana|r e |cFFFFFFFFRessonância Arcana|r.\
\
Enquanto estiver deslocado, seus feitiços não podem errar e seu índice de acerto é convertido em Intelecto."},
    {"^Increases the damage and critical chance of your Flametongue Weapon and Frostbrand Weapon by (.-)%%%.\
\
Damage from Flametongue Weapon or Frostbrand Weapon has a (.-)%% chance to grant |cFFFFFFFFConverging Elements|r, causing your next Stormstrike within (.-) to trigger no cooldown%. This can not occur more than once every 4 sec%.%s*$","Aumenta em {{1}}% o dano e a chance de acerto crítico de Arma de Labaredas e Arma de Estigma de Gelo.\
\
O dano de Arma de Labaredas ou Arma de Estigma de Gelo tem {{2}}% de chance de conceder |cFFFFFFFFElementos Convergentes|r, fazendo com que seu próximo Golpe da Tempestade usado em até {{3}} não ative a recarga. Só pode ocorrer uma vez a cada 4 s."},
    {"^Summons (.-) copies of yourself that charge at a nearby enemy and aid you in combat for (.-)%.\
\
While within (.-) yds of you, each copy reduces all damage you take by (.-)%%%. \
\
Applies |cffffffffSacred Restraint|r for (.-)%.%s*$","Invoca {{1}} cópias de você mesmo que investem contra um inimigo próximo e ajudam você em combate durante {{2}}.\
\
enquanto estiverem a menos de {{3}} m de você, cada cópia reduz todo o dano que você recebe em {{4}}%.\
\
Aplica |cffffffffRestrição Sagrada|r durante {{5}}."},
    {"^Your Starsurge triggers your Eclipse talent%.\
\
Periodic damage from your Insect Swarm, Moonfire and have a 2%% chance to reset the cooldown of Starsurge, increasing by 2%% each tick until it triggers%.%s*$","Surto Estelar ativa seu talento Eclipse.\
\
O dano periódico de Enxame de Insetos e Fogo Lunar tem 2% de chance de reiniciar a recarga de Surto Estelar. Essa chance aumenta em 2% a cada aplicação de dano periódico até o efeito ser ativado."},
    {"^Increases the critical strike chance of your Holy Fire by (.-)%%%. Casting Holy Fire Increases the damage and critical strike chance of your next two Smite casts by (.-)%%%.\
\
When casting Guardian Spirit on yourself you gain |cFFFFFFFFHoly Ascension|r%.%s*$","aumenta a chance de acerto crítico de seu Fogo Sagrado {{1}} %. Lançar Fogo Sagrado aumenta o dano e a chance de acerto crítico de seus dos próximos lançamentos de Castigo {{2}} %.\
\
Ao lançar Espírito Guardião, você recebe |cFFFFFFFFAscensão de Luz Sagrada|r."},
    {"^Increases the critical strike chance of your Holy Fire and Smite by (.-)%%%. Casting Holy Fire Increases the damage of your next two Smite casts by (.-)%%%.\
\
When casting Guardian Spirit you gain |cFFFFFFFFHoly Ascension|r%.%s*$","aumenta a chance de acerto crítico de seu Fogo Sagrado e de Castigo {{1}} %. Lançar Fogo Sagrado aumenta o dano de seus dos próximos lançamentos de Castigo {{2}} %.\
\
Ao lançar Espírito Guardião, você recebe |cFFFFFFFFAscensão de Luz Sagrada|r."},
    {"^Increases the critical strike chance of your Holy Fire by (.-)%%%.\
\
Casting |cFFFFFFFFHoly Fire|r grants you |cFFFFFFFFHoly Ascension|r%.\
\
Casting Guardian Spirit on yourself reduces the cooldown of Holy Fire by 50%% and causes Smite to trigger a holy explosion around the target while it is active%.%s*$","Aumenta em {{1}}% a chance de acerto crítico de Fogo Sagrado.\
\
Lançar |cFFFFFFFFFogo Sagrado|r concede a você |cFFFFFFFFAscensão de Luz Sagrada|r.\
\
Lançar Espírito Guardião em você reduz em 50% a recarga de Fogo Sagrado e faz Castigo provocar uma explosão sagrada ao redor do alvo enquanto o efeito estiver ativo."},
    {"^Casting Align, Time%-Bind and Synchronize now grants you |cFFFFFFFFBorrowed Time|r%. If you also the know the talent, you are granted the highest known rank%.%s*$","Lançar Alinear, Vínculo temporal e Sincronizar agora você concede |cFFFFFFFFTempo emprestado|r. Se também conhece o talento, é concede o grau mais alto conhecido."},
    {"^Casting Fuego grants you |cFFFFFFFFWinter's Mantle|r%. Casting Frostbolt and Ice Lance grant additional stacks while already active%.\
\
Fuego resets all stacks of Winter's Mantle%.%s*$","Lançar Fogo concede |cFFFFFFFFMANTO DO INVERNO|r. Lançar Seta de Gelo e Lança de Gelo concede acúmulos adicionais enquanto o efeito já estiver ativo.\
\
Fogo reinicia todos acúmulos de Manto do Inverno."},
    {"^This seems to do nothing%. Best keep on your toes though%. Cause that's the thing about bear attacksÃ¢â‚¬Â¦ They come when you least expect it%.%s*$","Isto parece não fazer nada. Mas não baixe a guarda. Pois é assim com os ataques de urso... Eles chegam quando menos você espera."},
    {"^Periodic damage from your Moonfire and Insect Swarm can now critically hit dealing (.-)%% bonus damage%. In addition, dealing damage with Starfall increases your critical strike chance by 15%%, lasting for 1 second per target hit%.%s*$","o dano periódico de seu Fogo lunar e Enxame de Insetos agora pode causar acertos críticos, causando {{1}}% de dano adicional. Além disso, causar dano com Chuva de Estrelas aumenta sua chance de acerto crítico em um 15% durante 1 segundo para cada alvo impactado."},
    {"^Finishing move that reduces your threat on nearby targets, increases your physical damage and reduces damage taken from area of effect damage for (.-)%.\
\
1 Point: 2%% less threat, %+1%% damage, %-3%% AoE damage taken%.\
2 Points: 4%% less threat, %+2%% damage, %-6%% AoE damage taken%.\
3 Points: 6%% less threat, %+3%% damage, %-9%% AoE damage taken%.\
4 Points: 8%% less threat, %+4%% damage, %-12%% AoE damage taken%.\
5 Points: 10%% less threat, %+5%% damage, %-15%% AoE damage taken%.\
\
Scales with Feint modifiers%. This ability is usable in Cat Form%.%s*$","Finalizador que reduz sua ameaça contra alvos próximos, aumenta seu dano Físico e reduz o dano recebido de efeitos de área durante {{1}}.\
\
1 ponto: 2% menos ameaça, +1% de dano, -3% de dano de área recebido.\
2 pontos: 4% menos ameaça, +2% de dano, -6% de dano de área recebido.\
3 pontos: 6% menos ameaça, +3% de dano, -9% de dano de área recebido.\
4 pontos: 8% menos ameaça, +4% de dano, -12% de dano de área recebido.\
5 pontos: 10% menos ameaça, +5% de dano, -15% de dano de área recebido.\
\
Recebe os modificadores de Finta. Esta habilidade pode ser usada em Forma de Felino."},
    {"^Dealing damage with Mongoose Bite now restores (.-) energy%. Grants you |cFFFFFFFFWild Aggression|r if it restores you to max energy%.%s*$","Causar dano com Mordida de Mangusto agora restaura {{1}} de Energia. Concede |cFFFFFFFFAgressão (Versão Selvagem)|r se restaurar sua Energiaté o máximo."},
    {"^Your next 3 |cFFFFFFFFTitanstrikes|r incur a (.-)%% reduced cooldown, are usable regardless of your target's health percentage, and deal (.-)%% increased damage%. Lasts (.-)%.\
\
Applies |cffffffffSacred Restraint|r for (.-)%.%s*$","Seus próximos 3 |cFFFFFFFFGolpes do Titã|r têm a recarga reduzida em {{1}}%, podem ser usados independentemente do percentual de vida do alvo e causam {{2}}% a mais de dano. Dura {{3}}.\
\
Aplica |cffffffffRestrição Sagrada|r durante {{4}}."},
    {"^Your |cffffffffPotion Toss|r and |cffffffffSplash Potion|r cooldown is reset, and the next use within (.-) now applies |cffffffffFish Bones|r to affected allies%.\
\
Instantly swaps your |cffffffffIngredients|r to |cffffffffFish Oil|r and |cffffffffFrog Bones|r%.s:500594:0@:ext@%s*$","A recarga de |cffffffffArremesso de Poção|r e |cffffffffPoção de Salpico|r é reiniciada, e o próximo uso realizado em até {{1}} aplica |cffffffffOssos de Peixe|r aos aliados afetados.\
\
Troca instantaneamente seus |cffffffffIngredientes|r por |cffffffffÓleo de Peixe|r e |cffffffffOssos de Rã|r"},
    {"^Your |cffffffffPotion Toss|r and |cffffffffSplash Potion|r cooldown is reset, and the next use within (.-) now applies |cffffffffFrog Shrooms|r to affected allies%.\
\
Instantly swaps your |cffffffffIngredients|r to |cffffffffJungle Shrooms|r and |cffffffffFrog Bones|r%.s:500509:0@:ext@%s*$","a recarga de |cffffffffArremesso de Poção|r e |cffffffffPoção de Salpico|r é reiniciada, e o próximo uso nos próximos {{1}} aplica |cffffffffCogumelos de Sapo|r aos aliados afetados.\
\
Troca instantaneamente seus |cffffffffIngredientes|r por |cffffffffCogumelos da Selva|r e |cffffffffOssos de Rã|r"},
    {"^Devote to Bethekk, granting (.-)%% increased movement speed%.\
\
Abilities that |cffffffffInvoke Bethekk|r have (.-)%% reduced cooldown and (.-)%% increased effectiveness and grant |cffffffffAppeasement of Bethekk|r%.\
\
Shares a 5 sec cooldown with other |cffffffffDevotions|r%.s:802096:0@:ext@%s*$","Devoção a Bethekk, concede {{1}}% de velocidade de movimento aumentada.\
\
As habilidades que |cffffffffEvoquem a Bethekk|r têm {{2}}% de recarga reduzida e {{3}}% de eficácia aumentada, e concedem |cffffffffApaziguamento de Bethekk|r.\
\
Compartilha uma recarga de 5 seg com outras |cffffffffDevoções|r.s:802096:0@:ext@"},
    {"^Devote to Sseratus, increasing healing by (.-)%%%.\
\
Abilities that |cffffffffInvoke Sseratus|r have (.-)%% reduced cooldown and (.-)%% increased effectiveness and grant |cffffffffAppeasement of Sseratus|r%.\
\
Shares a 5 sec cooldown with other |cffffffffDevotions|r%.s:802098:0@:ext@%s*$","Devote-se a Sseratus, aumentando em {{1}}% a cura realizada.\
\
As habilidades que |cffffffffInvocam Sseratus|r têm a recarga reduzida em {{2}}%, a eficácia aumentada em {{3}}% e concedem |cffffffffConciliação com Sseratus|r.\
\
Compartilha uma recarga de 5 s com outras |cffffffffDevoções|r.s:802098:0@:ext@"},
    {"^Casting |cffa966f0Cursed Form|r abilities now has a (.-)%% chance to generate 1 |cffffffffBlood Shard|r for (.-), up to 8%.\
\
Dealing damage with |cffffffffBloodbolt|r will launch 1 |cffffffffBlood Shard|r, dealing (.-) Arcane damage to your target%.%s*$","Lançar habilidades da |cffa966f0Forma Amaldiçoada|r agora tem {{1}}% de chance de gerar 1 |cffffffffFragmento de Sangue|r durante {{2}}, até o máximo de 8.\
\
Causar dano com |cffffffffDescarga de sangue|r lança 1 |cffffffffFragmento de Sangue|r, causando {{3}} de dano Arcano ao alvo."},
    {"^Call an |cffffffffHonored Ancestor|r to aid you in battle until dismissed that scales with your Agility and attack power%.\
\
Whenever you use |cffffffffBarbaric Whirl|r or |cffffffffWhirling Advance|r, your |cffffffffHonored Ancestor|r mimics it%.s:500534:0@:ext@%s*$","Evoca um |cffffffffAncestral Honrado|r para ajudar você em batalhaté ser dispensado. Os atributos dele escalam com sua Agilidade e seu poder de ataque.\
\
Sempre que você usar |cffffffffRedemoinho Bárbaro|r ou |cffffffffAvanço Giratório|r, seu |cffffffffAncestral Honrado|r imitará a habilidade.s:500534:0@:ext@"},
    {"^Increases your Maximum Health by (.-)%%, Armor Contribution from Cloth Items by 250%%, Dodge Rating by (.-)%% of your Spell Power, and all resistances by (.-)%.\
\
Significantly increases threat and makes you immune to interrupt effects, but reduces your damage done by (.-)%% and healing done by (.-)%%%.\
\
While in Dark Apotheosis, your Immolate is instant, grants you |cFFFFFFFFImmolation Aura|r for 8 sec and restores (.-)%% base mana, but has a 6 sec cooldown%.s:275589:0@:ext@%s*$","Aumenta em {{1}}% sua vida máxima, em 250% a contribuição de armadura dos itens de tecido, em {{2}}% do poder mágico seu índice de esquiva e em {{3}} todas as resistências.\
\
Aumenta significativamente a ameaça e torna você imune a efeitos de interrupção, mas reduz em {{4}}% o dano causado e em {{5}}% a cura realizada.\
\
Enquanto estiver em Apoteose Sombria, Imolar é instantâneo, concede |cFFFFFFFFAura de Imolação|r durante 8 s e restaura {{6}}% da mana base, mas possui 6 s de recarga.s:275589:0@:ext@"},
    {"^Increases your Maximum Health by (.-)%%, Armor Contribution from Cloth Items by 250%%, Dodge Rating by (.-)%% of your Spell Power, and all resistances by (.-)%.\
\
Significantly increases threat and makes you immune to interrupt effects, but reduces your damage done by (.-)%% and healing done by (.-)%%%.\
\
While in Dark Apotheosis, your Immolate is instant, grants you |cFFFFFFFFImmolation Aura|r for 8 sec and restores (.-)%% base mana, but has a 6 sec cooldown%.s:275589:0@:ext@\
You can use all schools and spells in Dark Apotheosis%. Demons never hide behind cover against a foe, as such you cannot wear a shield%.%s*$","Aumenta em {{1}}% sua vida máxima, em 250% a contribuição de armadura dos itens de tecido, em {{2}}% do poder mágico seu índice de esquiva e em {{3}} todas as resistências.\
\
Aumenta significativamente a ameaça e torna você imune a efeitos de interrupção, mas reduz em {{4}}% o dano causado e em {{5}}% a cura realizada.\
\
Enquanto estiver em Apoteose Sombria, Imolar é instantâneo, concede |cFFFFFFFFAura de Imolação|r durante 8 s e restaura {{6}}% da mana base, mas possui 6 s de recarga.s:275589:0@:ext@"},
    {"^Reaching (.-) stacks of |cFFFFFFFFSeething Growth|r now resets the cooldown of Sundering and Ground Slam and increases the critical chance and critical damage of its next cast by (.-)%%%. And makes Ground Slam trigger |cFFFFFFFFImpending Mortality|r if known%.s:278451:0@:ext@%s*$","Ao alcançar {{1}} aplicações de |cFFFFFFFFCrescimento Furibundo|r, a recarga de Ruptura e Batida no Chão é reiniciada, e a chance e o dano de acerto crítico do próximo lançamento aumentam em {{2}}%. Além disso, Batida no Chão ativa |cFFFFFFFFMortalidade Iminente|r caso você conheça esse efeito.s:278451:0@:ext@"},
    {"^Reaching (.-) stacks of |cFFFFFFFFSeething Growth|r now resets the cooldown of Sundering and Ground Slam and increases the critical chance and critical damage of its next cast by (.-)%%%. And makes Ground Slam trigger |cFFFFFFFFImpending Mortality|r if known%. Impending Mortality can only be triggered through Shattering Slam once every 20 seconds%.s:278451:0@:ext@%s*$","Ao alcançar {{1}} aplicações de |cFFFFFFFFCrescimento Furibundo|r, a recarga de Ruptura e Batida no Chão é reiniciada, e a chance e o dano de acerto crítico do próximo lançamento aumentam em {{2}}%. Além disso, Batida no Chão ativa |cFFFFFFFFMortalidade Iminente|r caso você conheça esse efeito. Mortalidade Iminente só pode ser ativada por Batida Estilhaçante uma vez a cada 20 segundos.s:278451:0@:ext@"},
    {"^Increases the damage of Arcane Shot against monsters and its critical strike chance by (.-)%%%.\
\
Casting Arcane Shot grants you |cFFFFFFFFArcane Infusion|r%.s:44401:0@:ext@%s*$","Aumenta em {{1}}% o dano de Disparo Arcano contra monstros e sua chance de acerto crítico.\
\
Lançar Disparo Arcano concede |cFFFFFFFFInfusão Arcana|r.s:44401:0@:ext@"},
    {"^Devote to Gonk, increasing the damage of your summoned creatures by (.-)%%%.\
\
Abilities that |cffffffffInvoke Gonk|r have (.-)%% reduced cooldown, and (.-)%% increased effectiveness and grant |cffffffffAppeasement of Gonk|r%.\
\
Shares a 5 sec cooldown with other |cffffffffDevotions|r%.s:570155:0@:ext@%s*$","Devota-se a Gonk, aumentando em {{1}}% o dano das criaturas evocadas.\
\
As habilidades que |cffffffffInvocam Gonk|r têm a recarga reduzida em {{2}}%, a eficácia aumentada em {{3}}% e concedem |cffffffffConciliação de Gonk|r.\
\
Compartilha uma recarga de 5 s com outras |cffffffffDevoções|r.s:570155:0@:ext@"},
    {"^Your |cffffffffPotion Toss|r and |cffffffffSplash Potion|r within (.-) now apply |cffffffffBlood Frog|r to affected allies%.\
\
Instantly swaps your |cffffffffIngredients|r to |cffffffffBloodthistle|r and |cffffffffFrog Bones|r%.s:500595:0@:ext@%s*$","Seus |cffffffffArremesso de Poção|r e |cffffffffPoção de Salpico|r em um raio de {{1}} agora aplicam |cffffffffRã de Sangue|r aos aliados afetados.\
\
Troca instantaneamente seus |cffffffffIngredientes|r por |cffffffffCardo-sangue|r e |cffffffffOssos de Rã|r"},
    {"^Heals 2 allies within 40 yards for (.-) over 5 sec and increases Holy healing received by (.-)%%%.\
\
|cFFFFFFFFScales from Renew modifiers|r%.%s*$","cura a 2 aliados em um raio de 40 m por {{1}} durante 5 s e aumenta a cura sagrado recebida em {{2}}%.\
\
|cFFFFFFFFEscala com os modificadores de Renovação|r."},
    {"^Makes you immune to all spell mechanics%.  Used in Automation scripts to give the bot immunity to negative effects while still being able to interact with objects%.%s*$","Torna você imune a todas as mecânicas de feitiços. Usado em scripts de Automation para conceder ao bot imunidade a efeitos negativos sem impedir a interação com objetos."},
    {"^Summons a Vekniss Borer to assist you for (.-)%.%s*$","Invoca a Perfurador Vekniss para ajudar você durante {{1}}."},
    {"^Right Click to summon and dismiss your frog%.%s*$","Clique com o botão direito para evocar e dispensar frog."},
    {"^Transforms an enemy into a frog, rendering it unable to attack or cast spells for (.-)%.%s*$","Transforma um inimigo em rã, impedindo-o de atacar ou lançar feitiços durante {{1}}."},
    {"^Summons a Servant of Antu'sul to assist you%.%s*$","Evoca um Servo de Antu'sul para ajudar você."},
    {"^Calls forth an Emerald Dragon Whelp to protect you in battle for a short period of time%.%s*$","Evoca um Filhote de Dragão Esmeralda para proteger você em batalha por um curto período."},
    {"^Transforms nearby enemies into frogs, rendering them unable to attack or cast spells for (.-)%.%s*$","Transforma os inimigos próximos em rãs, impedindo-os de atacar ou lançar feitiços durante {{1}}."},
    {"^Calls an Anubisath Warrior to assist you for (.-)%.%s*$","Evoca um Guerreiro Anubisath para ajudar você durante {{1}}."},
    {"^Calls a Bone Gryphon to serve as your flying mount%. May only be summoned and ridden within Onslaught Harbor%.%s*$","Evoca um Grifo Ósseo para servir como montaria voadora. Só pode ser evocado e usado no Porto da Ofensiva."},
    {"^Transform yourself into a frog%.  Lasts (.-)%.%s*$","Transforma você em uma rã. Dura {{1}}."},
    {"^Use on a Frozen Rune to melt it free%.%s*$","Use em uma Runa Congelada para derretê-la e libertá-la."},
    {"^Call Attumen to assist you%.%s*$","Chama Attumen para ajudar você."},
    {"^Begins taming a Barbed Crawler to be your companion for (.-)%.  If you lose the beast's attention for any reason, the taming process will fail%.%s*$","Começa a domar um Rastejante Farpado para ser seu companheiro durante {{1}}. Se você perder a atenção da fera por qualquer motivo, a tentativa falhará."},
    {"^Summons Kessel's elekk to your aid!%s*$","Evoca o elekk de Kessel para ajudar você!"},
    {"^Send a distress flare into the sky, calling for a Cenarion Expedition unit to come to your aid%.  Can only be used in Zangarmarsh while outdoors%.%s*$","Lança um sinalizador de emergência, chamando uma unidade da Expedição Cenariana para ajudar você. Só pode ser usado ao ar livre no Pântano Zíngaro."},
    {"^Place a rough stone statue on the ground where it will heal you for a short time before its power fades%.%s*$","Coloca no chão uma estátua de Pedra Rústica que cura você por um curto período antes de perder o poder."},
    {"^Summons an Ethereal Wraith to assist you%.%s*$","Evoca um Espectro Etéreo para ajudar você."},
    {"^Summons an Arcane Fiend to assist you for (.-)%.%s*$","Evoca um Demônio Arcano para ajudar você durante {{1}}."},
    {"^Place a coarse stone statue on the ground where it will heal you for a short time before its power fades%.%s*$","Coloca no chão uma estátua de Pedra Grosseira que cura você por um curto período antes de perder o poder."},
    {"^Place a heavy stone statue on the ground where it will heal you for a short time before its power fades%.%s*$","Coloca no chão uma estátua de Pedra Pesada que cura você por um curto período antes de perder o poder."},
    {"^Place a solid stone statue on the ground where it will heal you for a short time before its power fades%.%s*$","Coloca no chão uma estátua de Pedra Maciça que cura você por um curto período antes de perder o poder."},
    {"^Place a dense stone statue on the ground where it will heal you for a short time before its power fades%.%s*$","Coloca no chão uma estátua de Pedra Densa que cura você por um curto período antes de perder o poder."},
    {"^Place a primal stone statue on the ground where it will heal you for a short time before its power fades%.%s*$","Coloca no chão uma estátua de Pedra Primeva que cura você por um curto período antes de perder o poder."},
    {"^Extra damage to an enemy when behind them%.%s*$","Causa dano adicional a um inimigo quando você está atrás dele."},
    {"^Calls Sablemane to help you fight Goc%.%s*$","Chama Sablemane para ajudar você a enfrentar Goc."},
    {"^Summons the imp, Zeppit, to help you collect Warp Chaser Blood%. Zeppit can only be summoned in Netherstorm%.%s*$","Evoca o diabrete Zeppit para ajudar você a coletar Sangue de Caçador Dimensional. Zeppit só pode ser evocado na Eternévoa."},
    {"^Roots the target until the debuff is cleared%.  Used in Automation scripts to temporarily halt pathing NPCs%.%s*$","Imobiliza o alvo até que o efeito negativo seja removido. Usado em scripts de automação para interromper temporariamente a movimentação de PNJs."},
    {"^Call a Cenarion Sparrowhawk to help uncover buried Raven Stones in the area around Skettis in the Skethyl Mountains of Terokkar Forest%.%s*$","Chama um Gavião Cenariano para ajudar a revelar Pedras do Corvo enterradas ao redor de Skettis, nas Montanhas Skethyl da Mata Terokkar."},
    {"^Periodic aura that the knockdown dragon is pulsing%.  If a character gets this aura, they fire a dummy spell back at the dragon, who is listening for it on their creature action triggers%.%s*$","Aura periódica emitida pelo dragão de derrubada. Quando um personagem recebe a aura, lança um feitiço Dummy de volta no dragão, que o detecta pelos Triggers de ação da criatura."},
    {"^Dummy sent to the Knockdown Dragon when the character is hit by the Four Dragons: Periodic Aura spell %(id: 39991%)%.%s*$","Dummy enviado ao Dragão de Derrubada quando o personagem é atingido pelo feitiço Quatro Dragões: Aura Periódica (ID: 39991)."},
    {"^If hit with the Four Dragons: Periodic Aura %(id: 39991%), and thereby this spell, the character is forced cast the Four Dragons: Dummy to Dragon spell %(id: 39995%)%.%s*$","Ao ser atingido por Quatro Dragões: Aura Periódica (ID: 39991) e, portanto, por este feitiço, o personagem é forçado a lançar Quatro Dragões: Dummy para Dragão (ID: 39995)."},
    {"^Calls forth an Ember of Azzinoth to protect you in battle for a short period of time%.%s*$","Evoca uma Brasa de Azzinoth para proteger você em batalha por um curto período."},
    {"^Transforms you into the likeness of a worg%. Creatures other than the Fanggore worg pack can see through the disguise%.  Many actions, including combat and casting beneficial spells, will drop the disguise%.%s*$","Disfarça você de worg. Bichos que não pertencem à alcateia de worgs Presa Sangrenta enxergam através do disfarce. Muitas ações, incluindo entrar em combate e lançar feitiços benéficos, removem o disfarce."},
    {"^Permanently enchants bracers to increase STAT by X%.  Requires a level 65 or higher item%.%s*$","Encanta permanentemente braçadeiras, aumenta o ATRIBUTO em X%. Requer um item de nível 65 ou superior."},
    {"^Throw at a Reef Bull or Attracted Reef Bull to get it to follow you for a short time%. Range is (.-) yards%.%s*$","Arremesse em um Touro do Recife ou Touro do Recife Atraído para fazê-lo seguir você por um curto período. Alcance de {{1}} m."},
    {"^Summon a mole machine to bring you to your hearth%.%s*$","Evoca uma Máquina Toupeira para levar você até sua pedra de regresso."},
    {"^You're handed a smoke flare to target the top of a tower at Skorn, up to a distance of (.-) yards away%. This will call in an airstrike upon that tower and its casters%.%s*$","Você recebe um sinalizador de fumaça para marcar o topo de uma torre em Skorn até {{1}} m de distância. Isso chama um ataque aéreo contra a torre e os conjuradores nela."},
    {"^Right Click to summon an incorporeal coyote spirit to accompany you%. The spirit will remain until sent away or you remove the hat%.%s*$","Clique com o botão direito para invocar um espírito incorpóreo de coiote que acompanhará você. O espírito permanece até ser dispensado ou até você remover o chapéu."},
    {"^When you critically heal with your Healing Wave, Lesser Healing Wave or Riptide you summon an Ancestral spirit to aid you, instantly healing the lowest percentage health friendly party or raid target within 40 yards for (.-)%% of the amount healed%.%s*$","Ao obter uma cura crítica com Onda de Cura, Onda de Cura Inferior ou Contracorrente, você evoca um espírito ancestral que cura instantaneamente o aliado do grupo ou da raide com menor percentual de vida em um raio de 40 m em {{1}}% do valor curado."},
    {"^Summons an Enchanted Tiki Dervish to assist you in your challenge against Warlord Zol'Maz%. Can only be used in front of the Zol'Maz Gate when Warlord Zol'Maz is present and unengaged in combat%. The Enchanted Tiki Dervish will last for up to (.-)%.%s*$","Evoca um Dervixe Tiki Encantado para ajudar no desafio contra o Senhor da Guerra Zol'Maz. Só pode ser usado diante do Portão de Zol'Maz quando ele estiver presente e fora de combate. O Dervixe Tiki Encantado dura até {{1}}."},
    {"^When you critically heal with your Healing Wave or Lesser Healing Wave, you summon an Ancestral spirit to aid you, instantly healing the lowest percentage health friendly party or raid target within 40 yards%.%s*$","Ao obter uma cura crítica com Onda de Cura ou Onda de Cura Inferior, você evoca um espírito ancestral que cura instantaneamente o aliado do grupo ou da raide com menor percentual de vida em um raio de 40 m."},
    {"^Summons a ZX%-5103 mechanical suit complete with weaponry%.  The suit can operate for (.-) before it needs to recharge and repair any damage%.%s*$","Evoca um traje mecânico ZX-5103 totalmente armado. O traje funciona durante {{1}} antes de precisar recarregar e reparar os danos sofridos."},
    {"^Hurls a Granite Boulder at a targeted Stormforged Iron Giant, summoning a group of Earthen Ironbane dwarves to assist you in combat%.%s*$","Arremessa uma Rocha de Granito contra um Gigante de Ferro Forjado em Tempestade, evocando um grupo de anões Ferrofobia Terrano para ajudar você em combate."},
    {"^When within 15 yards of the Corpse of the Fallen Worg, the fang summons an Ethereal Worg%.  Follow the worg and keep it safe while it tracks the scent of the Stormforged Infiltrator%.%s*$","Quando você está até 15 m do Cadáver do Worg Caído, a presa evoca um Worg Etéreo. Siga-o e proteja-o enquanto ele rastreia o cheiro do Infiltrador Forjado em Tempestade."},
    {"^Transmutes many saronite bars into a single titanium bar%.  You have a chance to discover other transmutations when successful%.%s*$","Transmuta várias barras de saronita em uma barra de titânio. Ao obter sucesso, você tem chance de descobrir outras transmutações."},
    {"^A bear trap locks onto the first enemy that approaches, rooting them and causing (.-) Bleed damage per (.-) sec for (.-)%.  Damage caused may interrupt the effect%.%s*$","Uma armadilha para ursos prende o primeiro inimigo que se aproxima, imobilizando-o e causando {{1}} de dano de Sangramento a cada {{2}} s durante {{3}}. O dano causado pode interromper o efeito."},
    {"^This frog has found true love%.%s*$","Esta rã encontrou o amor verdadeiro."},
    {"^Apply before kissing Lake Frogs to avoid getting warts%.%s*$","Aplique antes de beijar Rãs do Lago para evitar verrugas."},
    {"^Summons a cloud of Saronite vapor that lasts until destroyed%.%.%. or something else happens%.%s*$","Evoca uma nuvem de vapor de saronita que dura até ser destruída... ou até que outra coisa aconteça."},
    {"^Crack Maloric over the head to incapacitate him while you search him for evidence%. Can only be used while standing behind Maloric%.%s*$","Acerte Maloric na cabeça para incapacitá-lo enquanto procura provas. Só pode ser usado quando você estiver atrás de Maloric."},
    {"^Spins up the dual cannons for (.-) before unleashing a spray of lasers in a random direction, dealing (.-) Spellfire damage every (.-) sec to all enemies caught inside%. Lasts (.-)%.%s*$","Prepara os canhões duplos durante {{1}} e então dispara lasers em uma direção aleatória, causando {{2}} de dano de Fogo Mágico a cada {{3}} s a todos inimigos atingidos. Dura {{4}}."},
    {"^Deploy the goblin chisel next to a Stone Block%. Must be within 5 yards of a Stone Block to use%. After setting the bomb, get away before it explodes!%s*$","Posiciona o Cinzel Goblínico ao lado de um Bloco de Pedra. É preciso estar até 5 m de um Bloco de Pedra. Depois de colocar a bomba, afaste-se antes que ela exploda!"},
    {"^Unleashes four streams of deadly energy that destroy any enemy targets they touch%.%s*$","Libera quatro correntes de energia mortal que destroem qualquer alvo inimigo que tocarem."},
    {"^Heals the caster for (.-)%% of their total health%. This is an automatic process that is triggered when the caster reaches low health%. If all three parts are destroyed before any can repair themselves, the repair process will be interrupted and the caster will be permanently destroyed%.%s*$","Cura o conjurador em {{1}}% da vida total. O processo é ativado automaticamente quando a vida fica baixa. Se as três partes forem destruídas antes que alguma possa se reparar, o processo será interrompido e o conjurador será destruído permanentemente."},
    {"^Transforms the enemy into a frog%. While hexed, the target cannot attack or cast spells%. Damage caused may interrupt the effect%. Lasts (.-)%. Only one target can be hexed at a time%.  Only works on Humanoids and Beasts%.%s*$","Transforma o inimigo em rã. Enquanto estiver enfeitiçado, o alvo não pode atacar nem lançar feitiços. O dano pode interromper o efeito. Dura {{1}}. Apenas um alvo pode ser enfeitiçado por vez. Funciona somente contra Humanoides e Feras."},
    {"^Subdues the will of target enemy, causing them to become charmed for (.-), with their damage dealt increased by (.-)%% and healing done increased by (.-)%% during that time%.%s*$","Subjuga a vontade do inimigo, enfeitiçando-o durante {{1}}. Nesse período, o dano causado aumenta em {{2}}% e a cura realizada aumenta em {{3}}%."},
    {"^Right Click to summon and dismiss your toxic wasteling%. Do not feed toxic wasteling%. Do not allow toxic wasteling to approach small animals%. Do not touch, sniff, or even look at toxic wasteling for extended periods of time%.%s*$","Clique com o botão direito para evocar e dispensar seu Toxic Wasteling. Não o alimente. Não permita que ele se aproxime de animais pequenos. Não toque, cheire nem sequer encare o Toxic Wasteling por períodos prolongados."},
    {"^Inflicts an enemy with a sense of impending despair%. The target will be stunned and cowering for (.-)%. if not dispelled before (.-)%.%s*$","Causa no inimigo uma sensação de desespero iminente. Se não for dissipado antes de {{2}}, o alvo ficará atordoado e encolhido de medo durante {{1}}."},
    {"^Attune the captured frog to Vanira's sight at Vanira's Sentry Totem%.%s*$","Sintoniza a rã capturada com a visão de Vanira no Totem Sentinela de Vanira."},
    {"^Toss one of Vanira's attuned frogs at one of the illuminated locations on the Echo Isles%. Only works when riding a bat%.%s*$","Arremessa uma das rãs sintonizadas de Vanira em um dos locais iluminados nas Ilhas do Eco. Funciona somente enquanto você estiver montado em um morcego."},
    {"^Calls forth a guardian of time to assist you inside the Black Morass for up to (.-)%.%s*$","Evoca um Guardião do Tempo para ajudar você dentro do Lamaçal Negro por até {{1}}."},
    {"^Consumed the Avatar of Hir'eek%.\
\
Damage dealt increased by (.-)%%%.\
Damage taken reduced by (.-)%%%.\
\
If consumed by Hakkar also grants the Sonic Burst ability%.%s*$","Consumiu o Avatar de Hir'eek.\
\
Dano causado aumentado em {{1}}%.\
Dano recebido reduzido em {{2}}%.\
\
Se for consumido por Hakkar, também concede a habilidade Impacto Sônico."},
    {"^Let your food settle before sitting down to eat again%.%s*$","Espere a comida assentar antes de se sentar para comer novamente."},
    {"^Wrangles a ram so it will follow you back to Ram Ranch%.%s*$","Laça um carneiro para que ele siga você de volta ao Rancho dos Carneiros."},
    {"^You got sand in your eyes%.\
\
Chance to hit reduced by (.-)%%%.\
Chance to dodge reduced by (.-)%%%.\
Chance to parry reduced by (.-)%%%.%s*$","Você está com areia nos olhos.\
\
Chance de acerto reduzida em {{1}}%.\
Chance de esquiva reduzida em {{2}}%.\
Chance de aparar reduzida em {{3}}%."},
    {"^You lost your weapon!  Next time, distance yourself from Coren when he drinks%.%s*$","Você perdeu sua arma! Da próxima vez, afaste-se de Coren quando ele beber."},
    {"^Animate (.-) Skeletal Archers to aid you in combat for (.-)%.%s*$","Reanima {{1}} Arqueiros Esqueléticos para ajudar você em combate durante {{2}}."},
    {"^Raise an Abomination to aid you in combat, occupying 3 Life Force%.\
\
It is surrounded by a disease cloud, dealing (.-) Nature damage to enemies when they deal damage and reducing their attack speed by (.-)%% for (.-)%.\
\
Command: Instantly unleashes an empowered disease cloud around it%.%s*$","Anima uma Abominação para ajudar você em combate, ocupando 3 pontos de Força Vital.\
\
Ela é envolvida por uma nuvem de doenças que causa {{1}} de dano de Natureza aos inimigos quando eles causam dano e reduz em {{2}}% a velocidade de ataque deles durante {{3}}.\
\
Comando: libera instantaneamente uma nuvem de doenças fortalecida ao redor dela."},
    {"^Doubles the duration of Blood Frenzy, Harvest Time and Harvesting Grounds%.%s*$","Duplica a duração de Frenesi Sanguíneo, Tempo de Colheita e Terras de Colheita."},
    {"^Doubles the duration of Blood Frenzy, Harvest Time, and Harvesting Grounds%.%s*$","Duplica a duração de Frenesi Sanguíneo, Tempo de Colheita e Terras de Colheita."},
    {"^Doubles the duration of Blood Frenzy%. Harvest Time and Harvesting Grounds%.%s*$","Duplica a duração de Frenesi Sanguíneo, Tempo de Colheita e Terras de Colheita."},
    {"^Doubles the duration of |cffffffffBlood Frenzy|r, |cffffffffHarvest Time|r and |cffffffffHarvesting Grounds|r%.%s*$","Duplica a duração de |cffffffffFrenesi Sanguíneo|r, |cffffffffTempo de Colheita|r e |cffffffffTerras de Colheita|r."},
    {"^Doubles the duration of |cffffffffBlood Frenzy|r, |cffffffffHarvest Time|r, and |cffffffffHarvesting Grounds|r%.%s*$","Duplica a duração de |cffffffffFrenesi Sanguíneo|r, |cffffffffTempo de Colheita|r e |cffffffffTerras de Colheita|r."},
    {"^Unleash a shard of frozen decay at an enemy, dealing (.-) Frost damage, slowing their movement speed by (.-)%% for (.-), and generating Runic Power%.%s*$","Lança um fragmento de decomposição gélida contra um inimigo, causando {{1}} de dano de Gelo, reduzindo a velocidade de movimento do alvo em {{2}}% durante {{3}} e gerando Poder Rúnico."},
    {"^Unleash a shard of frozen decay at an enemy, dealing (.-) Frost Damage, slowing their movement speed by (.-)%% for (.-), and generating Runic Power%.%s*$","Lança um fragmento de decomposição gélida contra um inimigo, causando {{1}} de dano de Gelo, reduzindo a velocidade de movimento do alvo em {{2}}% durante {{3}} e gerando Poder Rúnico."},
    {"^Absorbs%s+damage%s+equal%s+to%s+(.-)%%%s+of%s+your%s+Spirit%.%s*$","Absorve dano equivalente a {{1}}% do seu Espírito."},
    {"^Harvest the essence from your Raised minions, draining (.-) mana every (.-) sec in exchange for (.-) Runic Power%. Lasts (.-) sec%.%s*$","Ceifa a essência de seus lacaios animados, drenando {{1}} de mana a cada {{2}} s para gerar {{3}} de Poder Rúnico. Dura {{4}} s."},
}
local tipPairs = {
    {"^After activating |cFFFF9800Dawn|r, your Holy damage is increased by (.-)%% and the cast time of your Fire damage spells are reduced by (.-)%% for (.-)%.%s*$","Depois de ativar |cFFFF9800Aurora|r, seu dano Sagrado aumenta em {{1}}% e o tempo de lançamento de seus feitiços de dano de Fogo é reduzido em {{2}}% durante {{3}}."},
    {"^Throw a magical dagger forward 30 yds%. \
\
Reactivate this ability to teleport to it and damage all enemies around you upon arrival for (.-) Elemental Damage%.\
\
Usable while stealthed%.%s*$","Arremessa uma adaga mágica 30 m à frente.\
\
Reative esta habilidade para se teleportar até ela e, ao chegar, causar {{1}} de dano Elemental a todos inimigos próximos.\
\
Pode ser usada em Furtividade."},
    {"^Reduces the cooldown of Pele de Ferro by (.-)%%, but causes it to cost (.-) Rage and reduces its damage reduction effect by (.-)%%%.%s*$","Reduz a recarga de Pele de Ferro em {{1}}%, mas o há custar {{2}} Fúria e reduz seu efeito de redução de dano em {{3}}%."},
    {"^Direct damage that brings you below 35%% health activates Edgewalker%. Cannot occur more than once every 3 min%.%s*$","Dano direto que reduza sua vida para menos de 35% ativa Andarilho do Limiar. Esse efeito não pode ocorrer mais de uma vez a cada 3 min."},
    {"^Whenever you activate Dawn, you now gain Shining Shield for (.-)%.%s*$","Sempre que ativas Aurora, agora você recebe Escudo reluzente em {{1}}."},
    {"^Grants a (.-)%% chance to trigger a |cffffffffWorgen Bite|r against enemies who strike you with a melee attack while |cffffffffPele de Ferro|r is active%.%s*$","Concede {{1}}% de chance de ativar |cffffffffMordida Worgen|r contra inimigos que atingirem você com um ataque corpo a corpo enquanto |cffffffffPelagem de Ferro|r estiver ativa."},
    {"^Activating |cFFFF9800Dawn|r unleashes a burst of healing, restoring (.-) health to allies within (.-)yd%.%s*$","Ativar |cFFFF9800Aurora|r liberar um surto de cura, restaurando {{1}} vida a aliados dentro de {{2}}m."},
    {"^Causes you to gain (.-)%% increased melee haste for (.-) whenever you activate an |cffffffffEngrave Runes|r spell%.%s*$","Faz com que obtenha um aumento de {{1}}% na aceleração de corpo a corpo durante {{2}} sempre que ativas um |cffffffffEngraved Runes|r."},
    {"^Causes you to gain (.-)%% increased dodge chance after activating |cffffffffBenediction|r or |cffffffffTranquil Circle|r%.%s*$","Aumenta em {{1}}% sua chance de esquiva após ativar |cffffffffBênção|r ou |cffffffffCírculo tranquilo|r."},
    {"^|cffffffffWords|r now refund 1 |cffffffffInscribed Rune|r when they activate%. and increase their critical strike bonus damage by (.-)%%%.%s*$","|cffffffffWords|r agora devolvem 1 |cffffffffInscribed Rune|r quando são ativadas e aumentam o bônus de dano crítico em {{1}}%."},
    {"^Increases threat generation by (.-)%% and permanently activates Demon Form during combat%.\
\
Reduces damage dealt by (.-)%%%.%s*$","Aumenta a geração de ameaça em {{1}}% e ativa permanentemente a Forma Demoníaca durante o combate.\
\
Reduz o dano causado em {{2}}%."},
    {"^Teaches you |cffffffffImbue Flame|r, |cffffffffImbue Frost|r, and |cffffffffImbue Arcane|r%.\
\
These 3 spells share a 2 sec cooldown, and are only usable during |cffffffffRuneshroud|r%. They each generate 1 |cffffffffSigil|r of their respective type and activate the matching |cffffffffAttunement|r%.%s*$","Ensina |cffffffffImbuir Fogo|r, |cffffffffImbuir Gelo|r e |cffffffffImbuir Arcano|r.\
\
Esses três feitiços compartilham uma recarga de 2 s e só podem ser usados durante |cffffffffVéu de Runas|r. Cada um gera 1 |cffffffffSelo|r do tipo correspondente e ativa a |cffffffffSintonia|r equivalente."},
    {"^|cffffffffWord|r spells now activate (.-)%% faster%.%s*$","Feitiços de |cffffffffPalavra|r agora são ativados {{1}}% mais rápido."},
    {"^\
The caster is surrounded by (.-) globes of water, granting (.-) mana per 5 sec%. When a spell, melee or ranged attack hits the caster, (.-) mana is restored to the caster%. This expends one water globe%.  Only one globe will activate every few seconds%. Lasts (.-)%.%s*$","\
O conjurador está cercado em {{1}} globos de água que lhe concedem {{2}} mana a cada 5 s. Quando um feitiço, ataque corpo a corpo ou à distância golpeia o conjurador, se restauram {{3}} pontos de mana. Isto consome um globo de água. Somente um dos globos será ativado cada poucos segundos. Dura {{4}}."},
    {"^Throw a magical dagger forward 30 yds%.\
\
Reactivate this ability to teleport to it and damage all enemies around you upon arrival for (.-) Elemental Damage%.\
\
Usable while stealthed%.%s*$","Lança um faca mágico para a frente 30 m.\
\
Reative esta habilidade para teleportar-se a ele e causar {{1}} Dano Elemental todos inimigos ao redor seu ao chegar.\
\
Pode ser usada enquanto estiver em signo."},
    {"^You may reactivate this to return to your initial location%.%s*$","Pode reativar isto para retornar à sua localização inicial."},
    {"^Grill Mark can not be activated for this duration%.%s*$","Grilh Mark não pode ativar durante esta duração."},
    {"^Abyssal Protection can not be activated for this duration%.%s*$","Proteção Asa não pode ativar durante esta duração."},
    {"^Guarded by the Light can not be activated for this duration%.%s*$","Protegido pela Luz não pode ser ativado durante este efeito."},
    {"^Sunburn can not be activated for this duration%.%s*$","Queimadura de sol não pode ativar durante esta duração."},
    {"^Assault Scope can not be activated for this duration%.%s*$","Amplificador de Assalto não pode ativar durante esta duração."},
    {"^Portable Potion Pack can not be activated for this duration%.%s*$","Maleta portátil de poções não pode ativar durante esta duração."},
    {"^You may reactivate Hookshot on a bleeding target to deal additional damage and drag yourself to them%.%s*$","Pode reativar Chicote em um alvo com hemorragia para causar dano adicional e arrastar você para ele."},
    {"^Malfunctioning%.%.%.\
\
Defense System deactivated%.%s*$","Falho.\
\
Sistema de defesa desativado."},
    {"^Periodically activates a shield that reflects all attacks%.%s*$","Periodicamente ativa um escudo que reflete todos ataques."},
    {"^Flight systems activated%.%s*$","Sistemas de voo ativados."},
    {"^(.-)/5 stacks required to activate |cFFFFFFFFUnleash Fel Energy|r%.%s*$","{{1}}/5 acúmulos necessárias para ativar |cFFFFFFFFDesencadeia Energia Fel|r."},
    {"^dummy damage trigger for activation%s*$","acionador de dano para ativação"},
    {"^activation sls for 277562%s*$","ativação sls para 277562"},
    {"^activation sls for 984672%s*$","ativação sls para 984672"},
    {"^sls for activating execute crit chance for Fury of the Eagle 277595%s*$","sls para ativar a chance de acerto crítico de Força do águia 277595"},
    {"^sls for activating execute crit chance for Fury of the Eagle 984517%s*$","sls para ativar a chance de acerto crítico de Força do águia 984517"},
    {"^Tied to 277971\
Activates when outside of a tank stance%.%s*$","Vinculado a 277971.\
É ativado quando você não está em uma postura de tanque."},
    {"^Conditioned to 278221\
Activates with Avatar, and is removed upon losing Avatar%.\
SE1 every (.-) seconds you gain a stack of Thunder Blast!%s*$","Condicionado a 278221.\
Ativa com Avatar e é removido quando Avatar termina.\
SE1: a cada {{1}} s, concede um acúmulo de Explosão Trovejante!"},
    {"^Hot Trail can not be activated for this duration%.%s*$","Rastro Quente não pode ativar durante esta duração."},
    {"^Solar Crash can not be activated for this duration%.%s*$","Colisão Solar não pode ativar durante esta duração."},
    {"^Shotgun Kickback can not be activated for this duration%.%s*$","O recuo da espingarda não pode ativar durante esta duração."},
    {"^Casting 2 subsequent Unmakes activates Chromatic Empowerment%.%s*$","Lançar 2 Unhaceres consecutivos ativa o Empoderamento Cômico."},
    {"^Casting 2 subsequent Sandblasts activates Order Empowerment%.%s*$","Lançar 2 Arena abrasadora consecutivas ativa o Empoderamento de Ordem."},
    {"^Marked by the Brigand%. Additional stacks increases the damage taken by reactivating this ability%.%s*$","Marcado pelo Bandido. Os acúmulos adicionais aumentam o dano recebido ao reativar esta habilidade."},
    {"^Your Soul Infusion effects are activated%.%s*$","Seus efeitos de Infusão de Alma estão ativos."},
    {"^Prepared for battle%. Upon reactivation, apply Preparation to (.-) enemies within (.-) yd%.%s*$","Preparado para batalha. Ao ser reativado, aplica Preparação aos inimigos próximos ({{1}} em um raio de {{2}} m)."},
    {"^Activating |cffffffffDemon Form|r now refreshes a |cffffffffFelfury Charge|r%.%s*$","Ativando |cffffffffForma de demônio|r agora refresca uma |cffffffffCarga de FelFúria|r."},
    {"^At 100%% Static your next spell activates its |cffffffffSupercharged|r effect%.\
\
Static will start to rapidly decay if you stop generating it%.%s*$","Ao atingir 100% de Estática, seu próximo feitiço ativa o efeito |cffffffffSupercargado|r.\
\
A Estática começa a se dissipar rapidamente se você parar de gerá-la."},
    {"^Using an ability that activates Wickedness clears these stacks to empower it%. Stacks up to 10 times%.%s*$","Usar uma habilidade que ativa Perversidade consome os acúmulos para fortalecê-la. Acumula até 10 vezes."},
    {"^Using an ability that activates Purity clears these stacks to empower it%. Stacks up to 10 times%.%s*$","Usar uma habilidade que ativa Pureza remove esses acúmulos para fortalecê-la. Acumula até 10 vezes."},
    {"^At 4 stacks you can use Lunar Eclipse to activate Lunar Phase effects%.%s*$","Com 4 acúmulos você pode usar Eclipse Lunar para ativar os efeitos de Fase Lunar."},
    {"^You may reactivate Hemal Excision to place all siphoned curses on an enemy%.%s*$","Pode reativar Excisão hemal para colocar todas as maldições absorvidas em um inimigo."},
    {"^Using Crusader Strike & Divine Storm has a chance to empower a Seal ability, while the buff is active the Seal will deal more dmg and activating it has a lowered global%-cooldown during activation%.%s*$","Usar acerto Cruzado e Tempestade Divina tem chance de empoderar uma habilidade Selo, enquanto benefícios está ativo, o Selo causará dano adicional e sua recarga é reduzido durante a ativação."},
    {"^fel cleave sls\
SE1 felblade cdr\
SE2 Fel infused weapon proc\
SE3 corrupted maelstrom weapon proc when activating SE2%s*$","cleave fel sls\
SE1 felblade cdr\
SE2 arma infundida com fel proc\
SE3 mazmostral corrompido weapon proc quando ativa SE2"},
    {"^Dummy activation aura for se2 984569%s*$","Aura de ativação para se2 984569"},
    {"^Blightheart can be activated upon reaching (.-) stacks%.%s*$","Coração sombrio pode ativar ao alcançar {{1}} acúmulos."},
    {"^Activates Lunar Eclipse and Solar Eclipse at the same time%. This does not incur a cooldown on the Eclipse effects%.%s*$","Ativa Eclipse Eclipse Lunar o Sol Eclipse ao mesmo tempo. Isto não gera uma recarga nos efeitos do Eclipse."},
    {"^You have a chance when you kill an enemy that yields experience or honor to activate the lodestone allowing you to track nearby treasures for (.-)%.%s*$","Tem uma chance quando mata um inimigo que dá experiência ou honra para ativar a pedra magnética, permitindo que você rastrear tesouros próximos durante {{1}}."},
    {"^The Curator has activated his defense systems, reducing damage taken by (.-)%%%.\
\
Maybe there is a way to make him malfunction%?%s*$","O Conservador tem ativado seus sistemas de defesa, reduzindo o dano recebido em {{1}}%.\
\
Talvez há uma forma de fazer que se decomponha?"},
    {"^The Curator has activated his defense systems, reducing damage taken by (.-)%% and regenerates health over time%.\
Maybe there is a way to make him malfunction%?%s*$","O Conservador tem ativado seus sistemas de defesa, reduzindo o dano recebido em {{1}}% e regenerando vida com o tempo.\
Talvez há uma forma de fazer que se malfuncione."},
    {"^Spell trigger used in scripted to activate resets of adds%.%s*$","Desencorrentedor de feitiço utilizado na sequência programada para ativar os reinício dos aliados adicionais."},
    {"^Activates the cannon's repair system, restoring (.-)%% maximum health every (.-) seconds%. Repairs are performed automatically, without the need for a pilot!%s*$","Ativa o sistema de reparo do canhão, restaurando {{1}}% da vida máxima a cada {{2}} segundos. Os reparos são feitos automaticamente, sem precisar de um piloto!"},
    {"^Activates a powerful horn emitting a shockwave within 12 meters, pushing nearby racers away%.%s*$","Ativa um potente corno que emite uma onda expansiva dentro de 12 metros, afastando aos corredores próximos."},
    {"^Activates the ability to instantly teleport to the last reached checkpoint%. \"This time, you'll definitely succeed\"%s*$","Ativa a habilidade para teleportar instantaneamente ao último ponto de controle alcançou. \"Esta vez, definitivamente o lograrás\"."},
    {"^Flap back, reducing forward movement%.\
\
After activating Aerial Halt, experience a brief moment of weightlessness as the effects of gravity are reduced for 4 sec%.%s*$","Retrocede, reduzindo o movimento para a frente.\
\
Depois de ativar Parar-se em Voo, experimenta um breve momento de leveza enquanto os efeitos da gravidade é reduzido em durante 4 s."},
    {"^sls for 277522  can only activate when affected by 277504%s*$","sls para 277522 só pode ativar quando está afetado por 277504."},
    {"^When activated, allows your Detterrence to deflect all spells%. Lasts (.-)%.%s*$","Quando ativado, permite que seu Deterrência defleste todos feitiços. Dura {{1}}."},
    {"^Reduces all damage taken by (.-)%% and the rage cost of Pele de Ferro by (.-)%%%.%s*$","Reduz todo o dano recebido em {{1}}% e o custo de raiva de Pelhezarrabierta em {{2}}%."},
    {"^Miel Rune Activate%s*$","Ativar Runa de Mel."},
    {"^Kara Crypts Altar Activate I%s*$","Kara Crypts Altar Ativa I."},
    {"^Kara Crypts Altar Activate II%s*$","Kara Crypts Altar Ativa II."},
    {"^Prevents despawn activation for 10 minutes after guardians engaged%.%s*$","Evita a ativação de despawn durante 10 minutos depois que os guardiões se enganhen."},
    {"^When activated, this spell increases your critical strike change with Fire spells by (.-)%%%.%s*$","Ao ativar, este feitiço aumenta seu caminho de acerto crítico com os feitiços de Fogo em {{1}}%."},
    {"^Increases your armor by (.-)%% but reduces your chance to dodge by (.-)%%%. Bloodthirst deals bonus damage and grants Activate%.%s*$","Aumenta sua armadura em {{1}}% mas reduz sua chance de esquiva em {{2}}%. Sede de Sangue causa dano adicional e concede a você Ativar."},
    {"^When activated, plays a random assortment of Millhouse Manastorm's most eccentric sayings and vocalizations%s*$","Quando ativada, reproduz aleatoriamente algumas das falas e vocalizações mais excêntricas de Millhouse Manavento."},
    {"^Activate the rocket pack and shoot a small distance upwards%.%s*$","Ativa o arnês de foguete e dispara até uma curto distância."},
    {"^Transforms Chain Lightning into Forking Lightning%. Forked Lightning grants you a charge of Prodigious Storms%. \
\
Teaches you Tornado%. This channeled spell deals Froststorm damage at your target location%. You can auto shot while channeling this spell%.\
\
While Fingers of Frost is active, your Frostbolt and Ice Lance activate Prodigious Storms, causing lightning to fork out dealing Froststorm Damage%.\
\
While Mana Shield is active, your auto shots consume mana to add Frost damage to each attack and grant you a stack of Storm Conduit%. \
\
Storm Conduit increases the damage of your next Lightning Bolt by %% and its chance to critically strike by %%%.  This effect can only occur once every 1 second%.%s*$","Transforma Cadeia de Raios em Relâmpago Bifurcado. Relâmpago Bifurcado concede uma carga de Tempestades Prodigiosas.\
\
Ensina Tornado. Este feitiço canalizado causa dano de Tempestade Gélida no local selecionado. Você pode usar Disparo Automático enquanto o canaliza.\
\
Enquanto Dedos de Gelo estiver ativo, Seta de Gelo e Lança de Gelo ativam Tempestades Prodigiosas, fazendo relâmpagos se bifurcarem e causarem dano de Tempestade Gélida.\
\
Enquanto Escudo de Mana estiver ativo, seus Disparos Automáticos consomem mana para adicionar dano de Gelo a cada ataque e concedem um acúmulo de Condutor da Tempestade.\
\
Condutor da Tempestade aumenta o dano do seu próximo Raio e sua chance de acerto crítico. Este efeito só pode ocorrer uma vez a cada 1 s."},
    {"^MALFUNCTION!  Activating Inertial Transmogrifier!%s*$","AVARIA! Ativando transmogrifador inercial!"},
    {"^Deactivate%s*$","Desativar"},
    {"^When activated, increases dodge and parry chance by (.-)%% for (.-)%.%s*$","Quando ativado, aumenta a chance de esquiva em {{1}}% e aparar durante {{2}}."},
    {"^%*%*%*TURBO BOOST ACTIVATED%*%*%*%s*$","***TURBO ATIVADO***"},
    {"^Activates Zelig's Scrying Orb at the bottom of Frostmourne Cavern%.%s*$","Ativa o orbe de visão de Zelig na base dá Caverna Agonia de Gelo."},
    {"^When activated, decreases all damage taken by (.-)%% for (.-)%.%s*$","Quando está ativo, reduz todo o dano recebido {{1}}% durante {{2}}."},
    {"^Daño infligido aumentado un (.-)%%%.\
Velocidad de ataque y de lanzamiento aumentada un (.-)%%%.%s*$","Dano causado aumentado em {{1}}%.\
Velocidade de ataque e de lançamento aumentada em {{2}}%."},
    {"^Daño recibido reducido un (.-)%%%.%s*$","Dano recebido reduzido em {{1}}%."},
    {"^Inflige daño de Fuego a los enemigos cercanos%.%s*$","Causa dano de Fogo aos inimigos próximos."},
    {"^Marked by the witch%. If you get too close to another player, the whisper detonates%.%s*$","Marcado pela bruxa. Se você se aproximar demais de outro jogador, o sussurro explodirá."},
    {"^Taunts the target to attack you, but has no effect if the target is already attacking you%.%s*$","Provoca o alvo para atacar você, mas não tem efeito se já está atacando você."},
    {"^The breeze caresses your delicate spores%. What if you take a little rest%?%s*$","A brisa acaricia seus delicados esporos. Que tal descansar um pouco?"},
    {"^The ceiling above you is collapsing%.%s*$","O teto acima de você está desabando."},
    {"^Valdros lanzará su poderoso martillo contra ti, destruyendo todos los árboles a su paso%.%s*$","Valdros lançará seu poderoso martelo contra você, destruindo todas as árvores em seu caminho."},
    {"^You feel the caress of the Sleeper%. Your eyelids threaten to close%. If you stop moving, this cursed place will begin to drain your spirit%.%s*$","Você sente o toque do Adormecido. Suas pálpebras começam a se fechar. Se parar de se mover, este lugar amaldiçoado começará a drenar seu espírito."},
    {"^(.-) p%. de daño de escarcha durante (.-)%.%s*$","{{1}} de dano de Gelo durante {{2}}."},
    {"^A mystical orb filled with the swirling tides of the elemental planes%. As you grasp it, you can feel it slowly slipping from your grasp%.%s*$","Um orbe místico preenchido pelas marés revoltas dos planos elementais. Ao segurá-lo, você sente que ele escapa lentamente de suas mãos."},
    {"^Acrid smoke clings to your throat%.%s*$","Uma fumaça acre irrita sua garganta."},
    {"^Affected by a Greater Healing Dart, which will heal you when the Tinker draws the dart back to them%.%s*$","Afetado por um Dardo de Cura Maior, que curará você quando o Inventor puxar o dardo de volta."},
    {"^At the end of the duration you will take damage%.%s*$","Ao término do efeito, você receberá dano."},
    {"^Aumenta la velocidad de movimiento un (.-)%%%.%s*$","Aumenta a velocidade de movimento em {{1}}%."},
    {"^Aumenta la velocidad de vuelo un (.-)%%%.%s*$","Aumenta a velocidade de voo em {{1}}%."},
    {"^Aumenta la velocidad por tierra un (.-)%%%.%s*$","Aumenta a velocidade em solo em {{1}}%."},
    {"^Aumenta la velocidad terrestre un (.-)%% y la velocidad de nado un (.-)%%%.%s*$","Aumenta a velocidade em solo em {{1}}% e a velocidade de nado em {{2}}%."},
    {"^Aumenta la velocidad un (.-)%%%. Aumenta la velocidad acuatica un (.-)%%%.%s*$","Aumenta a velocidade em {{1}}%. Aumenta a velocidade na água em {{2}}%."},
    {"^Aumenta la velocidad un (.-)%%%. ¡Te has fumado un estiércol!%s*$","Aumenta a velocidade em {{1}}%. Você fumou esterco!"},
    {"^Aumenta la velocidad un (.-)%%%.%s*$","Aumenta a velocidade em {{1}}%."},
    {"^Being watched%.%s*$","Você está sendo observado."},
    {"^Blink and you'll miss it%.%s*$","Piscar é perder."},
    {"^Bonk other sword%-holders with your Foam Sword! Three Bonks defeats an opponent%. Unequipping your Foam Sword will destroy the sword%.%s*$","Acerte outros portadores de espada com sua Espada de Espuma! Três golpes derrotam um oponente. Desequipar sua Espada de Espuma destruirá a espada."},
    {"^Burns (.-) mana every (.-) seconds over (.-)%. If you fall bellow 50%% mana, the burn effect is heavily increased%.%s*$","Queima {{1}} de mana a cada {{2}} s durante {{3}}. Se seu mana ficar abaixo de 50%, o efeito de queima aumentará consideravelmente."},
    {"^Calls forth a guardian of time to assist you inside the Black Morass for up to (.-)%.%s*$","Evoca um Guardião do Tempo para ajudar você dentro do Lamaçal Negro por até {{1}}."},
    {"^Chance to hit with spells and abilities reduced by (.-)%%%.\
Periodically drained for (.-) life%.%s*$","Chance de acertar com feitiços e habilidades reduzida em {{1}}%.\
Periodicamente perde {{2}} de vida."},
    {"^Choose one of your stabled pets to replace your current pet%.%s*$","Escolha uma das suas mascotes no estábulo para substituir sua mascote atual."},
    {"^Consumed the Avatar of Hir'eek%.\
\
Damage dealt increased by (.-)%%%.\
Damage taken reduced by (.-)%%%.\
\
If consumed by Hakkar also grants the Sonic Burst ability%.%s*$","Consumiu o Avatar de Hir'eek.\
\
Dano causado aumentado em {{1}}%.\
Dano recebido reduzido em {{2}}%.\
\
Se consumido por Hakkar, também concede a habilidade Impacto Sônico."},
    {"^Cool if yellow's your favorite color!%s*$","Legal, se amarelo for sua cor favorita!"},
    {"^Cowering in fear%.%s*$","Encolhido de medo."},
    {"^Everything is strange%. You feel happy hungry and relaxed%. It's like you are discovering everything for the first time again%. You appreciate things you never noticed before, but can't tell genius from idiocy%. \
\
Moving will bring you back to reality%.%s*$","Tudo parece estranho. Você se sente feliz, faminto e relaxado. É como descobrir tudo novamente pela primeira vez. Você aprecia coisas que nunca havia notado, mas não consegue distinguir genialidade de estupidez.\
\
Mover-se trará você de volta à realidade."},
    {"^Forbidden knowledge of the Twisting Nether is bestowed upon you, should your mind endure the burden%.%.%.%s*$","O conhecimento proibido da Espiral Etérea é concedido a você, caso sua mente suporte o fardo..."},
    {"^Gives effective healing on you and any damage dealt by |cffffffffStarsunder|r a 15%% chance to enable you to use |cffffffffVengeance of Elune|r for a short time%.%s*$","A cura efetiva recebida e qualquer dano causado por |cffffffffRompe-estrelas|r têm 15% de chance de permitir o uso de |cffffffffVingança de Elune|r por um curto período."},
    {"^Hunched over in pain%.%s*$","Curvado de dor."},
    {"^If you are Interrupted, gain (.-)%% increased Spell Haste and (.-)%% increased Spell Damage for (.-)%.%s*$","Ao ser interrompido, recebe {{1}}% de celeridade de feitiço e {{2}}% de dano mágico aumentados durante {{3}}."},
    {"^Increases the cast speed and critical chance of Align by (.-)%%%. Reduces your Energy generation by (.-)%%%. Increases the healing and duration of Eternity%.\
\
When your Energy runs out, the distortion will end%.%s*$","Aumenta em {{1}}% a velocidade de lançamento e a chance de acerto crítico de Alinhar. Reduz em {{2}}% sua geração de Energia. Aumenta a cura e a duração de Eternidade.\
\
Quando sua Energia acabar, a distorção terminará."},
    {"^Inflige de (.-) à (.-) points de dégâts de Givre modifiés par la puissance d'attaque et réduit de (.-)%% la vitesse d'attaque en mêlée et à distance et la vitesse d'incantation de la cible pendant (.-)%.%s*$","Causa de {{1}} a {{2}} de dano de Gelo, modificado pelo poder de ataque, e reduz em {{3}}% as velocidades de ataque corpo a corpo, de ataque à distância e de lançamento do alvo durante {{4}}."},
    {"^Let your food settle before sitting down to eat again%.%s*$","Espere a comida assentar antes de sentar-se para comer novamente."},
    {"^Move to the location of your corpse or speak with a spirit healer to be revived%.%s*$","Vá até seu cadáver ou fale com um Anjo da Cura para ressuscitar."},
    {"^Potion Toss and Splash Potion now apply Blood Frog%.%s*$","Arremesso de Poção e Poção de Impacto agora aplicam Sangue de Rã."},
    {"^Potion Toss applies Frog Bones%.%s*$","Arremesso de Poção aplica Ossos de Rã."},
    {"^Splash Potion and Potion Toss now apply Frog Shrooms%s*$","Poção de Impacto e Arremesso de Poção agora aplicam Cogumelos de Rã."},
    {"^The Plague inflicts increasing damage every (.-) sec%.\
If you get too near a friendly target, you will transfer the Plague to them%.%s*$","A Peste causa dano crescente a cada {{1}} s.\
Se você se aproximar demais de um alvo aliado, transmitirá a Peste a ele."},
    {"^The blaster backfired%.%.%. you're shrunk!%s*$","O disparador saiu pela culatra... você encolheu!"},
    {"^The next spell cast on the Witch Doctor will cause this Effigy to transform the caster into a frog!%s*$","O próximo feitiço lançado contra o Feiticeiro fará esta Efígie transformar o lançador em uma rã!"},
    {"^Velocidad de movimiento ralentizada un (.-)%%%.%s*$","Velocidade de movimento reduzida em {{1}}%."},
    {"^Velocidad de movimiento reducida un (.-)%%%.%s*$","Velocidade de movimento reduzida em {{1}}%."},
    {"^Velocidad de nado aumentada un (.-)%%%.%s*$","Velocidade de nado aumentada em {{1}}%."},
    {"^Whenever you reach 100 Rage, you gain |cffffffffIgnite Blade|r for (.-) or until your Rage runs out%.%s*$","Ao atingir 100 de Raiva, você recebe |cffffffffAcender Lâmina|r durante {{1}} ou até sua Raiva acabar."},
    {"^Where'd your head go%?%s*$","Onde foi parar sua cabeça?"},
    {"^Wrangles a ram so it will follow you back to Ram Ranch%.%s*$","Laça um carneiro para que ele siga você de volta ao Rancho dos Carneiros."},
    {"^You are being given a second chance%.%s*$","Você está recebendo uma segunda chance."},
    {"^You are paralyzed%. Watch your step!  You hear the sharp clang of metal and cries of agony from the arena beyond, where your companions are fighting a pitched battle%. What do you suppose they would say if they could see you now%?%s*$","Você está paralisado. Cuidado onde pisa! Você ouve o som estridente de metal e gritos de agonia vindos da arena adiante, onde seus companheiros travam uma batalha intensa. O que será que diriam se pudessem ver você agora?"},
    {"^You are temporarily banished to the Shadowlands%.%s*$","Você foi banido temporariamente para as Terras Sombrias."},
    {"^You generate 4 Rage every second if you are moving%. If you are not moving, you will instead generate 10 Energy%.%s*$","Você gera 4 de Raiva por segundo enquanto se move. Se ficar parado, gerará 10 de Energia."},
    {"^You got sand in your eyes%.\
\
Chance to hit reduced by (.-)%%%.\
Chance to dodge reduced by (.-)%%%.\
Chance to parry reduced by (.-)%%%.%s*$","Entrou areia nos seus olhos.\
\
Chance de acerto reduzida em {{1}}%.\
Chance de esquiva reduzida em {{2}}%.\
Chance de aparar reduzida em {{3}}%."},
    {"^You lost your weapon!  Next time, distance yourself from Coren when he drinks%.%s*$","Você perdeu sua arma! Da próxima vez, afaste-se de Coren quando ele beber."},
    {"^You may now safely kiss Lake Frogs without fear of getting warts%.%s*$","Agora você pode beijar Rãs do Lago sem medo de criar verrugas."},
    {"^Your body is becoming numb%.%s*$","Seu corpo está ficando dormente."},
    {"^¡Nadie se escapa de las Fauces%.%.%. pero aparentemente éstas alas si!%s*$","Ninguém escapa da Gorja... mas aparentemente estas asas escapam!"},
}
local descIDs = {
    [13493]={"^The device charges over time using your life force and then directs a burst of energy at your opponent%.%s*$"},
    [25029]={"^Calls down a pillar of flame, burning all enemies in a selected area and inflicting additional damage every (.-) sec%. for (.-)%.%s*$"},
    [33047]={"^Sends a bolt of dark magic at an enemy, inflicting (.-) Shadow damage%.%s*$"},
    [35322]={"^Increases the damage of |cFFFFFFFFShadowflare|r by (.-)%%%.%s*$"},
    [39193]={"^Increases the damage of |cFFFFFFFFShadowflare|r by (.-)%%%.%s*$"},
    [39686]={"^Calls down a pillar of flame, burning all enemies in a selected area and inflicting additional damage every (.-) sec%. for (.-)%.%s*$"},
    [43722]={"^Your |cFFFFFFFFRighteous Lunge|r now benefits from your bonus spell power%.%s*$"},
    [43740]={"^Enhances your |cFFFFFFFFCycle of the Moon|r%.\
\
|cFFFFFFFFNew Moon:|r Healing done is increased by (.-)%%%.\
\
|cffffffffFull Moon:|r Cooldown of |cffffffffMoonflow|r is reduced by (.-) sec%.%s*$"},
    [48648]={"^Target an Onslaught raven priest and flash the mirror before them to steal their image%.%s*$"},
    [84014]={"^Increases the damage of the |cffffffffUnleash|r effect of |cffffffffPestilence of Apocalypse|r by (.-)%% and its duration is increased by (.-) sec%.%s*$"},
    [84728]={"^Increases Fire Damage by (.-)%% and critical strike chance by (.-)%%%.%s*$"},
    [92240]={"^Inflicts Nature damage to an enemy%.%s*$"},
    [101364]={"^The Chronosphere twists the time around you%.\
\
Movement Speed reduced by (.-)%%%.\
\
Applying Time Lapse every second%.%s*$"},
    [201095]={"^Increases the damage of |cFFFFFFFFShadowflare|r by (.-)%%%.%s*$"},
    [271451]={"^Allows casting Fel Meteor when at (.-) stacks%. Lasts (.-)%.%s*$"},
    [276779]={"^Reduces the cooldown of |cffffffffGravity Bomb|r by (.-) sec%.%s*$"},
    [278404]={"^Casting Bloodthirst has a (.-)%% chance to make your next Execute consume all your rage to increase its damage%. Lasts (.-)%.%s*$"},
    [280111]={"^|cFFFFFFFFThis spell belongs to |r|cFF0070DEStormbringer|r\
\
Cover yourself in a barrier of volatile energy for (.-), causing all attacks against you to have a (.-)%% chance to deal half damage%.\
\
|cffffffffStormcloak|r has a (.-)%% chance to resist dispel effects%.%s*$"},
    [280136]={"^|cFFFFFFFFThis spell belongs to |r|cFFF2E699Runemaster|r\
\
Toss an enchanted dagger forward in a line%. Upon reactivation, you instantly teleport to the location of the dagger and deal (.-) Elemental damage to nearby enemies%.\
\
Usable while stealthed%.%s*$"},
    [280156]={"^|cFFFFFFFFThis spell belongs to |r|cFFF58CBASun Cleric|r\
\
Shift (.-) yds forward at light speed, removing all root effects%.\
\
This leaves behind a |cffffffffSun Gate|r for (.-) that allies can interact with to blink themselves the same distance forward%. Allies can only use |cffffffffSun Gate|r every (.-)%.%s*$"},
    [280164]={"^|cffffffffFalcon's Dive|r, |cffffffffFalconstrike|r, and |cffffffffFalcon's Call|r make your next |cffffffffRanger's Horn|r trigger no cooldown%.%s*$"},
    [280290]={"^|cFFFFFFFFThis spell belongs to |r|cFF0070DEStormbringer|r\
\
Mark an enemy for (.-)%. Every (.-) sec, enemies near them take (.-) Nature damage%.\
\
At the end of the duration, enemies near them also take (.-) Nature damage and are rooted for (.-)%.%s*$"},
    [280317]={"^|cFFFFFFFFThis spell belongs to |r|cFF0D2ED6Primalist|r\
\
Summon a totem that increases all stats of party and raid members by (.-) within (.-) yds for (.-)%.%s*$"},
    [280318]={"^|cFFFFFFFFThis spell belongs to |r|cFF0D2ED6Primalist|r\
\
Summon a totem that increases all stats of party and raid members by (.-) within (.-) yds for (.-)%.%s*$"},
    [280381]={"^|cFFFFFFFFThis spell belongs to |r|cFFC41F3BKnight of Xoroth|r\
\
Create a demonic sigil that protects party members within (.-) yds of you, causing them to deflect the next harmful spell cast against them within (.-)%.%s*$"},
    [282807]={"^Increases Fire Damage by (.-)%% and critical strike chance by (.-)%%%.%s*$"},
    [300337]={"^Healing done by |cffffffffShine|r or |cffffffffIllumination|r now increases the targets movement speed by (.-)%% for (.-)%.%s*$"},
    [300399]={"^Increases the damage of |cffffffffSargeron Smite|r by (.-)%%%.%s*$"},
    [300739]={"^|cffffffffHand of the Earthmother|r now increases the target's dodge chance by (.-)%% for (.-)%.%s*$"},
    [300790]={"^Increases the critical damage of |cFFFFFFFFQuickdraw|r by (.-)%%%.%s*$"},
    [300868]={"^|cffffffffSeismic Wave|r now increases the movement speed of affected allies by (.-)%% for (.-)%.%s*$"},
    [300925]={"^|cFFFFFFFFKeleseth's Calamity|r allows you to cast |cFFFFFFFFSanguine Rupture|r during |cFFFFFFFFLifedrinker|r for (.-)%.\
\
While this effect holds, |cFFFFFFFFSanguine Rupture|r  generates no Rage or |cFFFFFFFFThirst|r%.%s*$"},
    [302516]={"^Reduces the cooldown of |cff90ee90Command|r spells by (.-)%%%.%s*$"},
    [302528]={"^|cffffffffBrutal Swing|r and |cffffffffSavage Smash|r increase the damage of your next |cffffffffWrecker|r by (.-)%% for (.-)%.%s*$"},
    [302555]={"^|cFFFFFFFFThis spell belongs to |r|cFFC41F3BKnight of Xoroth|r\
\
Create a demonic sigil that protects party members within (.-) yds of you, causing them to deflect the next harmful spell cast against them within (.-)%.%s*$"},
    [312353]={"^Increases the damage of |cFFFFFFFFShadowflare|r by (.-)%%%.%s*$"},
    [313504]={"^Poisons the enemy for (.-) Nature damage every (.-) sec for (.-)%.%s*$"},
    [313731]={"^Applies a virulent poison dealing (.-) nature damage every (.-) seconds for (.-)%.%s*$"},
    [316353]={"^Increases the damage of |cFFFFFFFFShadowflare|r by (.-)%%%.%s*$"},
    [317504]={"^Poisons the enemy for (.-) Nature damage every (.-) sec for (.-)%.%s*$"},
    [317731]={"^Applies a virulent poison dealing (.-) nature damage every (.-) seconds for (.-)%.%s*$"},
    [320353]={"^Increases the damage of |cFFFFFFFFShadowflare|r by (.-)%%%.%s*$"},
    [321504]={"^Poisons the enemy for (.-) Nature damage every (.-) sec for (.-)%.%s*$"},
    [321731]={"^Applies a virulent poison dealing (.-) nature damage every (.-) seconds for (.-)%.%s*$"},
    [500100]={"^Periodic damage dealt now has a (.-)%% chance to increase your Shadow damage dealt against the target by (.-)%% for (.-)%.%s*$"},
    [500570]={"^Ranged attacks and abilities now have a (.-)%% chance to shoot an additional shot dealing (.-) Physical damage and generating (.-) Rage%.%s*$"},
    [500588]={"^|cFFFFFFFFThis spell belongs to |r|cFFF2E699Runemaster|r\
\
Toss an enchanted dagger forward in a line%. Upon reactivation, you instantly teleport to the location of the dagger and deal (.-) Elemental damage to nearby enemies%.\
\
Usable while stealthed%.%s*$"},
    [500936]={"^Generates Static%.%s*$"},
    [502133]={"^Avoiding or absorbing an attack now has a (.-)%% chance to make your next |cFFFFFFFFBlade of the Empire|r deal (.-)%% more damage and hit an additional nearby enemy%.%s*$"},
    [503548]={"^|cffffffffSticky Bomb|r now also reduces the cooldown of |cffffffffStun Grenade|r by (.-) sec%.%s*$"},
    [503553]={"^Direct healing critical strikes now increase the healing done by your next |cFFFFFFFFRepair Shot|r or |cffffffffEmergency Heal|r by (.-)%% for (.-)%.%s*$"},
    [503610]={"^Causes |cffffffffSniper Scrap Shots|r and |cffffffffGunsling|r to make your next gun swap instant and not trigger their global cooldowns%.%s*$"},
    [503634]={"^Emanate an aura around you for (.-), causing allied players within (.-) yds to deal (.-) additional damage as Holy damage when they deal direct damage%.\
\
Applies |cFFFFFFFFExhaustion|r, preventing you from benefiting from similar effects for (.-)%.%s*$"},
    [503647]={"^Critical strikes with |cffffffffQuick Shot|r now reduce the cast time of |cffffffffSkullpiercer Shot|r by (.-)%%, stacking (.-) times, for (.-)%.%s*$"},
    [503702]={"^|cffffffffStrike of the Gods|r now increases the effectiveness of your next |cffffffffAppeasement|r by (.-)%% for (.-)%.%s*$"},
    [503706]={"^Damage dealt by |cffffffffShadowflare|r and |cffffffffHexfire|r now increases the chance enemies are critically struck by (.-)%% for (.-)%.%s*$"},
    [503730]={"^Each active |cffffffffSkeletal Archer|r now increases your haste by (.-)%%%.%s*$"},
    [503796]={"^|cffffffffVenomtip Poison|r now deals (.-) Nature damage on hit%.%s*$"},
    [503829]={"^Fling a shard of chaos at an enemy, dealing (.-) Chromatic Damage, piercing immunities and resistances%.\
\
Dealing damage with |cffffffffAnomaly Spikes|r reduces the cast time of this ability by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [503853]={"^Increases the critical strike chance of |cffffffffWidow's Kiss|r on |cff7fff00Diseased|r targets by (.-)%%%.%s*$"},
    [503874]={"^Reduces magic damage taken by (.-)%% and causes taking damage to increase your movement speed by (.-)%% for (.-)%.\
\
This can occur only once every 10 seconds%.%s*$"},
    [503903]={"^Casting |cFFFFFFFFMelt Reality|r now causes your |cFFFFFFFFTimerend|r and |cFFFFFFFFUnmake|r's periodic damage to benefit from haste for (.-)%.%s*$"},
    [503952]={"^Reduces an enemy's chance to hit by (.-)%% and increases their Nature Damage taken from you by (.-)%% for (.-)%.\
\
Dispelling this effect increases the dispeller's resource costs by (.-)%% for (.-)%.%s*$"},
    [503977]={"^Critical strikes with |cFFFFFFFFVenom Bolt|r, |cffffffffHivebreak|r, or |cffffffffVenom Fang|r now increase your movement speed by (.-)%% for (.-)%.%s*$"},
    [504063]={"^|cffffffffRepair Shot|r now increases movement speed by (.-)%% for (.-)%.%s*$"},
    [504201]={"^Damage dealt by |cffffffffGeode Barrage|r and |cffffffffGeodes|r to increase the chance for the enemy to be critically hit with spells by (.-)%% for (.-)%.%s*$"},
    [504274]={"^Increases the damage of your next |cffffffffSanguine Rupture|r and |cffffffffBloodmoon Blast|r by (.-)%% for (.-)%.%s*$"},
    [504286]={"^When |cffffffffLiquify|r ends, you now leech (.-) health from nearby enemies%.%s*$"},
    [504300]={"^For the next (.-), dealing direct Fire Damage allows |cffffffffSunflare|r to become instant cast%.%s*$"},
    [504358]={"^|cffffffffIcequake|r no longer has a cooldown, but its damage is reduced by (.-)%%%.%s*$"},
    [504381]={"^Increases your Shadow damage dealt and your critical strike chance with Shadow spells by (.-)%%%.%s*$"},
    [504398]={"^Increases the critical strike chance of |cffffffffLava Shard|r and |cffffffffCinderheart|r by (.-)%% against |cffff4500Burning|r targets%.%s*$"},
    [504418]={"^Place down a |cffffffffVoodoo Cauldron|r for (.-), increasing allies' healing received by (.-)%% while near the cauldron%.\
\
Allies within (.-) yds are healed for (.-) every 1%.5 sec for (.-)%.%s*$"},
    [504419]={"^Place down a |cffffffffVoodoo Cauldron|r for (.-), increasing allies' healing received by (.-)%% while near the cauldron%.\
\
Allies within (.-) yds are healed for (.-) every 1%.5 sec for (.-)%.%s*$"},
    [504425]={"^Reduces the cooldown of |cFFFFFFFFMirage|r by (.-) sec%.%s*$"},
    [504463]={"^|cffffffffShadow Puppets|r now ticks (.-)%% faster and lasts (.-)%% longer for each |cffffffffSpirit|r active on you%.%s*$"},
    [504467]={"^|cffffffffInvoke Bethekk|r\
Instantly teleport behind an enemy, causing (.-) Shadowstrike Damage and increasing movement speed by (.-)%% for (.-)%.%s*$"},
    [504479]={"^Causes critical strikes from |cffffffffShadowblast|r and |cffffffffSaber Slash|r to reduce the cooldown of |cffffffffHoundmaster's Call|r by (.-) sec and |cffffffffFlourish|r by (.-) sec%.%s*$"},
    [504496]={"^|cffffffffSniper Rifle Blackpowder Shot|r now deals (.-)%% additional damage every (.-) sec%.%s*$"},
    [504497]={"^|cffffffffDragon's Fury|r now also increases the damage of your next direct damage spell by (.-)%% for (.-)%.%s*$"},
    [504526]={"^Increases the critical damage of your |cffffffffMechsuit|r abilities by (.-)%%%.%s*$"},
    [504640]={"^Allows you to cast |cFFFFFFFFUnmake|r and |cFFFFFFFFMelt Reality|r while moving for (.-)%.%s*$"},
    [504703]={"^Increases your Shadow damage dealt and your critical strike chance with Shadow spells by (.-)%%%.%s*$"},
    [504723]={"^Transform into an |cFFFFFFFFIncarnate of Chaos|r, instantly resetting the cooldown of |cffffffffChromatic Shard|r and causing your next cast to not incur a cooldown%.\
\
In addition, your damage dealt is increased by (.-)%% for (.-)%.%s*$"},
    [504821]={"^Summon a voodoo idol at the target location for (.-)%. At the end of the duration, it explodes dealing (.-) Spellshadow Damage%.%s*$"},
    [504885]={"^Restores (.-)%% Missing Energy%.%s*$"},
    [504900]={"^Generates Static%.%s*$"},
    [506636]={"^Damage dealt reduced by (.-)%%%.%s*$"},
    [520000]={"^Damage dealt by |cffffffffMeatsaw|r and |cffffffffDreadrider's Sweep|r now applies |cffffffffTorn Flesh|r%.%s*$"},
    [520044]={"^Expose an enemy's past for (.-), causing them to take (.-)%% more magic damage from you%.%s*$"},
    [520093]={"^|cFFFFFFFFUnleash|r: Deals (.-) Frost Damage and slows movement speed by (.-)%% for (.-)%.%s*$"},
    [520094]={"^|cFFFFFFFFUnleash|r: Deals (.-) Fire Damage and an additional (.-) Fire Damage over (.-)%.%s*$"},
    [520095]={"^|cFFFFFFFFUnleash|r: Deals (.-) Arcane Damage to up to (.-) enemies near the primary target%.%s*$"},
    [520169]={"^After consuming an |cffffffffOrb of Fate|r, your next |cffffffffSandblast|r is instant and hits up to (.-) targets%.%s*$"},
    [520177]={"^Critical strikes with |cffffffffShatter Echo|r now increases the enemy's damage taken from you by (.-)%% for (.-)%.%s*$"},
    [520259]={"^Increases attack power by (.-) for (.-)%.%s*$"},
    [520299]={"^Allows periodic damage from |cffffffffBane of Chaos|r to critically strike%.%s*$"},
    [520364]={"^Transform into an undead monstrosity for (.-), increasing your maximum health by (.-)%%%.\
\
While transformed you are immune to Fear, Sleep, Charm, and Disease effects%.%s*$"},
    [520380]={"^Increases the duration of |cFFFFFFFFNecrotic Chains|r and |cFFFFFFFFIce Barrage's|r freeze effect by (.-) sec%.%s*$"},
    [520478]={"^|cFFFFFFFFStarcall|r now increases the chance for |cFFFFFFFFHuntress Shot|r to apply |cff66ccffScattered Stars|r by (.-)%% for (.-)%.%s*$"},
    [520754]={"^Dealing damage with |cffffffffPrimordial Blast|r now reduces the affected target's armor by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [520929]={"^|cffffffffDrains (.-)%% Maximum Mana|r\
Emanate an aura for (.-), causing allied players to deal (.-) additional damage as Arcane Damage when they deal direct damage%.\
\
Applies |cFFFFFFFFExhaustion|r, preventing you from benefiting from similar effects for (.-)%.%s*$"},
    [524182]={"^Your damage dealt by |cffffffffDarkfallen Lament|r now applies |cffffffffBloodcraft|r to affected enemies, reducing damage dealt by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [524630]={"^Increases the melee haste of your Undead minions by (.-)%% and gives their critical melee auto attacks an (.-)%% chance to trigger |cFFFFFFFFBone Club|r, dealing (.-)%% of the damage dealt as Shadow Damage%.%s*$"},
    [524633]={"^Emanate a powerful aura, granting (.-)%% increased melee and ranged haste to party and raid members within (.-) yds%. Does not stack with similar effects%.\
\
In addition, while |cff32cd32Inner Demon|r is active, you now heal for (.-)%% of all melee damage dealt%.%s*$"},
    [524688]={"^Increases the damage of |cffffffffGlacial Impact|r by (.-)%%%.%s*$"},
    [524700]={"^Damage dealt by |cffffffffVoodoo Puddle|r reduces enemy movement speed by (.-)%% for (.-), stacking (.-) times%.\
\
Each stack also increases damage taken by |cffffffffSerpent Beam|r by (.-)%%%.%s*$"},
    [524849]={"^Damage dealt by |cffffffffVoodoo Puddle|r reduces enemy movement speed by (.-)%% for (.-), stacking (.-) times%.\
\
Each stack also increases damage taken by |cffffffffSerpent Beam|r by (.-)%%%.%s*$"},
    [524859]={"^Critical strikes with |cFFFFFFFFGavels|r or |cFFFFFFFFDawnbreak|r now increases the healing of your next |cFFFFFFFFIllumination|r within (.-) by (.-)%%, stacking up to (.-) times%.\
\
Consuming the stacks increases your critical block chance and movement speed by (.-)%% for (.-)%.%s*$"},
    [524902]={"^Increases the targets damage taken from your periodic effects by (.-)%% stacking (.-) times%.%s*$"},
    [524931]={"^Whenever you block an attack your Strength and Stamina are increased by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [524942]={"^Procs Felglare on enemies hit by Rain of Chaos while recently used felglare aura is active on you%s*$"},
    [524946]={"^Increases attack power by (.-) for (.-)%.%s*$"},
    [524967]={"^See into the future, causing your direct critical strikes to grant your next spell (.-)%% increased haste for (.-)%.%s*$"},
    [524981]={"^While standing in your |cffffffffStandard of Valiance|r, your allies' Physical damage taken is reduced by (.-)%%%.%s*$"},
    [525043]={"^While standing in your |cffffffffStandard of Valiance|r, allies have a (.-)%% increased chance to resist stun and grip effects%.%s*$"},
    [527875]={"^Increasess the critical strike chance and critical damage of |cffffffffSerpent's Fang|r by (.-)%% against |cff00ff00Poisoned|r targets%.%s*$"},
    [536217]={"^Blocking an attack allows your next |cFFFFFFFFStarsunder|r to hit an additional nearby enemy and cost (.-)%% less mana%.%s*$"},
    [536221]={"^Increases the range of |cffffffffBlade of the Empire|r, |cffffffffNetherstrike|r, and |cFFFFFFFFHammer of Twilight|r by (.-) yds and reduces their mana costs by (.-)%% for (.-)%.%s*$"},
    [545464]={"^Casting |cFFFFFFFFKeleseth's Calamity|r causes your next |cFFFFFFFFVampiric Fang|r within (.-) to affect (.-) additional enemies but heal for (.-)%% less%.%s*$"},
    [553270]={"^Castng |cFFFFFFFFMurder|r increases the damage of the next |cFFFFFFFFCrow's Harvest|r, |cffffffffDark Fate|r, and |cffffffffRed Wake|r by (.-)%% for (.-)%.%s*$"},
    [553279]={"^Damage dealt by |cffffffffMeatsaw|r now increases the damage dealt by subsequent |cffffffffMeatsaws|r by (.-)%% and reduces its global cooldown by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [555724]={"^|cffffffffSeismic Crash|r now increases the chance for allies to hit with all spells against the enemy by (.-)%% for (.-)%.%s*$"},
    [560089]={"^Increases critical strike chance of your |cffffffffSargeron Smite|r by (.-)%% and its damage dealt by (.-)%%%.%s*$"},
    [560097]={"^Increases all party and raid member's melee and ranged haste by (.-)%%%.\
\
Does not stack with similar effects%.%s*$"},
    [560120]={"^Increases your Magic Damage dealt by (.-)%%%.%s*$"},
    [560210]={"^Periodic damage dealt by |cffffffffTormentor Bolt|r now has a (.-)%% chance to reduce the cost of your next ability by (.-)%% for (.-)%.%s*$"},
    [560237]={"^PLACEHOLDER\
\
|cFFFFFFFF%(Combo%)|r After using |cffffffffTwin Slice|r: |cffffffffFelrend|r or |cffffffffDoomscar|r now reduces your damage taken by (.-)%% for (.-)%.%s*$"},
    [560251]={"^Increases the critical strike chance of |cffffffffValanar's Vengeance|r and |cffffffffKeleseth's Calamity|r by (.-)%%%.%s*$"},
    [560361]={"^Rend an enemy dealing (.-)%% Weapon Damage plus (.-), causing you to apply a dark shield to them that absorbs the next (.-) healing done to them for (.-), and generates Runic Power%.%s*$"},
    [560407]={"^Dealing damage to targets affected by |cffffffffMassacre|r deals an additional (.-)%% Weapon Damage%. Lasts (.-)%.%s*$"},
    [560443]={"^|cffffffffBrutal Swing|r and |cffffffffSavage Smash|r increase the damage of your next |cffffffffWrecker|r by (.-)%% for (.-)%.%s*$"},
    [560448]={"^Melee auto attacks now a (.-)%% chance to reset the cooldown of |cffffffffSavage Strike|r and increase the damage of your next |cffffffffSavage Strike|r, within (.-), by (.-)%%%.%s*$"},
    [560497]={"^|cffffffffCrow's Harvest|r increases the duration of |cffffffffHarvest Time|r by (.-) sec%.%s*$"},
    [560511]={"^Increases Nature damage dealt by (.-)%%%.%s*$"},
    [560519]={"^Charge an enemy dealing (.-) Physical damage and rooting them for (.-), then leap backwards%.%s*$"},
    [560530]={"^Drop the |cFFFFFFFFClanlord's Totem|r at the target location where it will remain for (.-)%.\
\
The totem emanates an aura for (.-), causing allied players within (.-) yds to deal (.-) additional damage as Frost damage when they deal direct damage and gain (.-)%% increased honor%.\
\
Applies |cFFFFFFFFExhaustion|r, preventing you from benefiting from similar effects for (.-)%.%s*$"},
    [560553]={"^Charge an enemy dealing (.-) Physical damage and rooting them for (.-), then leap backwards%.%s*$"},
    [560570]={"^|cffffffffDawnsear|r increases the damage dealt by |cffffffffSun Ray|r by (.-)%%, stacking (.-) times, for (.-)%.\
\
After using |cffffffffSunray|r, your next |cffffffffDawnsear|r is instant cast%.%s*$"},
    [560591]={"^You shift into your ghostly form whenever you enter |cffffffffUnderwalk or Realm of Darkness|r, gaining (.-)%% increased movement speed%.%s*$"},
    [560606]={"^Increases the damage of |cffffffffIcequake|r and |cffffffffWinds of Northrend|r by (.-)%%%.%s*$"},
    [560608]={"^Activate a |cffffffffFetid Ward|r on yourself and your Undead minions for (.-)%.\
\
While active, your maximum Runic Power and mana is increased by (.-)%% and the duration of stun effects on you is reduced by (.-)%%%.%s*$"},
    [560619]={"^|cFFFFFFFFLichplague|r now deals (.-)%% more damage per Necromancer disease active on the target%.%s*$"},
    [560632]={"^Increases your critical damage by (.-)%% against |cff3399ffFrozen|r targets%.%s*$"},
    [560682]={"^Increases the damage of the |cffffffffUnleash|r effect of |cffffffffPestilence of Apocalypse|r by (.-)%% and its duration is increased by (.-) sec%.%s*$"},
    [560685]={"^Damage dealt by |cffffffffGore|r and |cffffffffMeatsaw|r now increases your target's damage taken from |cffffffffSkulltaker|r and |cffffffffWarbringer|r by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [560834]={"^Casting abilities that grant an |cffffffffOath|r now increases your damage dealt and movement speed by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [560845]={"^After using |cffffffffCommand: Grave Mage|r, your next cast of |cffffffffLichfrost|r within (.-) hits additional (.-) enemies%.%s*$"},
    [560858]={"^Reduces the cast time and mana cost of |cFFFFFFFFDawnsear|r and |cFFFFFFFFSunflare|r by (.-)%%%.%s*$"},
    [560941]={"^Direct damage dealt by |cffffffffQuick Shot|r, |cffffffffWhipvine Arrow|r, and |cffffffffSkullpiercer|r reduce the cooldown of |cffffffffFalcon's Call|r by (.-) sec%.%s*$"},
    [561025]={"^|cffffffffVampiric Fang|r now increases the damage of your next |cffffffffLifedrinker|r by (.-)%%, but reduces its healing by (.-)%%, for (.-)%.%s*$"},
    [561094]={"^You now gain Intellect equal to your Strength%.%s*$"},
    [561105]={"^Launch radiant spheres at an enemy each dealing (.-) Holyflame Damage, repeating every (.-) sec for (.-)%.%s*$"},
    [570028]={"^Increases the damage of |cffffffffHorusath Blast|r and |cffffffffRapture|r by (.-)%%%.%s*$"},
    [570066]={"^Damage dealt by |cffffffffShadow Puppets|r now increases your damage and critical strike chance by (.-)%% for (.-), stacking up to (.-) times%.\
\
Additional procs do not refresh the duration%.%s*$"},
    [570068]={"^|cffffffffReprisal|r now regenerates an additional (.-) Energy%.%s*$"},
    [570106]={"^Casting |cFFFFFFFFBreath of the North|r now grants you (.-)%% melee attack speed, plus an additional (.-)%% when using a two%-handed weapon, for (.-)%.%s*$"},
    [570135]={"^When |cffffffffCrypt Plague|r expires your spell haste is increased by (.-)%% for (.-)%.%s*$"},
    [570147]={"^|cFFFFFFFFThis spell belongs to |r|cFFF58CBASun Cleric|r\
\
Afflict the target for (.-), accumulating (.-)%% of Holy damage dealt by members of your party or raid and (.-)%% of Holy damage you deal%.\
\
When the effect ends, the stored damage is unleashed as Holy damage to enemies within (.-) yds%.%s*$"},
    [570153]={"^Reduces the cast time of |cffffffffShadra's Prayer|r by (.-)%% and your spell pushback suffered from damaging attacks by (.-)%%%.%s*$"},
    [570222]={"^Casting |cFFFFFFFFBreath of the North|r now grants you (.-)%% melee attack speed, plus an additional (.-)%% when using a two%-handed weapon, for (.-)%.%s*$"},
    [570227]={"^Coat your weapon in a freezing toxin, giving auto attacks a (.-)%% chance to reduce the target's movement speed and attack speed by (.-)%% for (.-)%.%s*$"},
    [570244]={"^Coat your weapon in nerve venom, giving auto attacks a (.-)%% chance to deal (.-) Nature Damage and reduce your target's casting speed by (.-)%% for (.-)%.%s*$"},
    [570245]={"^Coat your weapon in a burning toxin, giving auto attacks a (.-)%% chance to deal (.-) Fire Damage%.%s*$"},
    [570339]={"^|cffcc99ffDepletes All Static|r\
Call down a terrible beam of lightning upon an enemy, dealing (.-) Nature damage and stunning them for (.-)%.\
\
Damage and cast time increased based on |cffcc99ffStatic|r level%.%s*$"},
    [570762]={"^Place a keg on the ground for (.-) that allies can use to restore their health and mana%.\
\
Entering combat or moving while drinking from the keg will end the effect%.%s*$"},
    [572050]={"^Blast an enemy with the power of the sun, dealing (.-) Holy damage and reducing their attack power by (.-) for (.-)%.%s*$"},
    [572055]={"^Increases the damage dealt by |cFFFFFFFFVenom Fang|r by (.-)%% and causes it to increase the target's chance to be critically struck by spells by (.-)%% for (.-)%.%s*$"},
    [572058]={"^Spray poison on an enemy and all enemies near them, dealing (.-) Nature damage and reducing their attack speed by (.-)%% for (.-)%.%s*$"},
    [572066]={"^Place a keg on the ground for (.-) that allies can use to restore their health and mana%.\
\
Entering combat or moving while drinking from the keg will end the effect%.%s*$"},
    [572106]={"^Periodic damage dealt with |cffffffffSerrated Shot|r and |cFFFFFFFFToxic Dart|r now increases the damage of your next |cFFFFFFFFPrecision Shot|r within (.-) by (.-)%%, stacking (.-) times%.%s*$"},
    [572179]={"^Swing at enemies around you in a fury of souls, dealing (.-) Shadowfrost Damage, reducing their melee and ranged attack speed by (.-)%% for (.-), and generating Runic Power%.%s*$"},
    [572334]={"^Transforms your |cffffffffMalefic Wrath|r into |cffffffffMalefic Arrow|r%.%s*$"},
    [572371]={"^Casting |cffffffffBoulder Dash|r or |cffffffffBramblepatch|r now causes your next |cFFFFFFFFGeode Barrage|r within (.-) to be instant cast%.%s*$"},
    [572724]={"^Reduces the cast time of |cFFFFFFFFLichfrost|r by (.-)%% for (.-)%.%s*$"},
    [572726]={"^Reduces the cast time of |cFFFFFFFFLichfrost|r by (.-)%% for (.-)%.%s*$"},
    [572767]={"^|cffffffffSerpent's Fang|r now increases the damage of subsequent |cFFFFFFFFSerpent's Fangs|r by (.-)%% for (.-), stacking up to (.-) times%.%s*$"},
    [572805]={"^Dealing damage with |cFFFFFFFFCrypt Swarm|r now has a (.-)%% chance to reduce the cost of |cFFFFFFFFCommand: Gargoyle|r by (.-)%% for (.-)%.%s*$"},
    [573202]={"^Periodic damage dealt with |cffffffffSerrated Shot|r and |cFFFFFFFFToxic Dart|r now increases the damage of your next |cFFFFFFFFPrecision Shot|r within (.-) by (.-)%%, stacking (.-) times%.%s*$"},
    [573311]={"^Casting |cFFFFFFFFGaze of C'thun|r now has a (.-)%% chance to cause your |cFFFFFFFFTentacles|r to blast the enemy with eldritch energy, dealing (.-) Shadow damage%.%s*$"},
    [573312]={"^Casting |cFFFFFFFFGaze of C'thun|r now has a (.-)%% chance to cause your |cFFFFFFFFTentacles|r to blast the enemy with eldritch energy, dealing (.-) Shadow damage%.%s*$"},
    [574137]={"^Increases the damage of |cffffffffSkullpiercer|r and |cffffffffPrecision Shot|r by (.-)%%%.%s*$"},
    [575029]={"^Increases critical damage dealt by |cffffffffWidow's Kiss|r, |cFFFFFFFFWidowmaker|r and |cFFFFFFFFVenom Fang|r by (.-)%% against |cff00ff00Poisoned|r targets%.%s*$"},
    [575834]={"^Envelop an ally in moonwell waters, healing them for (.-)%.\
\
|cffffffffLunar Eclipse|r: This spell is instant and heals the ally for an additional (.-)%% of their maximum health%.%s*$"},
    [578296]={"^Damage dealt by |cFFFFFFFFSpirit In a Bottle|r causes the enemies to take (.-)%% more damage and deal (.-)%% less damage for (.-)%.%s*$"},
    [579322]={"^Dealing Shadow damage now increases the damage the target takes from your |cffffffffSkeletal Warriors|r by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [582257]={"^Each tick of |cFFFFFFFFHex of Malice|r increases the damage of the next tick on the enemy by (.-)%%, stacking (.-) times%.%s*$"},
    [584235]={"^Your damage dealt now increases the haste of your |cffffffffAir Elemental|r by (.-)%% for (.-), stacking (.-) times%.\
\
Damage dealt by your |cffffffffAir Elemental|r now increases your haste by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [584237]={"^Your damage dealt now increases the haste of your |cffffffffAir Elemental|r by (.-)%% for (.-), stacking (.-) times%.\
\
Damage dealt by your |cffffffffAir Elemental|r now increases your haste by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [628326]={"^Casting |cffffffffUnmake|r now increases your critical strike chance by (.-)%% and the damage of |cFFFFFFFFChromatic Spike|r by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [672335]={"^Critical strikes with |cffffffffRepair Shot|r now apply a heal over time effect, healing for (.-) every (.-) sec for (.-)%.%s*$"},
    [673335]={"^Critical strikes with |cffffffffRepair Shot|r now apply a heal over time effect, healing for (.-) every (.-) sec for (.-)%.%s*$"},
    [680205]={"^Causes |cffffffffFist of Xoroth|r to deal (.-) Physical Damage to all enemies within (.-) yds%.%s*$"},
    [680218]={"^Increases the damage of |cffffffffInfernal Strike|r by (.-)%%%.%s*$"},
    [680243]={"^Increases your ranged haste by (.-)%%%.%s*$"},
    [680324]={"^Your |cffffffffSerpent's Fang|r now refreshes a charge of |cffffffffAlkahest|r%.%s*$"},
    [680391]={"^Casting |cFFFFFFFFFortify Timeline|r now extends the duration of |cFFFFFFFFAccelerated Recovery|r on all targets within (.-) yds by an additional (.-) sec%.%s*$"},
    [680467]={"^Increases the damage of |cFFFFFFFFShadowflare|r by (.-)%%%.%s*$"},
    [680483]={"^Auto attacks while wielding a two%-handed weapon now have a (.-)%% chance to unleash |cffffffffGrasp of the Undying|r, leeching (.-) health from the target%.%s*$"},
    [680495]={"^Reduces damage taken by (.-)%% at all times and the cooldown of |cffffffffDeathless Resolve|r by (.-) sec%.%s*$"},
    [680568]={"^Your next |cffffffffHorusath Blast|r will deal (.-) additional Fire Damage%.%s*$"},
    [680642]={"^Critical strikes with |cFFFFFFFFGavels|r or |cFFFFFFFFDawnbreak|r now increases the healing of your next |cFFFFFFFFIllumination|r within (.-) by (.-)%%, stacking up to (.-) times%.\
\
Consuming the stacks increases your critical block chance and movement speed by (.-)%% for (.-)%.%s*$"},
    [680655]={"^Activating |cFFFF9800Dawn|r now causes your next |cffffffffHorusath Blast|r to strike up to (.-) enemies near the primary target for (.-)%.%s*$"},
    [680681]={"^Hurl a bolt of blood at an enemy, dealing (.-) Shadow Damage and granting |cffffffffThirst|r%.%s*$"},
    [680744]={"^Damage dealt by your |cffffffffAtherann's Anguish|r now causes enemies hit to bleed, dealing (.-) Shadow damage over (.-)%.%s*$"},
    [680802]={"^Critical strikes with |cffffffffMoon Arrow|r increase your melee and ranged haste by (.-)%% for (.-)%.%s*$"},
    [680850]={"^|cFFFFFFFFKeleseth's Calamity|r allows you to cast |cFFFFFFFFSanguine Rupture|r during |cFFFFFFFFLifedrinker|r for (.-)%.\
\
While this effect holds, |cFFFFFFFFSanguine Rupture|r  generates no Rage or |cFFFFFFFFThirst|r%.%s*$"},
    [680901]={"^|cffffffffMelt|r now increases the damage your target takes from |cffffffffFlames of Xoroth|r and |cffffffffSkulltaker|r by (.-)%%%.%s*$"},
    [680937]={"^|cffffffffNanobot Reconstruction|r now applies |cffffffffPreventative Medicine|r to the target, removing (.-) poison and curse effects from the target every (.-) sec%.%s*$"},
    [680945]={"^Burns an enemy for (.-) Fire Damage every (.-) sec for (.-)%.\
\
Using |cffffffffFirefall|r or |cffffffffLava Shard|r against the target extends the duration of |cffffffffScalding Brand|r by (.-) sec%.%s*$"},
    [680947]={"^Casting |cFFFFFFFFMelt Reality|r now causes your next |cffffffffUnmake|r or |cffffffffReverse Wound|r within (.-) to become instant and cost (.-)%% less mana%.%s*$"},
    [680955]={"^Reduces the cooldown of |cffffffffTestament of Faith|r by (.-) sec and the duration of |cffffffffSacred Restraint|r by (.-) sec%.%s*$"},
    [680979]={"^Damage dealt by |cffffffffGore|r and |cffffffffMeatsaw|r now increases your target's damage taken from |cffffffffSkulltaker|r and |cffffffffWarbringer|r by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [680998]={"^While in your |cffffffffMechsuit|r, casting |cffffffffSticky Bomb|r reduces the channel time of your next |cffffffffGatling Gun|r within (.-) by (.-)%%%.%s*$"},
    [681050]={"^|cffffffffMycosis|r now increases your critical strike chance with periodic effects by (.-)%% for (.-)%.%s*$"},
    [681067]={"^Increases the amount that |cffffffffVoid Shield|r absorbs by (.-)%%%.\
\
Absorbing damage grants you (.-)%% of the absorbed value as spell power for (.-)%.%s*$"},
    [681074]={"^Damage dealt by |cffffffffClaw Sweep|r and |cffffffffSanguine Rupture|r fling blood shards causing them to bleed for (.-) Shadowstrike Damage every (.-) sec for (.-)%.%s*$"},
    [681147]={"^PLACEHOLDER\
\
Teaches a new |cFFFFFFFFCombo|r%.\
\
|cFFFFFFFF%(Combo%)|r After using |cffffffffFelwrath|r or |cffffffffSargeron Smite|r: Your next |cffffffffFel Fireball|r, within (.-), is instant cast and costs no Energy%.%s*$"},
    [681182]={"^Unleash a quick shot, dealing (.-)%% Ranged Weapon Damage plus (.-) Physical damage and generates Rage%.\
\
Only usable after critically striking with an ability%.%s*$"},
    [681321]={"^Casting |cffffffffGreen Salve|r now resets the cooldown of |cffffffffSerpent's Fang|r and removes the cost of your next |cffffffffSerpent's Fang|r for (.-)%.%s*$"},
    [681506]={"^|cFFFFFFFFSolar Conquest|r causes your |cFFFFFFFFIllumination|r to heal an additional nearby ally for (.-)%.\
\
|cFFFFFFFFIllumination|r reduces the cooldown of Solar Conquest by (.-) sec%.%s*$"},
    [681789]={"^|cFFFFFFFFSolar Conquest|r causes your |cFFFFFFFFIllumination|r to heal an additional nearby ally for (.-)%.\
\
|cFFFFFFFFIllumination|r reduces the cooldown of Solar Conquest by (.-) sec%.%s*$"},
    [704094]={"^Increases the damage of |cffffffffSeismic Crash|r by (.-)%% and |cffffffffEarthquake|r by (.-)%%%.%s*$"},
    [704156]={"^|cFFFFFFFFPotion Toss|r now increases the healing of your |cFFFFFFFFLoa's Brew|r by (.-)%% for (.-)%.%s*$"},
    [704172]={"^|cffffffffFalcon's Dive|r, |cffffffffFalconstrike|r, and |cffffffffFalcon's Call|r make your next |cffffffffRanger's Horn|r trigger no cooldown%.%s*$"},
    [704188]={"^Increases your damage and critical strike chance by (.-)%% and gives your spells that require |cff5ee2ffSoul Infusion|r a (.-)%% to not consume the effect for (.-)%.%s*$"},
    [704194]={"^Impale an enemy with blood spikes, dealing (.-) Shadowstrike Damage, and then begin a furious assault for up to (.-)%.\
\
Every (.-) sec, leech (.-) health, trigger |cffffffffCall of the Darkwing|r, and apply |cffffffffEndless Thirst|r%.%s*$"},
    [704283]={"^Desolate damage increased by (.-)%%%. Healing taken increased by (.-)%%%.%s*$"},
    [704339]={"^Dealing direct Fire Damage reduces the remaining cooldown of |cffffffffHorusath Blast|r by (.-) sec%.%s*$"},
    [704508]={"^Periodic damage dealt now grants |cffffffffTotem of Hir'eek|r, causing your next |cffffffffBatscreech Blast|r, |cFFFFFFFFGift of The Loa|r or |cffffffffHex of Death|r cooldown to be reduced by (.-)%%, stacking (.-) times%.%s*$"},
    [704748]={"^Summons a |cFFFFFFFFBubble Buddy|r for (.-)%.\
\
While you channel |cffffffffTorrent|r, the |cFFFFFFFFBubble Buddy|r will mimic it (.-) yds in front of you, facing the inverse of your orientation%.%s*$"},
    [704865]={"^Gives |cffffffffLava Shard|r a (.-)%% chance to cause your Phoenix to heal allies within (.-)yd of it for (.-)%.%s*$"},
    [705043]={"^The first |cffffffffWild Strike|r while |cffffffffCounterblades|r is active stuns the target for (.-)%.%s*$"},
    [705146]={"^Triggering |cFFFFFFFFDancing Blades|r now increases the damage of next |cFFFFFFFFSargeron Smite|r by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [705231]={"^Increases your healing done by (.-)%% and the damage and healing of your |cffffffffSanguine Rupture|r by (.-)%%%.%s*$"},
    [705422]={"^Every (.-) sec, gain (.-)%% increased damage to your next |cFFFFFFFFDoomrend|r or |cFFFFFFFFRed Wake|r, stacking up to (.-) times%.%s*$"},
    [705574]={"^Causes |cffffffffManastrike|r to reduce the remaining cooldown of |cffffffffSpellblades|r by (.-) sec%.%s*$"},
    [705582]={"^|cffffffffPhase Out|r now increases your movement speed by (.-)%% for (.-)%.%s*$"},
    [705676]={"^Reduces the duration of incapacitate and disorient effects by (.-)%%%.%s*$"},
    [705751]={"^Dealing Magic damage now has a (.-)%% chance to increase your haste by (.-)%% for (.-)%.%s*$"},
    [705834]={"^Using |cffffffffReload|r or swapping |cffffffffRounds|r now increases haste by (.-)%% for (.-)%.%s*$"},
    [705837]={"^Increases the damage dealt by your summoned creatures within (.-) yds by (.-)%%%.%s*$"},
    [705845]={"^Increases the spell power scaling of |cffffffffMalefic Wrath|r, |cffffffffShadowflare|r, and |cffffffffBad Juju|r by (.-)%%%.%s*$"},
    [705882]={"^|cffffffffHex of Death|r increases the damage and healing of your next |cffffffffBwonsamdi|r ability by (.-)%%%.%s*$"},
    [706029]={"^Your periodic healing done now increases the direct healing of your next |cffffffffShadra's Prayer|r or |cffffffffSerpent's Fang|r by (.-)%%, stacking (.-) times%.%s*$"},
    [706241]={"^Each subsequent shot of a |cFFFFFFFFWitchbane|r cast deals (.-)%% more damage, up to a maximum of (.-)%%%.%s*$"},
    [706381]={"^Your |cffffffffReclamations|r used on enemies tethered by |cffffffffMalefic Arrow|r now reduce the cooldown of |cffffffffMalefic Arrow|r and |cffffffffMimic|r by (.-) sec%.%s*$"},
    [706445]={"^|cffffffffRequires Mortal Form|r\
You use dark magic to rip an enemy's internal organs to shreds, causing them to Bleed for (.-) Shadow Damage every (.-) sec for (.-)%.\
\
Dealing direct Shadow Damage to the enemy target will extend the duration of the Bleed effect by (.-) sec%.%s*$"},
    [706448]={"^|cffffffffRequires Mortal Form|r\
You use dark magic to rip an enemy's internal organs to shreds, causing them to Bleed for (.-) Shadow Damage every (.-) sec for (.-)%.\
\
Dealing direct Shadow Damage to the enemy target will extend the duration of the Bleed effect by (.-) sec%.%s*$"},
    [706541]={"^Your |cffffffffReclamations|r used on enemies tethered by |cffffffffMalefic Arrow|r now reduce the cooldown of |cffffffffMalefic Arrow|r and |cffffffffMimic|r by (.-) sec%.%s*$"},
    [706620]={"^Increases the critical strike chance of |cffffffffValanar's Vengeance|r and |cffffffffKeleseth's Calamity|r by (.-)%%%.%s*$"},
    [706736]={"^Increases the cooldown of |cffffffffSpeed Rune|r by (.-) sec, but it now applies stealth to allies who walk on the pathway for the duration%.%s*$"},
    [706838]={"^All nearby allies receive (.-)%% more healing%. Does not stack with similar effects%.\
\
In addition, your |cffffffffAlarm Beacon|r now dispels fear, charm, and sleep effects from (.-) additional ally%.%s*$"},
    [706845]={"^Damage dealt by your Undead minions now has a (.-)%% chance to increase their critical strike chance by (.-)%% for (.-)%.%s*$"},
    [706874]={"^Damage dealt by |cffffffffLava Shard|r now applies |cffffffffInfernus|r, causing enemies to |cffff4500Burn|r, dealing an additional (.-) Fire damage over (.-)%.%s*$"},
    [706934]={"^Damage dealt by |cffffffffLava Shard|r now applies |cffffffffInfernus|r, causing enemies to |cffff4500Burn|r, dealing an additional (.-) Fire damage over (.-)%.%s*$"},
    [706949]={"^Dealing Shadow damage now increases the damage the target takes from your |cffffffffSkeletal Warriors|r by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [707119]={"^Casting |cFFFFFFFFHorrorbolt|r now increases the damage of your next |cFFFFFFFFWrath of the Black Empire|r by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [707193]={"^Increases the healing absorbed by |cFFFFFFFFDoomrend|r by (.-)%%%.%s*$"},
    [707251]={"^Shoot an enemy, dealing (.-)%% Ranged Weapon Damage plus (.-) as Fire Damage, restoring (.-) mana, and reducing the cooldown of |cFFFFFFFFBuild: Spider Bomb|r by (.-) sec%.\
\
Scales with modifiers to |cffffffffScrap Shot|r%.%s*$"},
    [707268]={"^Damage dealt by |cffffffffSticky Bomb|r now applies a |cffffffffSticky Charge|r to enemies that explodes after (.-), dealing (.-) Physical Damage%.%s*$"},
    [707279]={"^Your |cffffffffBlaze|r now strikes an additional enemy near the primary target%.%s*$"},
    [707281]={"^Your |cffffffffBlaze|r now strikes an additional enemy near the primary target%.%s*$"},
    [707282]={"^Increases the targets damage taken from your periodic effects by (.-)%% stacking (.-) times%.%s*$"},
    [707307]={"^(.-)%% of all damage taken by the target is redirected to the Templar%.%s*$"},
    [707358]={"^Harmful spells cast out of |cFFFFFFFFSkulk|r increase the damage you deal to the enemy by (.-)%% for (.-)%.%s*$"},
    [707360]={"^Increases the critical strike chance of |cffffffffFel Fireball|r by (.-)%% and it's damage dealt now reduces the enemy's chance to hit by (.-)%% for (.-)%.%s*$"},
    [707507]={"^Reduces the Physical Damage the enemies deal by (.-)%% for (.-)%.%s*$"},
    [707609]={"^Periodic damage dealt has a (.-)%% chance to increase spell haste by (.-)%% for (.-)%.%s*$"},
    [712363]={"^Your |cffffffffBlaze|r now strikes an additional enemy near the primary target%.%s*$"},
    [712397]={"^Reduces the Physical Damage the enemies deal by (.-)%% for (.-)%.%s*$"},
    [712425]={"^Increases the duration and reduces the Energy cost of |cffffffffBanes|r by (.-)%%%.%s*$"},
    [800001]={"^Smash an enemy and up to (.-) enemies with your claw, dealing (.-) Nature damage, scaling with your Stamina%.\
\
Generates (.-) Rage%.%s*$"},
    [800090]={"^|cffffffffAssault|r now reduces healing done to the target by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [800173]={"^Rend an enemy dealing (.-)%% Weapon Damage plus (.-), causing you to apply a dark shield to them that absorbs the next (.-) healing done to them for (.-), and generates Runic Power%.%s*$"},
    [800608]={"^Hurl a burning hammer at an enemy that inflicts (.-) Holyflame damage and Slows the target's Movement Speed by (.-)%% for (.-)%.\
\
If the target is affected by Purging Flames, reset the cooldown of Glorious Execution and generate (.-) Rage%.%s*$"},
    [800621]={"^You |cfffeff9eSummon|r a magical barrier of sunlight that will |cffb0f67aAbsorb|r (.-) damage dealt against yourself and all party and raid members within (.-) yards%.\
\
Lasts until destroyed%.%s*$"},
    [800629]={"^A nearby Standard of Valiance is damaging you and slowing your movement speed%.%s*$"},
    [800679]={"^Deals (.-) Shadow Damage to up to (.-) enemies, and an additional (.-) Shadow Damage every (.-) sec for (.-)%.   For the same duration, the target takes (.-)%% increased damage from |cffffffffHoundmaster's Call|r%.%s*$"},
    [800743]={"^Shifts (.-)yd toward the Runemaster and deals massive Arcane Damage to enemies you pass through%.%s*$"},
    [800753]={"^Critical damage taken reduces the cooldown of |cFFFFFFFFRune of Guarding|r by (.-)%%%.%s*$"},
    [800769]={"^Increases the critical strike chance of your Fire Blast, Scorch, Arcane Blast and Cone of Cold spells by (.-)%%%.%s*$"},
    [801060]={"^Reduces damage taken by (.-)%%%. Lasts (.-) sec for each stack consumed%.\
\
While the shield holds, enemies who strike you will take Fire damage, scaling with each |cffff9933Demonfire|r stack consumed%.%s*$"},
    [801338]={"^Reduces an enemy's chance to hit by (.-)%% and increases their Nature Damage taken from you by (.-)%% for (.-)%.\
\
Dispelling this effect increases the dispeller's resource costs by (.-)%% for (.-)%.%s*$"},
    [801404]={"^|cffffffffAnimate: Frost Whelp|r and damage dealt by your |cffffffffFrost Wyrm|r now deals (.-) Frost Damage every (.-) sec for (.-)%.\
\
Damage dealt counts as a bleed effect%.%s*$"},
    [801728]={"^Launch a chain of frost at an enemy, dealing (.-) Frost Damage every (.-) sec for (.-)%.\
\
Each tick generates (.-) Runic Power%.%s*$"},
    [802038]={"^Fire a serrated arrow at an enemy, causing them to bleed for (.-) Physical damage, repeating every (.-) sec for (.-)%.\
\
Duration increased by (.-) sec per stack of |cff8fff7aAdvantage|r%.%s*$"},
    [802084]={"^Siphon life from your undead minions, sacrificing (.-)%% of their health to grant yourself an absorb shield equal to half of the health stolen for (.-)%.\
\
Usable while stunned%.%s*$"},
    [802106]={"^Siphon life from your undead minions, sacrificing (.-)%% of their health to grant yourself an absorb shield equal to half of the health stolen for (.-)%.\
\
Usable while stunned%.%s*$"},
    [802145]={"^|cFFFFFFFFThis spell belongs to |r|cFFF58CBASun Cleric|r\
\
Shift (.-) yds forward at light speed, removing all root effects%.\
\
This leaves behind a |cffffffffSun Gate|r for (.-) that allies can interact with to blink themselves the same distance forward%. Allies can only use |cffffffffSun Gate|r every (.-)%.%s*$"},
    [802333]={"^Consumes your Foul Remnant stacks to raise a Plaguefather to aid you in combat for (.-)%. Duration increased based on stacks consumed%.\
\
Plaguefathers do not occupy any Life Force%.%s*$"},
    [802598]={"^Your |cffffffffIllumination|r now shields you for (.-)%% of the amount healed%.%s*$"},
    [802599]={"^Your next |cffffffffIllumination|r within (.-) is instant cast and free of cost%.%s*$"},
    [802648]={"^Damage dealt with |cffffffffElemental Burst|r and |cffffffffPrimordial Blast|r now has a (.-)%% chance to reset the cooldown of |cffffffffFrigid Blast|r and make its next use within (.-) instant cast%.%s*$"},
    [802729]={"^Casting |cFFFFFFFFGaze of C'thun|r now has a (.-)%% chance to cause your |cFFFFFFFFTentacles|r to blast the enemy with eldritch energy, dealing (.-) Shadow damage%.%s*$"},
    [802750]={"^Crush an enemy with the weight of the winds, dealing (.-) Nature Damage to them and then an additional time for (.-)%% of the damage dealt after (.-)%.%s*$"},
    [802805]={"^Launch a chain of frost at an enemy, dealing (.-) Frost Damage every (.-) sec for (.-)%.\
\
Each tick generates (.-) Runic Power%.%s*$"},
    [803153]={"^You phase your physical form for (.-), causing all spells to miss against you%.%s*$"},
    [804039]={"^Reduces the cooldown of your |cFFFFFFFFCloudburst|r and |cFFFFFFFFWindsurf|r by (.-)%%%.%s*$"},
    [804100]={"^Shoot an enemy, dealing (.-)%% Ranged Weapon Damage plus (.-) as Fire Damage, restoring (.-) mana, and reducing the cooldown of |cFFFFFFFFBuild: Spider Bomb|r by (.-) sec%.\
\
Scales with modifiers to |cffffffffScrap Shot|r%.%s*$"},
    [804132]={"^|cFFFFFFFFThis spell belongs to |r|cFFF58CBASun Cleric|r\
\
Become a champion of An'she, causing your melee auto attacks to deal an additional (.-)%% of the damage dealt as Holy damage%. Lasts (.-)%.%s*$"},
    [804258]={"^Bring a dead ally back to life with (.-) health and (.-) mana%.\
\
Can be used in combat%.%s*$"},
    [804271]={"^Adds (.-)%% to the bonuses that your stacks of |cff8fff7aAdvantage|r provide%.\
\
Additionally, increases the damage of |cffffffffFlank|r when used from behind by (.-)%%, and increases the range of |cffffffffFlank|r by (.-) yds%.%s*$"},
    [804536]={"^Channel a putrid beam, causing (.-) Plague damage every (.-) sec for (.-)%.%s*$"},
    [804656]={"^Increases periodic damage you deal to the target by (.-)%% for (.-)%.%s*$"},
    [804971]={"^Shadow and Nature damage dealt now has a (.-)%% chance to increase periodic damage you deal to the target by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [805122]={"^Increases the range of |cffffffffBlade of the Empire|r, |cffffffffNetherstrike|r, and |cFFFFFFFFHammer of Twilight|r by (.-) yds and reduces their mana costs by (.-)%% for (.-)%.%s*$"},
    [805182]={"^Heal for (.-)%% of your maximum health%.%s*$"},
    [805201]={"^Dealing damage to targets affected by |cffffffffMassacre|r deals an additional (.-)%% Weapon Damage%. Lasts (.-)%.%s*$"},
    [805207]={"^Increases the critical strike chance of |cffffffffDoomrend|r by (.-)%%%.%s*$"},
    [805458]={"^Increases the amount slowed by |cffffffffLichfrost|r by (.-)%%%.%s*$"},
    [805484]={"^Increases the critical strike chance and damage of |cffffffffLava Shard|r by (.-)%%%.%s*$"},
    [805566]={"^|cffffffffLunar Lance|r and |cffffffffUmbral Blade|r increase the enemy damage taken from |cFFFFFFFFScattered Stars|r by (.-)%% for (.-)%.%s*$"},
    [805582]={"^|cffffffffValkyrie Spear|r now makes you leap to your target and slow their movement speed by (.-)%% for (.-)%.%s*$"},
    [805636]={"^Increases the effectiveness of |cFFFFFFFFGavels|r and |cffffffffHorusath Blast|r and reduces their mana cost by (.-)%%%.%s*$"},
    [805725]={"^Casting |cffffffffThaumaturgy|r now grants you (.-)%% increased movement speed for (.-)%.%s*$"},
    [805742]={"^Hurl powerful elemental missiles at an enemy, dealing (.-) Elemental Damage every (.-) sec for (.-)%. Each missile grants you a |cFFFFFFFFGlyph|r%.\
\
Scales with modifiers to |cffffffffPrimordial Blast|r%.%s*$"},
    [805786]={"^Casting |cffffffffAnimate|r or |cff90ee90Command|r spells now increases your haste by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [805852]={"^Increases the critical strike chance of |cffffffffUnmake|r by (.-)%%%.%s*$"},
    [806000]={"^Shadow and Nature damage dealt now has a (.-)%% chance to increase periodic damage you deal to the target by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [806023]={"^Dealing Holy damage now reduces the cast time of |cffffffffHorusath Blast|r by (.-)%%, stacking (.-) times, for (.-)%.%s*$"},
    [806083]={"^Your Undead minions feast upon the parasites on hit, leeching (.-)%% of their damage dealt as Plague Damage to the target%.%s*$"},
    [806084]={"^Increases the tick rate of your next Necromancer disease by (.-)%%, stacking (.-) times%.%s*$"},
    [806085]={"^Increases the tick rate of your next Necromancer disease by (.-)%%, stacking (.-) times%.%s*$"},
    [806247]={"^Shields your spellcasting for (.-), granting Immunity to Interrupt effects and prevents pushback from taking damage while casting%.\
\
Usable while casting or channeling another spell%.%s*$"},
    [806313]={"^Using |cffffffffUnmake|r on an enemy affected by your |cffffffffTimerend|r now causes the enemy to erupt in a vortex of sand, dealing (.-) Chromatic Damage every (.-) sec to up to (.-) enemies for (.-) in an (.-) yd radius%.%s*$"},
    [806392]={"^Critical strikes now apply a stack of |cffffffffCrypt Plague|r%.%s*$"},
    [806399]={"^Heals a friendly target for (.-)%.%s*$"},
    [806470]={"^|cffffffffConsumes Flames of Focus|r\
Hurl spheres of molten slag at an enemy target for each stack consumed%.\
\
Each sphere causes (.-) Fire damage and slows their movement speed by (.-)%% for (.-)%. Stacks (.-) times%.%s*$"},
    [806588]={"^Casting |cffffffffCrypt Swarm|r now increases the damage of your minions by (.-)%% for (.-)%.%s*$"},
    [806649]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [806694]={"^|cFFFFFFFFThis spell belongs to |r|cFF0D2ED6Primalist|r\
\
Summon a totem that increases all stats of party and raid members by (.-) within (.-) yds for (.-)%.%s*$"},
    [806700]={"^Melee attacks now have a (.-)%% chance to reset the cooldown of |cffffffffGlorious Execution|r%.%s*$"},
    [807103]={"^Deals (.-) Shadow Damage every (.-) sec and reduces attack speed by (.-)%%%.%s*$"},
    [807112]={"^|cFFFFFFFFThis spell belongs to |r|cFF0070DEStormbringer|r\
\
Cover yourself in a barrier of volatile energy for (.-), causing all attacks against you to have a (.-)%% chance to deal half damage%.\
\
|cffffffffStormcloak|r has a (.-)%% chance to resist dispel effects%.%s*$"},
    [807180]={"^Damage of your next |cFFFFFFFFDestroyer's Maw|r increased by (.-)%% for (.-)%.%s*$"},
    [807181]={"^Damage of your next |cFFFFFFFFDestroyer's Maw|r increased by (.-)%% for (.-)%.%s*$"},
    [807308]={"^Melee ability damage now reduces the duration of |cffffffffWracked Mind|r by (.-) sec on all allies within (.-) yds%.%s*$"},
    [807685]={"^|cFFFFFFFFThis spell belongs to |r|cFF0D2ED6Primalist|r\
\
Summon a totem that increases all stats of party and raid members by (.-) within (.-) yds for (.-)%.%s*$"},
    [807722]={"^|cFFFFFFFFThis spell belongs to |r|cFFB5FFFFStarcaller|r\
\
Interrupt an enemy's current spell cast and prevents any spell in that school from being cast for (.-)%.%s*$"},
    [807853]={"^|cFFFFFFFFThis spell belongs to |r|cFFF58CBASun Cleric|r\
\
Become a champion of An'she, causing your melee auto attacks to deal an additional (.-)%% of the damage dealt as Holy damage%. Lasts (.-)%.%s*$"},
    [807880]={"^Melee attacks now have a (.-)%% chance to reset the cooldown of |cffffffffGlorious Execution|r%.%s*$"},
    [807881]={"^Melee attacks now have a (.-)%% chance to reset the cooldown of |cffffffffGlorious Execution|r%.%s*$"},
    [812317]={"^Resets the cooldown of |cffffffffChivalry|r and for (.-), your |cffffffffLine Formation|r deals (.-)%% increased damage and also deals its damage to enemies hit by |cffffffffPulverize|r%.\
\
In addition, restores (.-) Energy every (.-) sec%.%s*$"},
    [812319]={"^Resets the cooldown of |cffffffffChivalry|r and for (.-), your |cffffffffLine Formation|r deals (.-)%% increased damage and also deals its damage to enemies hit by |cffffffffPulverize|r%.\
\
In addition, restores (.-) Energy every (.-) sec%.%s*$"},
    [823553]={"^Allows you to use Immolation Aura outside of Metamorphosis, making it deal increased damage and enables its damage to critically strike, and makes it cause an initial explosion upon activation%.%s*$"},
    [823578]={"^Mark an enemy, increasing your critical strike chance against them by (.-)%%, increasing by (.-)%% every (.-) sec for (.-)%.\
\
For the duration, the enemy is unable to stealth%.%s*$"},
    [983248]={"^Siegebreaker Bonespear impale SLS%s*$"},
    [1143740]={"^Enhances your |cFFFFFFFFCycle of the Moon|r%.\
\
|cFFFFFFFFNew Moon:|r Healing done is increased by (.-)%%%.\
\
|cffffffffFull Moon:|r Cooldown of |cffffffffMoonflow|r is reduced by (.-) sec%.%s*$"},
    [1300180]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [1300181]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [1300182]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [1300183]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [1300184]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [1300185]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [1577830]={"^Reduces the cooldown of |cffffffffGravity Bomb|r by (.-) sec%.%s*$"},
    [2100083]={"^Beckon the dead, removing the cost and cast time of all |cFFFFFFFFRaise|r spells and |cffffffffAnimates|r for (.-)%.%s*$"},
    [2100084]={"^Beckon the dead, removing the cost and cast time of all |cFFFFFFFFRaise|r spells and |cffffffffAnimates|r for (.-)%.%s*$"},
    [2100085]={"^Beckon the dead, removing the cost and cast time of all |cFFFFFFFFRaise|r spells and |cffffffffAnimates|r for (.-)%.%s*$"},
    [2100086]={"^Beckon the dead, removing the cost and cast time of all |cFFFFFFFFRaise|r spells and |cffffffffAnimates|r for (.-)%.%s*$"},
    [2100767]={"^Beckon the dead, removing the cost and cast time of all |cFFFFFFFFRaise|r spells and |cffffffffAnimates|r for (.-)%.%s*$"},
    [2100768]={"^Beckon the dead, removing the cost and cast time of all |cFFFFFFFFRaise|r spells and |cffffffffAnimates|r for (.-)%.%s*$"},
    [2100769]={"^Beckon the dead, removing the cost and cast time of all |cFFFFFFFFRaise|r spells and |cffffffffAnimates|r for (.-)%.%s*$"},
    [2105747]={"^Your next |cffffffffHorusath Blast|r will deal (.-) additional Fire Damage%.%s*$"},
    [2107719]={"^Your next |cffffffffHorusath Blast|r will deal (.-) additional Fire Damage%.%s*$"},
    [2119050]={"^Your next |cffffffffHorusath Blast|r will deal (.-) additional Fire Damage%.%s*$"},
    [2119905]={"^Calls down a meteor from the sky%.%s*$"},
    [2135226]={"^Sends a bolt of dark magic at an enemy, inflicting (.-) Shadow damage%.%s*$"},
    [2135227]={"^Sends a bolt of dark magic at an enemy, inflicting (.-) Shadow damage%.%s*$"},
    [2136484]={"^Hurls a bolt of dark magic at an enemy, inflicting (.-) Shadow damage%.%s*$"},
    [2141418]={"^Calls down a pillar of flame that moves around randomly, burning everything in its path%.%s*$"},
    [2141419]={"^Calls down a pillar of flame that moves around randomly, burning everything in its path%.%s*$"},
    [2141420]={"^Calls down a pillar of flame that moves around randomly, burning everything in its path%.%s*$"},
    [2141421]={"^Calls down a pillar of flame that moves around randomly, burning everything in its path%.%s*$"},
    [2143961]={"^Hurls missiles of dark magic, inflicting Shadow damage to nearby enemies%.%s*$"},
    [2146315]={"^Hurls a bolt of dark magic at an enemy, inflicting (.-) Shadow damage%.%s*$"},
    [2300180]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [2300182]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [2300183]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [2300184]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [2300185]={"^Allows all of your spells to be cast while moving inside of the Manastorm%. \
\
Lasts for (.-)%.%s*$"},
    [3107719]={"^Your next |cffffffffHorusath Blast|r will deal (.-) additional Fire Damage%.%s*$"},
    [3135213]={"^Calls down a pillar of flame, burning all enemies in a selected area and inflicting additional damage every (.-) sec%. for (.-)%.%s*$"},
    [3135214]={"^Calls down a pillar of flame, burning all enemies in a selected area and inflicting additional damage every (.-) sec%. for (.-)%.%s*$"},
    [3135215]={"^Calls down a pillar of flame, burning all enemies in a selected area and inflicting additional damage every (.-) sec%. for (.-)%.%s*$"},
    [3135216]={"^Calls down a pillar of flame, burning all enemies in a selected area and inflicting additional damage every (.-) sec%. for (.-)%.%s*$"},
    [3136484]={"^Hurls a bolt of dark magic at an enemy, inflicting (.-) Shadow damage%.%s*$"},
    [3141418]={"^Calls down a pillar of flame that moves around randomly, burning everything in its path%.%s*$"},
    [3143961]={"^Hurls missiles of dark magic, inflicting Shadow damage to nearby enemies%.%s*$"},
    [9666668]={"^Transform into a |cFFFFFFFFFrost Lich|r, increasing spell haste by (.-)%%, and Magic Damage dealt by (.-)%% for (.-)%.\
\
For the duration, |cffffffffLichfrost|r costs (.-) less Runic Power and the duration of |cffffffffGlacial Shift|r is increased by (.-) sec%.%s*$"},
    [9666731]={"^Increases the amount slowed by |cffffffffLichfrost|r by (.-)%%%.%s*$"},
    [9666745]={"^Increases the amount slowed by |cffffffffLichfrost|r by (.-)%%%.%s*$"},
    [9931281]={"^|cFFFFFFFFSkullpiercer|r now increases the effectiveness of your next |cffffffffRanger Horn|r spell by (.-)%%%. Lasts (.-)%.%s*$"},
    [9931292]={"^Increases the critical damage of |cffffffffCenturion Strike|r and |cffffffffReprisal|r by (.-)%%%.%s*$"},
    [9931297]={"^Increases haste by (.-)%%%.%s*$"},
}
local tipIDs = {
    [888]={"^Dominating undead%.%s*$"},
    [2008]={"^Increases your spirit by (.-)%%%.%s*$"},
    [3233]={"^Allows Felglare to stack (.-) additional times%.%s*$"},
    [4352]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [4354]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [4362]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [7806]={"^Increases the damage of |cfffffffffInfernal Strike|r and |cffffffffFlames of Xoroth|r by (.-)%%%.%s*$"},
    [7807]={"^Increases the damage of |cfffffffffInfernal Strike|r and |cffffffffFlames of Xoroth|r by (.-)%%%.%s*$"},
    [7808]={"^Increases the damage of |cfffffffffInfernal Strike|r and |cffffffffFlames of Xoroth|r by (.-)%%%.%s*$"},
    [8435]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [9081]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [11103]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [12281]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [12318]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [12357]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [12358]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [12549]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [12812]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [12813]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [12814]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [12815]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [12857]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [12858]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [12860]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [12861]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [14057]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [14072]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [14158]={"^Restores mana%s*$"},
    [14159]={"^Restores mana%s*$"},
    [14887]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [15040]={"^Recently hit by a Molten Blast%.%s*$"},
    [15095]={"^Recently hit by a Molten Blast%.%s*$"},
    [15245]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [16418]={"^Being assaulted%s*$"},
    [16459]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [16565]={"^Wails with anguish, inflicting Shadow damage to an enemy%.%s*$"},
    [16594]={"^Being assaulted%s*$"},
    [16795]={"^Being assaulted%s*$"},
    [16868]={"^Wails with anguish, inflicting Shadow damage to an enemy%.%s*$"},
    [17171]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [17228]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [17788]={"^The caster has (.-)%% increased Critical Strike chance against this enemy%.%s*$"},
    [17789]={"^The caster has (.-)%% increased Critical Strike chance against this enemy%.%s*$"},
    [17790]={"^The caster has (.-)%% increased Critical Strike chance against this enemy%.%s*$"},
    [17791]={"^The caster has (.-)%% increased Critical Strike chance against this enemy%.%s*$"},
    [17792]={"^The caster has (.-)%% increased Critical Strike chance against this enemy%.%s*$"},
    [18126]={"^The demons of the Tainted Scar bear a portion of Kazzak's power%. Even as the Manastorm shifts and changes, that power is not likely to fade so easily%.%.%.%s*$"},
    [18127]={"^The demons of the Tainted Scar bear a portion of Kazzak's power%. Even as the Manastorm shifts and changes, that power is not likely to fade so easily%.%.%.%s*$"},
    [18147]={"^Damage taken from the Stormbringer increased by (.-)%%%. Movement speed reduced by (.-)%%%.\
\
Stacks up to (.-) times%.%s*$"},
    [18152]={"^Melee and ranged attacks drain the life force from the target%. \
\
Attacks reduce the target's stats and inflict additional |cff80528CShadow Damage|r\
\
Heals from damage inflicted%s*$"},
    [18220]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [18221]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [18649]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [18937]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [18938]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [19028]={"^(.-)%% of damage taken by master is taken by the demon instead%.%s*$"},
    [20299]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [20575]={"^Unable to stop moving%.%s*$"},
    [20576]={"^Unable to stop moving%.%s*$"},
    [20597]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [20609]={"^Increases your spirit by (.-)%%%.%s*$"},
    [20610]={"^Increases your spirit by (.-)%%%.%s*$"},
    [20741]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [20776]={"^Increases your spirit by (.-)%%%.%s*$"},
    [20777]={"^Increases your spirit by (.-)%%%.%s*$"},
    [21027]={"^You cannot trigger Conjure Storm on your target with Volt%.%s*$"},
    [21563]={"^Unable to stop moving%.%s*$"},
    [22665]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [22878]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [22945]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [24024]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [24682]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [25034]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [25586]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [25590]={"^Increases your spirit by (.-)%%%.%s*$"},
    [27265]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [27383]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [27646]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [27831]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [28135]={"^Damage taken from the Stormbringer increased by (.-)%%%. Movement speed reduced by (.-)%%%.\
\
Stacks up to (.-) times%.%s*$"},
    [28407]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [28448]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [28599]={"^Hurls missiles of dark magic, inflicting (.-) Shadow damage to nearby enemies%.%s*$"},
    [28993]={"^Wails with anguish, inflicting Shadow damage to an enemy%.%s*$"},
    [29477]={"^Wails with anguish, inflicting Shadow damage to an enemy%.%s*$"},
    [29632]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [29641]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [30852]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [31591]={"^Being assaulted%s*$"},
    [31600]={"^Being assaulted%s*$"},
    [31601]={"^Being assaulted%s*$"},
    [31602]={"^Being assaulted%s*$"},
    [31943]={"^Fire damage inflicted every (.-) seconds%.%s*$"},
    [31969]={"^Fire damage inflicted every (.-) seconds%.%s*$"},
    [32110]={"^You cannot trigger Conjure Storm on your target with Volt%.%s*$"},
    [32428]={"^Melee and ranged attacks drain the life force from the target%. \
\
Attacks reduce the target's stats and inflict additional |cff80528CShadow Damage|r\
\
Heals from damage inflicted%s*$"},
    [32477]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [32483]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [32484]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [32711]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [32712]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [32850]={"^Attack power increased by (.-)%%%.%s*$"},
    [32852]={"^Attack power increased by (.-)%%%.%s*$"},
    [32906]={"^Inflicts direct physical damage%.%s*$"},
    [33009]={"^Your next Sunflare is instant cast%.%s*$"},
    [33191]={"^Reduces the cooldown of Wrath of the Black Empire by (.-) seconds%.%s*$"},
    [33192]={"^Reduces the cooldown of Wrath of the Black Empire by (.-) seconds%.%s*$"},
    [33193]={"^Reduces the cooldown of Wrath of the Black Empire by (.-) seconds%.%s*$"},
    [33221]={"^Increases spell haste by (.-)%% and critical strike chance by (.-)%%%.%s*$"},
    [33222]={"^Increases spell haste by (.-)%% and critical strike chance by (.-)%%%.%s*$"},
    [33223]={"^Increases spell haste by (.-)%% and critical strike chance by (.-)%%%.%s*$"},
    [33224]={"^Increases spell haste by (.-)%% and critical strike chance by (.-)%%%.%s*$"},
    [33225]={"^Increases spell haste by (.-)%% and critical strike chance by (.-)%%%.%s*$"},
    [33501]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [33698]={"^Reduces the channel time of your next Darkflock%.%s*$"},
    [33699]={"^Reduces the channel time of your next Darkflock%.%s*$"},
    [33700]={"^Reduces the channel time of your next Darkflock%.%s*$"},
    [33704]={"^Reduces the channel time of your next Darkflock%.%s*$"},
    [33705]={"^Reduces the channel time of your next Darkflock%.%s*$"},
    [33706]={"^Reduces the channel time of your next Darkflock%.%s*$"},
    [33846]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [34256]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [34725]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [35181]={"^Calls down a meteor from the sky%.%s*$"},
    [36127]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [36237]={"^After (.-), an air strike will be launched to your position%.%s*$"},
    [37552]={"^Your Critical Strikes with Holy Damage Spells set the target ablaze with Burning Light, causing (.-) Fire Damage over (.-)%.%s*$"},
    [38145]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [38183]={"^Wails with anguish, inflicting Shadow damage to an enemy%.%s*$"},
    [39005]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [40088]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [42576]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [42578]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [43088]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [43382]={"^Deals (.-) shadow damage to nearby enemies every (.-) sec%.%s*$"},
    [43750]={"^Your next Primordial Blast is instant cast%.%s*$"},
    [45327]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [45329]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [45332]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [45492]={"^Spell damage taken increased by (.-)%%%.%s*$"},
    [45915]={"^Your next Fire spell deals (.-) additional Holy Damage%.%s*$"},
    [46150]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [46859]={"^Unrelenting Assault%s*$"},
    [46860]={"^Unrelenting Assault%s*$"},
    [47751]={"^You cannot trigger Conjure Storm on your target with Volt%.%s*$"},
    [47993]={"^Reduces the channel time of your next Darkflock%.%s*$"},
    [48009]={"^You cannot trigger Conjure Storm on your target with Volt%.%s*$"},
    [48295]={"^The caster has (.-)%% increased Critical Strike chance against this enemy%.%s*$"},
    [49140]={"^Increases damage taken from the caster's next Frostbolt and Frostfire Bolt by (.-)%%%.%s*$"},
    [49188]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [49277]={"^Increases your spirit by (.-)%%%.%s*$"},
    [49661]={"^Increases damage taken from the caster's next Frostbolt and Frostfire Bolt by (.-)%%%.%s*$"},
    [49662]={"^Increases damage taken from the caster's next Frostbolt and Frostfire Bolt by (.-)%%%.%s*$"},
    [49663]={"^Increases damage taken from the caster's next Frostbolt and Frostfire Bolt by (.-)%%%.%s*$"},
    [49664]={"^Increases damage taken from the caster's next Frostbolt and Frostfire Bolt by (.-)%%%.%s*$"},
    [51468]={"^Your Infernal Strike has transformed into Annihilation!%s*$"},
    [51472]={"^Your Infernal Strike has transformed into Annihilation!%s*$"},
    [51473]={"^Your Infernal Strike has transformed into Annihilation!%s*$"},
    [51898]={"^Wails with anguish, inflicting Shadow damage to an enemy%.%s*$"},
    [52496]={"^Being assaulted%s*$"},
    [52795]={"^Critical damage of Shatter Echo increased by (.-)%%%.%s*$"},
    [52797]={"^Critical damage of Shatter Echo increased by (.-)%%%.%s*$"},
    [52798]={"^Critical damage of Shatter Echo increased by (.-)%%%.%s*$"},
    [52799]={"^Critical damage of Shatter Echo increased by (.-)%%%.%s*$"},
    [52800]={"^Critical damage of Shatter Echo increased by (.-)%%%.%s*$"},
    [53167]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [53511]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [53512]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [54311]={"^Being assaulted%s*$"},
    [54316]={"^Being assaulted%s*$"},
    [54528]={"^Damage taken from the Stormbringer increased by (.-)%%%. Movement speed reduced by (.-)%%%.\
\
Stacks up to (.-) times%.%s*$"},
    [54562]={"^Unable to stop moving%.%s*$"},
    [56822]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [57062]={"^You cannot trigger Conjure Storm on your target with Volt%.%s*$"},
    [57428]={"^Damage taken from the Stormbringer increased by (.-)%%%. Movement speed reduced by (.-)%%%.\
\
Stacks up to (.-) times%.%s*$"},
    [57430]={"^Damage taken from the Stormbringer increased by (.-)%%%. Movement speed reduced by (.-)%%%.\
\
Stacks up to (.-) times%.%s*$"},
    [57499]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [59057]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [59092]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [59152]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [59302]={"^The caster has (.-)%% increased Critical Strike chance against this enemy%.%s*$"},
    [62323]={"^You may reactivate Hookshot on a bleeding target to deal additional damage and drag yourself to them%.%s*$"},
    [62759]={"^Ticks of |cffffffffSlipstream|r and |cffffffffTorrent|r now cause sharks to attack enemies in their area of effect for (.-) Frost damage%.\
\
Learning this gives |cffffffffTorrent|r a (.-) sec cooldown%.%s*$"},
    [62760]={"^Ticks of |cffffffffSlipstream|r and |cffffffffTorrent|r now cause sharks to attack enemies in their area of effect for (.-) Frost damage%.\
\
Learning this gives |cffffffffTorrent|r a (.-) sec cooldown%.%s*$"},
    [63278]={"^Siphoning (.-) health from nearby allies every (.-) sec%., healing General Vezax%.%s*$"},
    [63337]={"^Coated in saronite residue%.\
Further exposure will convert life force into mana at an increasing rate%.%s*$"},
    [63338]={"^Coated in saronite residue%.\
Further exposure will convert life force into mana at an increasing rate%.%s*$"},
    [63541]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [64913]={"^Your next Primordial Blast is instant cast%.%s*$"},
    [65130]={"^Increases the duration of |cffffffffTome of Time|r by (.-) sec%.%s*$"},
    [65222]={"^Unable to stop moving%.%s*$"},
    [66186]={"^|cffffffffSticky Bomb|r, |cffffffffSapper Charge|r and |cffffffffDeployed Bombs|r now apply |cFFFFFFFFMolotov|r%.%s*$"},
    [67836]={"^Increases chance to be critically struck by spells by (.-)%%%.%s*$"},
    [68645]={"^Reduces the remaining cooldown of Rockadier by (.-) sec%.%s*$"},
    [68832]={"^|cffffffffSticky Bomb|r, |cffffffffSapper Charge|r and |cffffffffDeployed Bombs|r now apply |cFFFFFFFFMolotov|r%.%s*$"},
    [69193]={"^Reduces the remaining cooldown of Rockadier by (.-) sec%.%s*$"},
    [69399]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [69400]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [70172]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [70173]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [70196]={"^Dealing (.-)%% of maximum health every second%.\
Stunned%.%s*$"},
    [70594]={"^Movement slowed by (.-)%%%.%s*$"},
    [70965]={"^Being assaulted%s*$"},
    [71326]={"^Being assaulted%s*$"},
    [72005]={"^Movement slowed by (.-)%%%.%s*$"},
    [72488]={"^Movement slowed by (.-)%%%.%s*$"},
    [72489]={"^Movement slowed by (.-)%%%.%s*$"},
    [80211]={"^Inflicts direct physical damage%.%s*$"},
    [81111]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [81161]={"^Your non%-periodic Critical Strikes reduce the cooldown of your Endbringer ability by (.-) sec%.%s*$"},
    [81163]={"^Your non%-periodic Critical Strikes reduce the cooldown of your Endbringer ability by (.-) sec%.%s*$"},
    [84379]={"^Heals the next time you take damage%.%s*$"},
    [84555]={"^Increases damage taken from the caster's next Frostbolt and Frostfire Bolt by (.-)%%%.%s*$"},
    [84667]={"^Reduces the mana cost of your next Nature ability by (.-)%%%.%s*$"},
    [85328]={"^Wails with anguish, inflicting Shadow damage to an enemy%.%s*$"},
    [85355]={"^Melee and ranged attacks drain the life force from the target%. \
\
Attacks reduce the target's stats and inflict additional |cff80528CShadow Damage|r\
\
Heals from damage inflicted%s*$"},
    [91637]={"^Dominating mechanical%.%s*$"},
    [91642]={"^Dominating giant%.%s*$"},
    [91647]={"^Dominating aberration%.%s*$"},
    [92091]={"^You may cast Darkslayer while moving%.%s*$"},
    [92132]={"^Gain (.-) Intellect equal to portion of your Strength%.%s*$"},
    [92138]={"^|cffffffffSticky Bomb|r, |cffffffffSapper Charge|r and |cffffffffDeployed Bombs|r now apply |cFFFFFFFFMolotov|r%.%s*$"},
    [92153]={"^Auto attacks grant Earthen Fists%.%s*$"},
    [92154]={"^Runeblade charge reset%.%s*$"},
    [92431]={"^Wails with anguish, inflicting Shadow damage to an enemy%.%s*$"},
    [92523]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [92582]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [93586]={"^Shadow and Frost spells against this target deal (.-)%% increased damage%.%s*$"},
    [94045]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [94046]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [94047]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [94048]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [94049]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [94050]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [94051]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [94052]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [98900]={"^Heals the next time you take damage%.%s*$"},
    [100619]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [100634]={"^Increases the amount of times your Chain Lightning bounces by (.-)%.%s*$"},
    [139778]={"^Causes critical strikes from |cffffffffShadowblast|r and |cffffffffSaber Slash|r to reduce the cooldown of |cffffffffHoundmaster's Call|r by (.-) sec and |cffffffffFlourish|r by (.-) sec%.%s*$"},
    [202092]={"^Your Raise and Animate spells cost no mana and are instant cast%.%s*$"},
    [243995]={"^Critical strike rating increased by (.-)%.%s*$"},
    [254250]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [254264]={"^Restores mana%s*$"},
    [254634]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [254991]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [255092]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [255093]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [255314]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [255315]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [255398]={"^Channeling dark magic through Tipoth%.%s*$"},
    [255458]={"^Channeling dark magic through Tipoth%.%s*$"},
    [255459]={"^Channeling dark magic through Tipoth%.%s*$"},
    [255516]={"^Channeling dark magic through Tipoth%.%s*$"},
    [255655]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [255656]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [255980]={"^Channeling dark magic through Tipoth%.%s*$"},
    [256012]={"^Channeling dark magic through Tipoth%.%s*$"},
    [256043]={"^Channeling dark magic through Tipoth%.%s*$"},
    [256189]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [256190]={"^Fires a cannon shot specifically designed to take down ducks with precision%. Generates 5 Heat%.%s*$"},
    [256848]={"^Absorbing up to (.-) healing%.%s*$"},
    [256859]={"^Channeling dark magic through Tipoth%.%s*$"},
    [256925]={"^Absorbing up to (.-) healing%.%s*$"},
    [256926]={"^Absorbing up to (.-) healing%.%s*$"},
    [257024]={"^Absorbing up to (.-) healing%.%s*$"},
    [257025]={"^Absorbing up to (.-) healing%.%s*$"},
    [257048]={"^Channeling dark magic through Tipoth%.%s*$"},
    [257049]={"^Channeling dark magic through Tipoth%.%s*$"},
    [257050]={"^Channeling dark magic through Tipoth%.%s*$"},
    [257126]={"^Absorbing up to (.-) healing%.%s*$"},
    [257127]={"^Absorbing up to (.-) healing%.%s*$"},
    [257128]={"^Absorbing up to (.-) healing%.%s*$"},
    [271484]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [271494]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [271495]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [271497]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [271498]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [271981]={"^|cffffffffCrypt Swarm|r now bounces to (.-) additional nearby enemies%.%s*$"},
    [272058]={"^Increases the chance to trigger Lightning Overload by (.-)%% and reduces the cast time of your next Lightning Bolt or Chain Lightning by (.-)%%%. In addition, the damage of your next Electrocute is increased by (.-)%% %((.-)%% against players%)%.%s*$"},
    [272317]={"^Your continuous Bestial Assault restores a charge of Unrelenting Wrath%.%s*$"},
    [272427]={"^Being pelted with glacial shards%.%s*$"},
    [274024]={"^Storing cast time%. If you cancel your cast, the cast time of you next Temporal Blast will be reduced%.%s*$"},
    [274050]={"^Reduces the cast time of your next direct damage spell except Arcane Blast by (.-)%%%.%s*$"},
    [274318]={"^Increases the damage of your Sinister Strike by (.-)%% and reduces the energy cost by (.-)%. Refreshing Bloodrage clears all stacks%.%s*$"},
    [274438]={"^Envenom preserves (.-) combo points and increases the damage done by Warrior abilities by (.-)%%%.%s*$"},
    [274987]={"^Causes your next Astral Flare critical strike to reset the cooldown of Astral Plasma, make it instant cast and deal (.-)%% additional damage %((.-)%% to players%)%.%s*$"},
    [275014]={"^Fireball and Pyroblast grant Solar Flames, empowering each stack with (.-)%% intensity%.%s*$"},
    [275034]={"^Increases Nature damage by (.-)%%, Lightning Blade deals (.-)%% increased damage, and Lightning Blade, Thunder Clap, Chain Lightning and Lightning Bolt gains a (.-)%% chance to Overload%.%s*$"},
    [275060]={"^Increases Nature damage by (.-)%%, Lightning Blade deals (.-)%% increased damage, and Lightning Blade, Thunder Clap, Chain Lightning and Lightning Bolt gains a (.-)%% chance to Overload%.%s*$"},
    [276063]={"^Increases the direct damage of your next Chaos Bolt, Chaos Burn and Chaos Meteor by (.-)%%, your Pure Chaos Bolt by (.-)%%, and reduces its cast time by (.-)%%%.%s*$"},
    [276066]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [276084]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [276085]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [276086]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [276087]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [276088]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [276089]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [277892]={"^Increases the damage of your next Annihilan Decimation by (.-)%%%.%s*$"},
    [277910]={"^Allows the usage of Empowered Immolation Aura%.%s*$"},
    [277938]={"^Increases the damage of your combo point generating Rogue abilities by (.-)%% and Dark Intent by additional (.-)%%%.%s*$"},
    [277944]={"^Your next Pulverize hits up to (.-) targets%.%s*$"},
    [278020]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278022]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278067]={"^Healing done by your next Ember Touch is increased by (.-)%% and its cast time is reduced by (.-) sec%.%s*$"},
    [278130]={"^Your next Astral Blade is free of cost%.%s*$"},
    [278274]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278275]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278276]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278277]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278278]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278279]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278280]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278281]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278282]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [278403]={"^Next Execute consumes all rage to deal increased damage%.%s*$"},
    [278407]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278482]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278483]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278484]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278485]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278486]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278487]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278488]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278489]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278490]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [278491]={"^This creature seems to brim with natural energies, killing this creature will redirect this pent up energy towards you and your party, dealing |cffFF9900(.-)|r Nature damage every |cffFF9900(.-)|r seconds to nearby allies%.%s*$"},
    [280150]={"^You are in range of your Scourge Transporter%.%s*$"},
    [280185]={"^Absorbs (.-) Damage%.%s*$"},
    [280221]={"^Periodic damage dealt has a chance to deal Shadow damage to enemies near the target%.%s*$"},
    [280289]={"^Every (.-) sec, enemies near the marked target take Nature damage%. At the end of the duration, nearby enemies take additional damage and are rooted%.%s*$"},
    [281437]={"^Cloudburst%s*$"},
    [281467]={"^Your non%-periodic Critical Strikes reduce the cooldown of your Endbringer ability by (.-) sec%.%s*$"},
    [281469]={"^Your non%-periodic Critical Strikes reduce the cooldown of your Endbringer ability by (.-) sec%.%s*$"},
    [281515]={"^Your melee strikes exasperate the flames lingering on your target, refreshing your Immolate effect%.%s*$"},
    [282208]={"^Heals the next time you take damage%.%s*$"},
    [282626]={"^Reduces the mana cost of your next Nature ability by (.-)%%%.%s*$"},
    [283139]={"^Taking extra damage from the Barbarian%.%s*$"},
    [283168]={"^Increases the duration of |cffffffffSlayer's Mark|r by (.-) sec%.%s*$"},
    [283169]={"^Increases the duration of |cffffffffSlayer's Mark|r by (.-) sec%.%s*$"},
    [283444]={"^Movement speed increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [283624]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [283626]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [283627]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [283628]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [283629]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [283730]={"^Next Sargeron Smite has (.-)%% increased critical strike chance%. Stacks (.-) times%.%s*$"},
    [283883]={"^Increases your critical strike chance by (.-)%%%s*$"},
    [283884]={"^Increases your critical strike chance by (.-)%%%s*$"},
    [284772]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [288804]={"^Increases Armor contribution from items by (.-)%%%. Health regeneration continues during combat and is increased by (.-)%%%.%s*$"},
    [293180]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293181]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293182]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293183]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293184]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293185]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293186]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293193]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293194]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293195]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293196]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293217]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [293218]={"^Removes the minimum range of your ranged abilities%.%s*$"},
    [300240]={"^Damage taken by the Necromancer's Lich Blast increased by (.-)%%%. Casting Speed reduced by (.-)%%%. Stacks (.-) times%.%s*$"},
    [300291]={"^Your next Void Shield absorbs an additional (.-)%% damage%.%s*$"},
    [300298]={"^Reduces the cooldown of Wrath of the Black Empire by (.-) seconds%.%s*$"},
    [300363]={"^Reduces the cost of |cffffffffRadiant Flame|r and |cffffffffSolar Wrath|r by (.-)%%%.%s*$"},
    [300375]={"^Increases damage taken from the Knight of Xoroth's Seeking Flame by (.-)%%%.%s*$"},
    [300474]={"^Damage taken from the Felsworn increased by (.-)%% and critical strike chance of all allies increased by (.-)%%%.%s*$"},
    [300502]={"^Your next Templar Strike crushes an enemies skull, dealing (.-) Physical Damage, ignoring armor%.%s*$"},
    [300533]={"^Your next Ram is guaranteed to critically strike%.%s*$"},
    [300559]={"^Increases the radius of |cffffffffDreadwake|r by (.-)yds and its damage by (.-)%%, and allows |cffffffffLament|r to strike (.-) additional enemies%.%s*$"},
    [300621]={"^Reduces the cost of |cffffffffRadiant Flame|r and |cffffffffSolar Wrath|r by (.-)%%%.%s*$"},
    [300626]={"^Reduces the cost of |cffffffffRadiant Flame|r and |cffffffffSolar Wrath|r by (.-)%%%.%s*$"},
    [300638]={"^Your Bomb Toss now deals additional physical damage%.%s*$"},
    [300658]={"^Cast time of Rocket Launcher reduced by (.-)%%%.%s*$"},
    [300718]={"^Cooldown of Primal Charge and Primal Shred reduced%.%s*$"},
    [300781]={"^Next Nerubian Sting strikes up to (.-) enemies%.%s*$"},
    [300986]={"^Your next Dark Liturgy or Bloodmoon Blast is instant cast%.%s*$"},
    [301068]={"^Damage dealt by Wrath of the Black Empire is increased by (.-)%% and they unleash Apocaliptic Skies%.%s*$"},
    [301168]={"^Damage taken from the Brigand's poison effects increased by (.-)%%, stacking (.-) times%.%s*$"},
    [301175]={"^Cost of Spirit in a Bottle, Splash Potion and Potion toss increased by (.-)%%%.%s*$"},
    [301183]={"^Your next Eldritch Mending is instant cast and costs (.-)%% less%.%s*$"},
    [301193]={"^|cFFFFFFFFDirge|r reduces the cooldown of |cFFFFFFFFMurder|r by (.-) sec%.%s*$"},
    [301234]={"^Your next Dark Liturgy or Bloodmoon Blast is instant cast%.%s*$"},
    [301269]={"^Reduces the cost of |cffffffffRadiant Flame|r and |cffffffffSolar Wrath|r by (.-)%%%.%s*$"},
    [301287]={"^Allows the usage of Empowered Immolation Aura%.%s*$"},
    [301309]={"^Your next |cffffffffHoly Cleave|r deals (.-)%% increased damage%.%s*$"},
    [301979]={"^You have become the victim of the Anub'rekhan's Dark Gaze%.\
Damage taken increased by (.-)%%%.%s*$"},
    [301984]={"^Amount absorbed by your next Void Shield increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [302586]={"^A Lesser Zombie is active%.%s*$"},
    [302909]={"^Cannot benefit from Cryoshroud%.%s*$"},
    [302913]={"^A Greater Zombie is active%.%s*$"},
    [303014]={"^Your next Hammer of Life deals (.-)%% increased damage and is free of cost%.%s*$"},
    [303029]={"^Cannot benefit from Cryoshroud%.%s*$"},
    [303030]={"^Your next Hammer of Life deals (.-)%% increased damage and is free of cost%.%s*$"},
    [350006]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [350332]={"^Damage taken from the Stormbringer increased by (.-)%%%. Movement speed reduced by (.-)%%%.\
\
Stacks up to (.-) times%.%s*$"},
    [350381]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [351091]={"^Melee and ranged attacks drain the life force from the target%. \
\
Attacks reduce the target's stats and inflict additional |cff80528CShadow Damage|r\
\
Heals from damage inflicted%s*$"},
    [351099]={"^Wails with anguish, inflicting Shadow damage to an enemy%.%s*$"},
    [354017]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [354018]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [354147]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [354323]={"^Summoning Ghouls%.%s*$"},
    [354389]={"^Summoning Ghouls%.%s*$"},
    [354561]={"^Summoning Ghouls%.%s*$"},
    [354814]={"^Being pelted with glacial shards%.%s*$"},
    [354843]={"^Being pelted with glacial shards%.%s*$"},
    [354844]={"^Being pelted with glacial shards%.%s*$"},
    [354845]={"^Being pelted with glacial shards%.%s*$"},
    [355176]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [355241]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [355284]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [355287]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [355335]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [355446]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [355496]={"^Being pelted with glacial shards%.%s*$"},
    [355557]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [355710]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [355843]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [365102]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [365378]={"^Healing taken increased by (.-)%%%. Healing for (.-) every (.-) sec%.%s*$"},
    [411000]={"^Allows Lava Shard to strike up to (.-) enemies%.%s*$"},
    [411001]={"^Allows Lava Shard to strike up to (.-) enemies%.%s*$"},
    [411002]={"^Allows Lava Shard to strike up to (.-) enemies%.%s*$"},
    [413300]={"^Once getting 3 Essences, you fire a Pillar of Flame at the target%.%s*$"},
    [413301]={"^Once getting 3 Essences, you fire a Pillar of Flame at the target%.%s*$"},
    [413302]={"^Once getting 3 Essences, you fire a Pillar of Flame at the target%.%s*$"},
    [413303]={"^Once getting 3 Essences, you fire a Pillar of Flame at the target%.%s*$"},
    [413305]={"^Once getting 3 Essences, you fire a Pillar of Flame at the target%.%s*$"},
    [413311]={"^Once getting 3 Essences, you fire a Pillar of Flame at the target%.%s*$"},
    [413312]={"^Once getting 3 Essences, you fire a Pillar of Flame at the target%.%s*$"},
    [413313]={"^Once getting 3 Essences, you fire a Pillar of Flame at the target%.%s*$"},
    [415005]={"^Taking extra damage from the Barbarian%.%s*$"},
    [415006]={"^Taking extra damage from the Barbarian%.%s*$"},
    [425090]={"^Increases critical strike rating by (.-)%.%s*$"},
    [499207]={"^Increases ground speed by (.-)%%%. Increases flying speed by (.-)%%%.%s*$"},
    [500039]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [500055]={"^|cffffffffQuickblast|r silences the target for (.-)%.%s*$"},
    [500056]={"^Dealing (.-) Twilight Damage every (.-) sec%.%s*$"},
    [500060]={"^Casting speed of Throw Weapon reduced by (.-)%%%. Stacks (.-) times%.%s*$"},
    [500068]={"^You can use Electrocute regardless of your target's current health%.%s*$"},
    [500095]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [500175]={"^You may now use Reprisal!%s*$"},
    [500219]={"^Your Venom Bolts are castable while moving and cast (.-)%% faster%.%s*$"},
    [500258]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [500314]={"^Runeblade charge reset%.%s*$"},
    [500376]={"^Restores mana%s*$"},
    [500461]={"^Your Pulverize has been transformed into Shield Toss!%s*$"},
    [500462]={"^Auto attacks grant Earthen Fists%.%s*$"},
    [500567]={"^Your next Quickdraw has transformed into Sixfold Shot!%s*$"},
    [500568]={"^Dealing (.-) Twilight Damage every (.-) sec%.%s*$"},
    [500603]={"^Dealing (.-) Twilight Damage every (.-) sec%.%s*$"},
    [500608]={"^Your next Moon Arrow or Celestial Strike generates an additional (.-)%% of your missing mana%.%s*$"},
    [500748]={"^Your next Blade of the Empire will restore (.-)%% of your missing mana and heal all nearby allies for (.-)%.%s*$"},
    [500755]={"^Dealing (.-) Twilight Damage every (.-) sec%.%s*$"},
    [500772]={"^Your next Blade of the Empire will restore (.-)%% of your missing mana and heal all nearby allies for (.-)%.%s*$"},
    [500909]={"^Restores (.-)%% max health every second%.%s*$"},
    [500918]={"^Taking (.-)%% increased healing%.%s*$"},
    [500925]={"^Damage taken from the Stormbringer increased by (.-)%%%. Movement speed reduced by (.-)%%%.\
\
Stacks up to (.-) times%.%s*$"},
    [500933]={"^Taking damage that brings you below (.-)%% health turns you into a Shade, making you invulnerable but unable to attack or cast spells%.\
\
If you reach your Phylactery while in Shade form, you are revived%.%s*$"},
    [500940]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [500960]={"^Increases the damage of |cffffffffShadow Marks|r and all abilities that scale with them by (.-)%%%.%s*$"},
    [500984]={"^Dealing (.-)%% of maximum health every second%.\
Stunned%.%s*$"},
    [501036]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [501037]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [501038]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [501039]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [501040]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [501041]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [501042]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [501057]={"^Taking (.-)%% increased healing%.%s*$"},
    [501058]={"^Taking (.-)%% increased healing%.%s*$"},
    [501059]={"^Taking (.-)%% increased healing%.%s*$"},
    [501060]={"^Taking (.-)%% increased healing%.%s*$"},
    [501061]={"^Taking (.-)%% increased healing%.%s*$"},
    [501062]={"^Taking (.-)%% increased healing%.%s*$"},
    [501063]={"^Taking (.-)%% increased healing%.%s*$"},
    [501064]={"^Taking (.-)%% increased healing%.%s*$"},
    [501065]={"^Taking (.-)%% increased healing%.%s*$"},
    [501089]={"^Your next attack will cause you to cast Gift of the Loa%.%s*$"},
    [501090]={"^Your next attack will cause you to cast Gift of the Loa%.%s*$"},
    [501091]={"^Your next attack will cause you to cast Gift of the Loa%.%s*$"},
    [501092]={"^Your next attack will cause you to cast Gift of the Loa%.%s*$"},
    [501093]={"^Your next attack will cause you to cast Gift of the Loa%.%s*$"},
    [501094]={"^Your next attack will cause you to cast Gift of the Loa%.%s*$"},
    [501095]={"^Your next attack will cause you to cast Gift of the Loa%.%s*$"},
    [501257]={"^Recently used Twin Slice%.%s*$"},
    [501258]={"^Recently used Twin Slice%.%s*$"},
    [501259]={"^Recently used Twin Slice%.%s*$"},
    [501260]={"^Recently used Twin Slice%.%s*$"},
    [501261]={"^Recently used Twin Slice%.%s*$"},
    [501421]={"^Deals nature damage%.%s*$"},
    [501422]={"^Deals nature damage%.%s*$"},
    [501423]={"^Deals nature damage%.%s*$"},
    [501424]={"^Deals nature damage%.%s*$"},
    [501425]={"^Deals nature damage%.%s*$"},
    [501426]={"^Deals nature damage%.%s*$"},
    [501427]={"^Deals nature damage%.%s*$"},
    [501428]={"^Deals nature damage%.%s*$"},
    [501429]={"^Deals nature damage%.%s*$"},
    [501430]={"^Deals nature damage%.%s*$"},
    [501431]={"^Deals nature damage%.%s*$"},
    [501432]={"^Deals nature damage%.%s*$"},
    [501442]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [501443]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [501444]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [501445]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [501446]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [501447]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [501448]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [501449]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [501450]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [501451]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [501452]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [501453]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [501454]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [501455]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [501456]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [501457]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [501458]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [501549]={"^Movement speed reduced by (.-)%%%.%s*$"},
    [501550]={"^Movement speed reduced by (.-)%%%.%s*$"},
    [501551]={"^Movement speed reduced by (.-)%%%.%s*$"},
    [501552]={"^Movement speed reduced by (.-)%%%.%s*$"},
    [501553]={"^Movement speed reduced by (.-)%%%.%s*$"},
    [501554]={"^Movement speed reduced by (.-)%%%.%s*$"},
    [501555]={"^Movement speed reduced by (.-)%%%.%s*$"},
    [501556]={"^Movement speed reduced by (.-)%%%.%s*$"},
    [501557]={"^Movement speed reduced by (.-)%%%.%s*$"},
    [501724]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501725]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501726]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501727]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501728]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501729]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501730]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501731]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501732]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501733]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501734]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [501909]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [501910]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [501911]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [501912]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [501913]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [501914]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [501915]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [501916]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [501917]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [502004]={"^Armor and Magical Resistances increased%.%s*$"},
    [502005]={"^Armor and Magical Resistances increased%.%s*$"},
    [502006]={"^Armor and Magical Resistances increased%.%s*$"},
    [502007]={"^Armor and Magical Resistances increased%.%s*$"},
    [502008]={"^Armor and Magical Resistances increased%.%s*$"},
    [502009]={"^Armor and Magical Resistances increased%.%s*$"},
    [502010]={"^Armor and Magical Resistances increased%.%s*$"},
    [502011]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [502012]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [502013]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [502014]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [502015]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [502016]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [502017]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [502018]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [502019]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [502507]={"^Scrap Shot has a chance to reset the cooldown of Gunsling%.%s*$"},
    [502508]={"^Scrap Shot has a chance to reset the cooldown of Gunsling%.%s*$"},
    [502509]={"^Scrap Shot has a chance to reset the cooldown of Gunsling%.%s*$"},
    [502565]={"^Next attack delivers a devastating strike to an enemy, dealing (.-) Physical Damage%.%s*$"},
    [502566]={"^Next attack delivers a devastating strike to an enemy, dealing (.-) Physical Damage%.%s*$"},
    [502567]={"^Next attack delivers a devastating strike to an enemy, dealing (.-) Physical Damage%.%s*$"},
    [502568]={"^Next attack delivers a devastating strike to an enemy, dealing (.-) Physical Damage%.%s*$"},
    [502569]={"^Next attack delivers a devastating strike to an enemy, dealing (.-) Physical Damage%.%s*$"},
    [502570]={"^Next attack delivers a devastating strike to an enemy, dealing (.-) Physical Damage%.%s*$"},
    [502571]={"^Next attack delivers a devastating strike to an enemy, dealing (.-) Physical Damage%.%s*$"},
    [502572]={"^Next attack delivers a devastating strike to an enemy, dealing (.-) Physical Damage%.%s*$"},
    [502679]={"^Restores mana%s*$"},
    [502680]={"^Restores mana%s*$"},
    [502681]={"^Restores mana%s*$"},
    [502682]={"^Restores mana%s*$"},
    [502683]={"^Restores mana%s*$"},
    [502684]={"^Restores mana%s*$"},
    [502725]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [502726]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [502727]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [502728]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [502729]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [502730]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [502731]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [502732]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [502733]={"^Dealing (.-) Physical Damage every (.-) sec%.%s*$"},
    [502755]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [502756]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [502757]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [502758]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [502759]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [502760]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [502934]={"^Your offensive spell casts have a 10%% chance to unleash a Fireball upon the target, dealing Fire damage%.%s*$"},
    [502935]={"^Your offensive spell casts have a 10%% chance to unleash a Fireball upon the target, dealing Fire damage%.%s*$"},
    [502936]={"^Your offensive spell casts have a 10%% chance to unleash a Fireball upon the target, dealing Fire damage%.%s*$"},
    [502937]={"^Your offensive spell casts have a 10%% chance to unleash a Fireball upon the target, dealing Fire damage%.%s*$"},
    [502938]={"^Your offensive spell casts have a 10%% chance to unleash a Fireball upon the target, dealing Fire damage%.%s*$"},
    [503019]={"^Healing over time%.%s*$"},
    [503020]={"^Healing over time%.%s*$"},
    [503021]={"^Healing over time%.%s*$"},
    [503022]={"^Healing over time%.%s*$"},
    [503023]={"^Healing over time%.%s*$"},
    [503024]={"^Healing over time%.%s*$"},
    [503025]={"^Healing over time%.%s*$"},
    [503026]={"^Healing over time%.%s*$"},
    [503027]={"^Healing over time%.%s*$"},
    [503028]={"^Healing over time%.%s*$"},
    [503029]={"^Healing over time%.%s*$"},
    [503088]={"^Dealing (.-)%% of maximum health every second%.\
Stunned%.%s*$"},
    [503089]={"^Dealing (.-)%% of maximum health every second%.\
Stunned%.%s*$"},
    [503090]={"^Dealing (.-)%% of maximum health every second%.\
Stunned%.%s*$"},
    [503091]={"^Dealing (.-)%% of maximum health every second%.\
Stunned%.%s*$"},
    [503092]={"^Dealing (.-)%% of maximum health every second%.\
Stunned%.%s*$"},
    [503093]={"^Dealing (.-)%% of maximum health every second%.\
Stunned%.%s*$"},
    [503127]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [503128]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [503129]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [503130]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [503131]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [503132]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [503133]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [503134]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [503177]={"^Healing taken increased by (.-)%%%. Healing for (.-) every (.-) sec%.%s*$"},
    [503178]={"^Healing taken increased by (.-)%%%. Healing for (.-) every (.-) sec%.%s*$"},
    [503179]={"^Healing taken increased by (.-)%%%. Healing for (.-) every (.-) sec%.%s*$"},
    [503180]={"^Healing taken increased by (.-)%%%. Healing for (.-) every (.-) sec%.%s*$"},
    [503181]={"^Healing taken increased by (.-)%%%. Healing for (.-) every (.-) sec%.%s*$"},
    [503552]={"^Next Repair Shot or Emergency Heal heals for (.-)%% more%.%s*$"},
    [503637]={"^Reduces CD of Blanket of Stars%s*$"},
    [503668]={"^Taking increased damage from the Witch Hunter's Repeater!%s*$"},
    [503690]={"^Your next Gavel will incur no cooldown%.%s*$"},
    [503792]={"^Your next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [503846]={"^Healing for (.-) every (.-) sec%.\
\
Melee Attack Speed, Ranged Attack Speed, and Spell Haste increased by (.-)%%%.%s*$"},
    [503875]={"^Next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [503876]={"^Next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [503877]={"^Next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [503878]={"^Next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [503879]={"^Next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [503880]={"^Next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [503915]={"^Casting speed of your next Cinderheart is reduced by (.-)%%%. Stacks (.-) times%.%s*$"},
    [503919]={"^Chance to be critically struck by the Venomancer's Wilt increased by (.-)%%%.%s*$"},
    [503966]={"^Critical strike chance increased by (.-)%%%. Damage or healing of your next Serpent's Coil or Venom Fang is increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [504020]={"^Frozen%.%s*$"},
    [504028]={"^Increases the critical damage of |cFFFFFFFFSlaughter|r by (.-)%%%.%s*$"},
    [504052]={"^Dealing Plague Damage every (.-) sec%.%s*$"},
    [504301]={"^Your next Sunflare is instant cast%.%s*$"},
    [504347]={"^Movement speed increased by (.-)%%%. Immune to roots and snares%. Can cast Venom Bolt while moving%.%s*$"},
    [504359]={"^Cost of your next Icequake reduced by (.-)%.%s*$"},
    [504442]={"^Your next Spread Shot has no cost and incurs no cooldown%.%s*$"},
    [504462]={"^Your next instance of direct damage deals additional Nature Damage%.%s*$"},
    [504502]={"^Critical strike chance of Flare Bolt increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [504505]={"^Whenever this minion deals damage, it has a chance to expel Zombie Plague%.%s*$"},
    [504581]={"^Your Infernal Strike has transformed into Annihilation!%s*$"},
    [504583]={"^Can be consumed by Umbral Glaive to reduce the cooldown of the Witch Doctor's Spirit Glaive spell%.%s*$"},
    [504585]={"^Can be consumed by Umbral Glaive to reduce the cooldown of the Witch Doctor's Spirit Glaive spell%.%s*$"},
    [504599]={"^Your next Sand Barrage is cute%.%s*$"},
    [504622]={"^Restores mana%s*$"},
    [504638]={"^Recently hit by a Molten Blast%.%s*$"},
    [504650]={"^Enemies who stand in the fire are disoriented%.%s*$"},
    [504710]={"^Demon%. Cursed Form%. Increases your attack power and causes your melee attacks to reduce all healing done to the target by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [504736]={"^Increases healing of your next |cFFFFFFFFAlkahest|r by (.-)%%%.%s*$"},
    [504777]={"^Increases the damage of |cffffffffShadow Marks|r and all abilities that scale with them by (.-)%%%.%s*$"},
    [504798]={"^Heal over time effects can critically strike and have a chance to trigger Replenishment%.%s*$"},
    [504863]={"^Charging up a powerful bone crushing attack%.%s*$"},
    [505171]={"^Allows the periodic healing from |cffffffffSunshine|r to critically strike%.%s*$"},
    [505229]={"^Charging up a powerful bone crushing attack%.%s*$"},
    [505339]={"^Casting speed reduced by (.-)%%%. Movement speed reduced by (.-)%%%.%s*$"},
    [506635]={"^Duration of crowd control effects on you increased by (.-)%%%.%s*$"},
    [507075]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [507081]={"^Your next Bomb Toss incurs no cooldown, global cooldown, or cost%.%s*$"},
    [518352]={"^Transformed into a Bronze Dragonkin, increasing healing by (.-)%%, and speeds up the rate of Chronomend, Rumble, and Breath of Time cooldown recovery%.%s*$"},
    [520007]={"^Critical strike chance of the Templar's Comber Breakers against this target is increased by (.-)%%%.%s*$"},
    [520067]={"^Charging up%.%.%.%s*$"},
    [520068]={"^Charging up%.%.%.%s*$"},
    [520069]={"^Charging up%.%.%.%s*$"},
    [520070]={"^Charging up%.%.%.%s*$"},
    [520136]={"^Deal an additional (.-)%% Weapon Damage to the target you inflicted with Carnage%.%s*$"},
    [520167]={"^Your next Sandblast is instant cast and hits up to (.-) targets%.%s*$"},
    [520171]={"^Damage taken from the Chronomancer is increased by (.-)%%%.%s*$"},
    [520211]={"^Your next Bolt ability does (.-)%% increased damage and has (.-)%% increased duration%.%s*$"},
    [520212]={"^Your next Bolt ability does (.-)%% increased damage and has (.-)%% increased duration%.%s*$"},
    [520213]={"^Your next Bolt ability does (.-)%% increased damage and has (.-)%% increased duration%.%s*$"},
    [520292]={"^Your next Shieldgore deals (.-)%% increased damage%. Stacks (.-) times%.%s*$"},
    [520381]={"^Your next Firefall is instant cast%.%s*$"},
    [520482]={"^Spreads Lunar Lance%.%s*$"},
    [520534]={"^You cannot be pulled again by Righteous Tempest%.%s*$"},
    [520592]={"^Your next Demonic Evasion allows you to dodge more, or your next Stomp deals increased damage%.%s*$"},
    [520778]={"^Allows you to cast all of your spells while moving%.%s*$"},
    [520857]={"^Your next Shieldgore deals (.-)%% increased damage%. Stacks (.-) times%.%s*$"},
    [520921]={"^Allows you to cast all of your spells while moving%.%s*$"},
    [524631]={"^Chance to be critically struck by the Brigand increased by (.-)%%%.%s*$"},
    [524765]={"^Your next Benediction heals for (.-)%% more%.%s*$"},
    [524822]={"^Armor reduced%.%s*$"},
    [524887]={"^Your next Blade of the Empire will restore (.-)%% of your missing mana and heal all nearby allies for (.-)%.%s*$"},
    [524892]={"^|cffffffffClaw Sweep|r now spreads |cffffffffInfected Claw|r from affected targets to another random enemy within (.-)yd%.%s*$"},
    [524897]={"^Increases critical strike rating by (.-)%.%s*$"},
    [524950]={"^Your next Firefall is instant cast%.%s*$"},
    [525061]={"^Casting |cFFFFFFFFVoid Shield|r now reduces the cooldown of |cFFFFFFFFHallucination|r by (.-) sec%.%s*$"},
    [525078]={"^Your next Blade of the Empire will restore (.-)%% of your missing mana and heal all nearby allies for (.-)%.%s*$"},
    [525079]={"^Your next Firefall is instant cast%.%s*$"},
    [525080]={"^Armor reduced%.%s*$"},
    [527268]={"^Critical chance of Netherstrike and Gaze of C'thun increased by (.-)%%%.%s*$"},
    [531135]={"^Increases chance to be critically struck by spells by (.-)%%%.%s*$"},
    [536216]={"^Next Starsunder hits an additional enemy has a reduced cost%.%s*$"},
    [547210]={"^Recently used Twin Slice%.%s*$"},
    [547211]={"^Recently used Twin Slice%.%s*$"},
    [547214]={"^Reduces the mana cost of |cffffffffIllumination|r by (.-)%%%.%s*$"},
    [553262]={"^Damage from Rock Shower reduces the cooldown of Earthquake%.%s*$"},
    [560012]={"^Increases the damage dealt by |cffffffffDark Arrows|r by (.-)%% for (.-)%.%s*$"},
    [560037]={"^Your |cFFFFFFFFConjure: Runic Familiar|r also increases your damage dealt by (.-)%% while active%.%s*$"},
    [560048]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [560065]={"^Your next Blade of the Empire hits up to (.-) enemies%.%s*$"},
    [560119]={"^Increases attack power by (.-)%% and Holy Damage by (.-)%%%.%s*$"},
    [560129]={"^Increases the damage taken by the Chronomancer's |cFFFFFFFFArtificer's Wand|r by (.-)%%%. Stacks (.-) times%.%s*$"},
    [560130]={"^Causes wand attacks to grant |cffffffffSands of Time|r%.%s*$"},
    [560145]={"^Your next Seismic Spike strikes (.-) additional enemies%.%s*$"},
    [560154]={"^Damage from Rock Shower reduces the cooldown of Earthquake%.%s*$"},
    [560194]={"^Your next Blight affects (.-) enemies%.%s*$"},
    [560256]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [560261]={"^Your next Bloodmoon Blast or |cffffffffSanguine Mend|r is free and instant cast%.%s*$"},
    [560278]={"^Damage dealt of your next Shadowflare increased by (.-)%%%.%s*$"},
    [560363]={"^Critical strike chance and damage of Decapitate increased by (.-)%%%.%s*$"},
    [560427]={"^Taking Shadow damage every (.-) sec%.%s*$"},
    [560446]={"^Damage taken by the Barbarians Ancestral Strike increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [560481]={"^At the end of the duration, the target takes Nature Damage%.%s*$"},
    [560529]={"^Honor gained increased by (.-)%%%. Direct damage dealt will deal additional Frost damage%.%s*$"},
    [560578]={"^Your next Umbral Glaive is guaranteed to critically strike%.%s*$"},
    [560622]={"^Cost of your next spell or ability is increased by (.-)%%%.%s*$"},
    [560681]={"^Gives |cffffffffEldritch Blast|r and |cffffffffHorrorbolt|r a (.-)%% chance to cast |cFFFFFFFFNightmarish Bolt|r%.%s*$"},
    [560691]={"^Your next Serrated Shot will hit up to (.-) targets%.%s*$"},
    [560692]={"^Your next Serrated Shot will hit up to (.-) targets%.%s*$"},
    [560727]={"^Damage and critical strike chance increased by (.-)%%%.%s*$"},
    [560800]={"^Wormfood is on cooldown, Expunge can not trigger Wormfood%.%s*$"},
    [560846]={"^Your next Lichfrost hits (.-) additional targets%.%s*$"},
    [560847]={"^Can be consumed by Ripper to deal additional damage%.%s*$"},
    [560851]={"^Damage taken by Animate: Frost Whelp increased by (.-)%%%.%s*$"},
    [560862]={"^Damage taken from Sunflare and Dawnsear increased by (.-)%%%.%s*$"},
    [560863]={"^Damage taken from Sunflare and Dawnsear increased by (.-)%%%.%s*$"},
    [560864]={"^Damage taken from Sunflare and Dawnsear increased by (.-)%%%.%s*$"},
    [560865]={"^Damage taken from Sunflare and Dawnsear increased by (.-)%%%.%s*$"},
    [560866]={"^Damage taken from Sunflare and Dawnsear increased by (.-)%%%.%s*$"},
    [560867]={"^Damage taken from Sunflare and Dawnsear increased by (.-)%%%.%s*$"},
    [560890]={"^Increases spell haste by (.-)%% and critical strike chance by (.-)%%%.%s*$"},
    [560910]={"^Movement speed increased by (.-)%%%. Immune to slows%.\
\
Your next Decapitate or Crush will consume this effect to critically strike%.%s*$"},
    [560917]={"^Damage taken from Deathchaser increased by (.-)%%%.%s*$"},
    [560940]={"^Taking extra damage from the Barbarian%.%s*$"},
    [561042]={"^Your next Serrated Shot will hit up to (.-) targets%.%s*$"},
    [561051]={"^Chance to trigger Weapon Engravings increased by (.-)%%%.%s*$"},
    [561062]={"^Damage taken from the Starcaller's Scattered Stars increased by (.-)%%%.%s*$"},
    [561146]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [561147]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [561148]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [561149]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [561153]={"^Dealing (.-) Shadow Damage every (.-) sec%.%s*$"},
    [561283]={"^Chance to trigger Weapon Engravings increased by (.-)%%%.%s*$"},
    [561316]={"^Guaranteed to critically strike%.%s*$"},
    [561348]={"^Your next Bloodmoon Blast or |cffffffffSanguine Mend|r is free and instant cast%.%s*$"},
    [561349]={"^Your next Blight affects (.-) enemies%.%s*$"},
    [561352]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [570003]={"^Periodically generates an Ember and Cinderheart generates double the amount of Heat%.%s*$"},
    [570033]={"^Your next Fire spell deals (.-) additional Holy Damage%.%s*$"},
    [570079]={"^Damage taken by Zombie Plague will deal additional damage to nearby enemies%.%s*$"},
    [570240]={"^Allows |cffffffffHexing Strike|r to strike (.-) enemies%.%s*$"},
    [570241]={"^Allows |cffffffffHexing Strike|r to strike (.-) enemies%.%s*$"},
    [570747]={"^Dealing (.-) Plague Damage every (.-) sec%.\
\
After (.-), the target explodes, dealing (.-) Plague damage to all enemies within (.-) yards%.%s*$"},
    [572119]={"^Charging up%.%.%.%s*$"},
    [572120]={"^Charging up%.%.%.%s*$"},
    [572121]={"^Charging up%.%.%.%s*$"},
    [572122]={"^Charging up%.%.%.%s*$"},
    [572288]={"^Your melee attacks and abilities heal nearby allies and damage nearby enemies for (.-)%% of the damage dealt%.%s*$"},
    [572289]={"^Your melee attacks and abilities heal nearby allies and damage nearby enemies for (.-)%% of the damage dealt%.%s*$"},
    [572290]={"^Your melee attacks and abilities heal nearby allies and damage nearby enemies for (.-)%% of the damage dealt%.%s*$"},
    [572291]={"^Your melee attacks and abilities heal nearby allies and damage nearby enemies for (.-)%% of the damage dealt%.%s*$"},
    [572292]={"^Your melee attacks and abilities heal nearby allies and damage nearby enemies for (.-)%% of the damage dealt%.%s*$"},
    [572314]={"^Damage dealt by |cffffffffFlintlock Shot|r spreads |cffffffffTorment|r to (.-) nearby enemies%.%s*$"},
    [572364]={"^Allows |cffffffffHexing Strike|r to strike (.-) enemies%.%s*$"},
    [572365]={"^Allows |cffffffffHexing Strike|r to strike (.-) enemies%.%s*$"},
    [572582]={"^Periodic damage taken from the Pyromancer is increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [572638]={"^Increases Necromancer's Spell Power by a percentage of the active minion's Stamina%.\
\
Granting (.-) Spell damage%.%s*$"},
    [572885]={"^Inflicts (.-) Light damage every (.-) sec%.\
Touch of Light will not harm Light targets%.%s*$"},
    [572910]={"^Movement speed and healing taken reduced by (.-)%%%.%s*$"},
    [572911]={"^Movement speed and healing taken reduced by (.-)%%%.%s*$"},
    [573030]={"^Restores mana%s*$"},
    [573072]={"^Inflicts direct physical damage%.%s*$"},
    [573265]={"^Allows |cffffffffHexing Strike|r to strike (.-) enemies%.%s*$"},
    [573275]={"^Direct damage will deal additional Holy damage%.%s*$"},
    [573330]={"^Restores (.-)%% max health every second%.%s*$"},
    [573331]={"^Restores (.-)%% max health every second%.%s*$"},
    [574149]={"^Your next Quickdraw ignores Armor%.%s*$"},
    [574163]={"^Your next Quickdraw ignores Armor%.%s*$"},
    [574309]={"^Your next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [574319]={"^Your next Bolt ability does (.-)%% increased damage and has (.-)%% increased duration%.%s*$"},
    [574320]={"^Your next Bolt ability does (.-)%% increased damage and has (.-)%% increased duration%.%s*$"},
    [578297]={"^Your next Bolt ability does (.-)%% increased damage and has (.-)%% increased duration%.%s*$"},
    [578306]={"^Taking Plague damage every (.-) sec%.%s*$"},
    [582758]={"^Next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [582759]={"^Next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [582760]={"^Next Decomposition or Unmake will hit (.-) additional enemies%.%s*$"},
    [582761]={"^Scrap Shot has a chance to reset the cooldown of Gunsling%.%s*$"},
    [582937]={"^Your next Pulverize is free of cost and deals (.-)%% increased damage%.%s*$"},
    [592008]={"^Your next Discordance is instant cast%.%s*$"},
    [630874]={"^Chanting a sinister ritual over (.-), healing up to (.-) allies affected by |cffffffffBlood Rituals|r and leeching health from enemies within (.-) yds%.\
\
Immune to silence and interrupt effects, but cannot move%.%s*$"},
    [638403]={"^Chance to be critically struck by the Brigand increased by (.-)%%%.%s*$"},
    [653022]={"^At the end of the duration, this target explodes, dealing (.-) Fire Damage per stack%.\
\
Additional applications do not refresh the duration%.%s*$"},
    [653213]={"^Resource regeneration reduced by (.-)%%%.%s*$"},
    [653265]={"^Reduces healing received by (.-)%%%.%s*$"},
    [657499]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [680200]={"^Damage taken from the Tinker's Sticky Bomb Explosions and Mechsuit abilities is increased by (.-)%%, stacking (.-) times%.%s*$"},
    [680234]={"^Your Shadow Hound cannot cast Darkhowl%.%s*$"},
    [680362]={"^Cannot benefit from Cryoshroud%.%s*$"},
    [680373]={"^Critical damage of Shatter Echo increased by (.-)%%%.%s*$"},
    [680383]={"^Enemies who stand in the fire are disoriented%.%s*$"},
    [680478]={"^Increases the damage of |cffffffffWild Strike|r and |cffffffffQuick Shot|r by (.-)%%%. Stacks (.-) times%.%s*$"},
    [680567]={"^Your next Fire spell deals (.-) additional Holy Damage%.%s*$"},
    [680599]={"^Increases the range of |cffffffffScrap Shot|r by (.-)yd with all guns%.%s*$"},
    [680641]={"^Healing of Illumination increased by (.-)%%%.%s*$"},
    [680654]={"^Your next Horusath Blast is instant cast and strikes up to (.-) targets%.%s*$"},
    [680684]={"^Lifedrinker ticks heal allies affected by your Blood Rituals marks%.%s*$"},
    [680758]={"^Reduces the amount of Maximum Mana consumed by Starsunder by (.-)%%%.%s*$"},
    [680770]={"^Allows |cFFFFFFFFShadow Rage|r to stack (.-) additional times%.%s*$"},
    [680777]={"^Increases damage of Aspect of the Warden by (.-)%.%s*$"},
    [680813]={"^Receiving (.-)%% more damage from the Starcaller's Trueshot%.%s*$"},
    [680880]={"^ cause your next |cffffffffMalefic Wrath|r within (.-) to become instant cast, incur no global cooldown, and become free of cost%.%s*$"},
    [680897]={"^ cause your next |cffffffffMalefic Wrath|r within (.-) to become instant cast, incur no global cooldown, and become free of cost%.%s*$"},
    [680900]={"^Taking (.-)%% increased damage from the Knight of Xoroth's Flames of Xoroth and Blade of Xoroth%.%s*$"},
    [680908]={"^Allows |cffffffffHexing Strike|r to strike (.-) enemies%.%s*$"},
    [680909]={"^Allows |cffffffffHexing Strike|r to strike (.-) enemies%.%s*$"},
    [680910]={"^Allows |cffffffffHexing Strike|r to strike (.-) enemies%.%s*$"},
    [680931]={"^Serrated Shot can now critically strike%.%s*$"},
    [680946]={"^Your next Unmake or Reverse Wound is instant and costs (.-)%% less%.%s*$"},
    [681047]={"^Healing for (.-) every (.-) sec%. Healing from the Venomancer increased by (.-)%%%.%s*$"},
    [681090]={"^Your Critical Strikes with Holy Damage Spells set the target ablaze with Burning Light, causing (.-) Fire Damage over (.-)%.%s*$"},
    [681102]={"^Increases the damage of your next Blade of the Empire or next Gaze of C'thun by (.-)%%, stacking (.-) times%.%s*$"},
    [681186]={"^Causes critical strikes from |cffffffffShadowblast|r and |cffffffffSaber Slash|r to reduce the cooldown of |cffffffffHoundmaster's Call|r by (.-) sec and |cffffffffFlourish|r by (.-) sec%.%s*$"},
    [681236]={"^Your Gavel of Light has transformed into Justicar's Wrath!%s*$"},
    [681248]={"^Hex of Death and Hex of Blood now deal their damage (.-)%% faster%.%s*$"},
    [681251]={"^Geode Barrage is transformed into Seismic Lance!%s*$"},
    [681252]={"^Duration and tick rate of Valkyrie Spear reduced by (.-)%%%.%s*$"},
    [681253]={"^Illumination will heal an additional ally%.%s*$"},
    [681255]={"^Illumination will heal an additional ally%.%s*$"},
    [681474]={"^Your Gaze of C'Thun transformed into Eldritch Force%.%s*$"},
    [681482]={"^Damage taken from the Tinker's Sticky Bomb Explosions and Mechsuit abilities is increased by (.-)%%, stacking (.-) times%.%s*$"},
    [700186]={"^Hitting this target will cause an electrical conduit to pass through its nearby allies%.%s*$"},
    [704116]={"^Dodge chance increased by (.-)%%%.%s*$"},
    [704163]={"^Causes (.-) Plague Damage%.%s*$"},
    [704168]={"^Increases the damage of your next Bloodbolt or Bloodfang Bite by (.-)%%%. Stacks (.-) times%.%s*$"},
    [704196]={"^Damage dealt by |cffffffffFlintlock Shot|r spreads |cffffffffTorment|r to (.-) nearby enemies%.%s*$"},
    [704209]={"^Allies in your Updraft take (.-)%% reduced damage%.%s*$"},
    [704231]={"^The Starcaller's Huntress Shot ability heals you for a small amount%.%s*$"},
    [704232]={"^The Starcaller's Huntress Shot ability heals you for a small amount%.%s*$"},
    [704253]={"^Absorbs (.-) damage%. Spellcasting will not be interrupted by damage%.%s*$"},
    [704301]={"^Your damage dealing effects have a chance to steal life%. Haste increased by (.-)%%%.%s*$"},
    [704360]={"^Damage taken reduced by (.-)%%%. Stacks (.-) times%.%s*$"},
    [704370]={"^Damage taken from the Felsworns Bane of Chaos increased by (.-)%% per stack%.%s*$"},
    [704375]={"^Allows Felglare to stack (.-) additional times%.%s*$"},
    [704507]={"^Next Batscreech Blast, Hex of Death, or Gift of the Loa incurs a (.-)%% reduced cooldown%.%s*$"},
    [704517]={"^Increases attack power by (.-)%% and reduces the global cooldown triggered by |cffffffffValiant Strike|r by (.-) sec%.%s*$"},
    [704552]={"^Your next Doomrend deals (.-)%% increased damage%. Stacks (.-) times%.%s*$"},
    [704604]={"^Reduces the amount of Maximum Mana consumed by Starsunder by (.-)%%%.%s*$"},
    [704624]={"^Chance to be critically struck by the Bloodmage is increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [704634]={"^Shadow Damage taken by the Bloodmage increased by (.-)%%%.%s*$"},
    [704637]={"^Absorbs (.-) Physical Damage%.%s*$"},
    [704642]={"^Increases the damage of |cffffffffAtherann's Anguish|r by (.-)%% and your spell critical strike damage bonus by (.-)%%%.%s*$"},
    [704695]={"^Reduces all damage you take by (.-)%%%.%s*$"},
    [704700]={"^Minimum speed cannot be reduced below (.-)%% while a Skeletal Warrior is active%.%s*$"},
    [704720]={"^Undead minion damage increased by (.-)%%%.%s*$"},
    [704727]={"^Cost of Command: Gargoyle reduced by (.-)%%%.%s*$"},
    [704747]={"^Near the Bubble Buddy%.%s*$"},
    [704761]={"^Ticks of |cffffffffSlipstream|r and |cffffffffTorrent|r now cause sharks to attack enemies in their area of effect for (.-) Frost damage%.\
\
Learning this gives |cffffffffTorrent|r a (.-) sec cooldown%.%s*$"},
    [704765]={"^Your next Starcall deals (.-)%% increased damage%.%s*$"},
    [704817]={"^|cffffffffDestroyer's Maw|r now blasts up to (.-) nearby enemies for (.-) Fire damage when used on targets affected by |cffffffffBreath of Malygos|r or |cffffffffBlaze|r%.\
\
This triggers twice on enemies affected by both |cffffffffBreath of Malygos|r and |cffffffffBlaze|r%.%s*$"},
    [704824]={"^Your next Lava Shard doesn't incur a cooldown and costs (.-)%% less mana%.%s*$"},
    [704928]={"^All of your primary stats are increased by (.-)%%%.%s*$"},
    [704975]={"^|cFFFFFFFFMeatsaw|r reduces enemies Armor by (.-)%% for (.-), stacking (.-) times%.%s*$"},
    [704987]={"^At the end of Chainwhip's duration the target will take damage and be slowed%.%s*$"},
    [704988]={"^Increases your critical strike chance by (.-)%%%s*$"},
    [705008]={"^Attack power increased by (.-)%%%.%s*$"},
    [705022]={"^Bleeding for (.-) Physical Damage every (.-) sec%.%s*$"},
    [705071]={"^Increases the damage of Falconstrike by (.-)%%, stacking (.-) times%.%s*$"},
    [705080]={"^|cffffffffHorns|r now allow the use of |cffffffffToxic Dart|r as if you were in |cffffffffElude|r, and reduces its duration by (.-)%% and increases its damage dealt by (.-)%% for (.-)%.\
\
In addition, periodic damage dealt by your |cffffffffToxic Dart|r can now critically strike%.%s*$"},
    [705102]={"^Increases Armor penetration by (.-)%% of Agility%.%s*$"},
    [705117]={"^Physical Damage dealt reduced by (.-)%%%.%s*$"},
    [705145]={"^Increases the damage of your next Sargeron Smite by (.-)%%%.%s*$"},
    [705168]={"^Melee attack speed increased by (.-)%%%.%s*$"},
    [705198]={"^Your Throw Weapon has transformed into Rapid Throw!%s*$"},
    [705214]={"^Damage taken by the Barbarian increased by (.-)%%%.%s*$"},
    [705234]={"^Berserker Axe damage increased by (.-)%%%.%s*$"},
    [705286]={"^Damage dealt and movement speed increased (.-)%%%.%s*$"},
    [705291]={"^|cffffffffRighteous Lunge|r and |cffffffffChastise|r used on enemies affected by |cffffffffCondemn|r now deal an additional (.-) Holy Damage%.%s*$"},
    [705305]={"^Causes |cffffffffGrace of Aman'Thul|r to also reduce the chance that you gain a |cffffffffBroken Ward|r stack by (.-)%%%.%s*$"},
    [705329]={"^Increases the damage of |cffffffffLinebreaker|r by (.-)%%%.%s*$"},
    [705346]={"^|cffffffffRaise Shield|r extends the duration of |cffffffffShieldforge|r by (.-) sec%.%s*$"},
    [705352]={"^Direct damage will deal additional Holy damage%.%s*$"},
    [705377]={"^Strength and Stamina increased by (.-)%%%.%s*$"},
    [705421]={"^Your Infernal Strike has transformed into Annihilation!%s*$"},
    [705434]={"^Armor increased by (.-)%%%. Parry chance increased by (.-)%%%.%s*$"},
    [705473]={"^(.-)%% of all damage taken will be shared with the WItch Hunter%.%s*$"},
    [705491]={"^Causes critical strikes from |cffffffffShadowblast|r and |cffffffffSaber Slash|r to reduce the cooldown of |cffffffffHoundmaster's Call|r by (.-) sec and |cffffffffFlourish|r by (.-) sec%.%s*$"},
    [705492]={"^You may cast Darkslayer while moving%.%s*$"},
    [705567]={"^Damage taken from |cffffffffRuneblade|r and |cffffffffElemental Burst|r is increased by (.-)%%%.%s*$"},
    [705619]={"^After (.-) you will be rooted for a short time and suffer Frost damage%.%s*$"},
    [705671]={"^|cffffffffDischarge|r reduces the remaining cooldown of |cffffffffThunderstrike|r by (.-) sec%.%s*$"},
    [705673]={"^Damage of next Call Lightning or Torrential Wrath increased by (.-)%%%.%s*$"},
    [705675]={"^Spell damage increased by (.-)%%%.%s*$"},
    [705692]={"^Your Forked Lightning has transformed into Thunder Wave!%s*$"},
    [705715]={"^Spell haste increased by (.-)%%%. Damage increased by (.-)%%%. Healing for (.-) every (.-) sec%.%s*$"},
    [705747]={"^Reduces the cost of |cffffffffAnimate|r and |cffffffffRaise|r spells by (.-)%%%.%s*$"},
    [705782]={"^Increases the damage of |cffffffffRifle Scrap Shots|r and |cffffffffShotgun Scrap Shots|r by (.-)%%%.%s*$"},
    [705805]={"^Cast time of Repair Shot and Scrap Shot reduced by (.-)%%%.%s*$"},
    [705810]={"^Cannot benefit from Backup Fuel%.%s*$"},
    [705815]={"^Your next Rocket Launcher is instant cast%.%s*$"},
    [705820]={"^Reduces the remaining cooldown of Rockadier by (.-) sec%.%s*$"},
    [705843]={"^|cffffffffStrike of the Gods|r increases damage taken from you by (.-)%% for (.-) sec, stacking (.-) times%.%s*$"},
    [705856]={"^Increases the damage and healing of effects triggered by |cffffffffPotion Toss|r by (.-)%%%.%s*$"},
    [705886]={"^Your Spirit's Refuge will trigger again at the end of the duration%.%s*$"},
    [705922]={"^Increases the damage of |cffffffffHir'eek|r and |cffffffffBwonsamdi|r spells by (.-)%%, and boosts spell power by (.-)%% of Intellect%.%s*$"},
    [705942]={"^Increases the damage of your next |cffffffffMalefic Arrow|r by (.-)%%, stacking (.-) times%.%s*$"},
    [705951]={"^Nature damage inflicted every (.-) sec%.%s*$"},
    [706026]={"^Damage taken by the Venomancer is increased by (.-)%%%.%s*$"},
    [706028]={"^Healing of your |cffffffffShadra's Prayer|r or Serpent's Fang increased by (.-)%%%.%s*$"},
    [706044]={"^Timerend cannot expire on this target%.%s*$"},
    [706076]={"^Your next Artificer's Wand is instant cast and generates an \
Echo Fragment%.%s*$"},
    [706080]={"^|cffffffffDestroyer's Maw|r now blasts up to (.-) nearby enemies for (.-) Fire damage when used on targets affected by |cffffffffBreath of Malygos|r or |cffffffffBlaze|r%.\
\
This triggers twice on enemies affected by both |cffffffffBreath of Malygos|r and |cffffffffBlaze|r%.%s*$"},
    [706134]={"^Extends Accelerated Recovery%s*$"},
    [706159]={"^Geode Barrage is transformed into Seismic Lance!%s*$"},
    [706173]={"^Your next Geode Barrage is instant cast%.%s*$"},
    [706218]={"^Your |cffffffffBoons|r restore (.-) health to affected allies, scaling with attack power and spell power%.%s*$"},
    [706240]={"^Damage taken from Witchbane increased by (.-)%%%.%s*$"},
    [706258]={"^Movement speed increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [706268]={"^Your next Sargeron Smite is guaranteed to critically strike for (.-)%% increased damage%.%s*$"},
    [706271]={"^Damage dealt by your next Venomfang or Widow's Kiss is increased by (.-)%%%.%s*$"},
    [706297]={"^Total Static increased by (.-)%.%s*$"},
    [706375]={"^Increases the damage of |cffffffffSticky Bomb|r by (.-)%%%.%s*$"},
    [706377]={"^Cast time of your next Rocket Launcher reduced by (.-)%% and Reloads your gun%.%s*$"},
    [706425]={"^Your next Sargeron Smite is guaranteed to critically strike for (.-)%% increased damage%.%s*$"},
    [706472]={"^Increases Necromancer's Spell Power by a percentage of the active minion's Stamina%.\
\
Granting (.-) Spell damage%.%s*$"},
    [706510]={"^Your Spirit's Refuge will trigger again at the end of the duration%.%s*$"},
    [706551]={"^Damage taken from Hex of Malice increased by (.-)%%%.%s*$"},
    [706574]={"^Damage taken from Scattered Stars increased by (.-)%%%.%s*$"},
    [706575]={"^Your next Moonwell Splash is castable while moving and has a (.-)%% reduced cast time%. Stacks (.-) times%.%s*$"},
    [706603]={"^Your next Ravenous Strike or Bloodmoon Blast is instant cast and guaranteed to critically strike%.%s*$"},
    [706608]={"^Draining life from corpses%.%s*$"},
    [706637]={"^Increases attack power by (.-)%% and reduces the global cooldown triggered by |cffffffffValiant Strike|r by (.-) sec%.%s*$"},
    [706698]={"^|cffffffffTelescopic Focusing Lens|r to make all of your Sentry Turrets fire a Rocket Cluster on their next attack, causing (.-) Fire damage%. Subsequent Rocket Clusters in quick succession deal increasing damage%.%s*$"},
    [706703]={"^Allows you to use a Follow Up Ability such as Righteous Lunge, Condemn, Holy Cleave, Vindication, and Vindication%.%s*$"},
    [706722]={"^Damage dealt of the next Wrath of the Black Empire is increased by (.-)%%%.%s*$"},
    [706755]={"^Increases imp maximum health by (.-)%%%.%s*$"},
    [706796]={"^|cffffffffSoul Tap|r, |cffffffffLament|r and |cffffffffSoulwarden's Resolve|r reduce the remaining cooldown of |cffffffffRequiem|r by (.-) sec on use%.%s*$"},
    [706896]={"^Damage from the Pyromancer's Destroyer's Maw attack increased by (.-)%% per stack%. Stacks (.-) times%.%s*$"},
    [706916]={"^Damage dealt by Wrath of the Black Empire is increased by (.-)%% per stack%. Stacks (.-) times%.%s*$"},
    [706940]={"^Healing done reduced by (.-)%%%. Spell Haste increased by (.-)%%%.%s*$"},
    [706959]={"^Your next Venom Fang strikes up to (.-) targets%.%s*$"},
    [706986]={"^Parry rating increased by (.-) plus (.-)%% of Stamina%. Successful parries cause (.-)%% Weapon Damage to nearby enemies%.%s*$"},
    [707005]={"^Your next Command: Skeletal Mages deals additional damage to your primary target%.%s*$"},
    [707006]={"^Your next Command: Skeletal Mages deals additional damage to your primary target%.%s*$"},
    [707007]={"^Movement slowed by (.-)%%%.%s*$"},
    [707055]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [707102]={"^Enraged%. Rapidly draining Energy%. Berserker Axe knocks enemies back, is free of cost, and guaranteed to critically strike%.\
\
Critical strikes reduce the cooldown of |cffffffffBerserker|r by (.-) sec%.%s*$"},
    [707103]={"^Enraged%. Rapidly draining Energy%. Berserker Axe knocks enemies back, is free of cost, and guaranteed to critically strike%.\
\
Critical strikes reduce the cooldown of |cffffffffBerserker|r by (.-) sec%.%s*$"},
    [707120]={"^Damage dealt by Wrath of the Black Empire is increased by (.-)%% per stack%. Stacks (.-) times%.%s*$"},
    [707183]={"^Damage dealt of the next Wrath of the Black Empire is increased by (.-)%%%.%s*$"},
    [707199]={"^Periodic damage from the Pyromancer increased by (.-)%% and all healing received reduced by (.-)%%%.%s*$"},
    [707208]={"^Allows you to use a Follow Up Ability such as Righteous Lunge, Condemn, Holy Cleave, Vindication, and Vindication%.%s*$"},
    [707215]={"^Your next |cFFFFFFFFGeode Barrage|r is instant cast%.%s*$"},
    [707220]={"^Your Forked Lightning has transformed into Thunder Wave!%s*$"},
    [707242]={"^Increases the damage dealt by your Sapper Charge detonation, and your Sticky Bomb Detonation by 15%%%.Also increases all Fire damage dealt by an additional 10%%%.%s*$"},
    [707246]={"^Rocket Launcher casts (.-)%% faster, stacking (.-) times%.\
\
Additional applications do not refresh the duration%.%s*$"},
    [707249]={"^Scrap Shot has a chance to reset the cooldown of Gunsling%.%s*$"},
    [707271]={"^Your next Bomb Toss incurs no cooldown, global cooldown, or cost%.%s*$"},
    [707283]={"^Inflicts direct physical damage%.%s*$"},
    [707284]={"^Inflicts direct physical damage%.%s*$"},
    [707314]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [707356]={"^Damage taken from the Sun Cleric's Horusath Blast increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [707388]={"^Restores (.-)%% max health every second%.%s*$"},
    [707417]={"^Using |cffffffffReload|r now increases haste by (.-)%% for (.-)%.%s*$"},
    [707455]={"^This target is close to dying%. Deathchaser will periodically refresh itself%.%s*$"},
    [707467]={"^Enraged%. Rapidly draining Energy%. Berserker Axe knocks enemies back, is free of cost, and guaranteed to critically strike%.\
\
Critical strikes reduce the cooldown of |cffffffffBerserker|r by (.-) sec%.%s*$"},
    [707482]={"^Critical damage increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [707562]={"^Increases the critical damage of your next |cFFFFFFFFGlacial Impact|r by (.-)%%%.%s*$"},
    [707589]={"^Cannot benefit from Cryoshroud%.%s*$"},
    [707594]={"^Increases the bonus to periodic healing received applied by |cffffffffRitual Healing|r by (.-)%%%.%s*$"},
    [707617]={"^Allows |cFFFFFFFFMojo Beam|r to critically heal%.%s*$"},
    [707618]={"^Forked Lightning, Call Lightning, and Electrocute causes (.-)%% increased damage and Electrocute strikes (.-) additional enemies%.%s*$"},
    [707621]={"^Your next Heavy Blow triggers no cooldown%.%s*$"},
    [707623]={"^You now heal for (.-)%% of all damage you deal%.%s*$"},
    [707628]={"^Damage taken by the Stormbringers |cffffffffTorrential Wrath|r increased by (.-)%%%.%s*$"},
    [707650]={"^Can be consumed by Umbral Glaive to reduce the cooldown of the Witch Doctor's Spirit Glaive spell%.%s*$"},
    [707724]={"^Stunned by Elune's light%.%s*$"},
    [707725]={"^Stunned by Elune's light%.%s*$"},
    [707740]={"^Inflicts direct physical damage%.%s*$"},
    [707758]={"^Increases the critical damage of your next |cFFFFFFFFGlacial Impact|r by (.-)%%%.%s*$"},
    [707779]={"^Berserker Axe damage increased by (.-)%%%.%s*$"},
    [707790]={"^Damage from the Pyromancer's Destroyer's Maw attack increased by (.-)%% per stack%. Stacks (.-) times%.%s*$"},
    [707792]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [707820]={"^Increases the damage of |cffffffffLinebreaker|r by (.-)%%%.%s*$"},
    [707839]={"^Restores (.-)%% max health every second%.%s*$"},
    [707842]={"^Increases Armor penetration by (.-)%% of Agility%.%s*$"},
    [707858]={"^Increases the damage and healing of effects triggered by |cffffffffPotion Toss|r by (.-)%%%.%s*$"},
    [707865]={"^Increases the damage of |cffffffffAtherann's Anguish|r by (.-)%% and your spell critical strike damage bonus by (.-)%%%.%s*$"},
    [707875]={"^After (.-) you will be rooted for a short time and suffer Frost damage%.%s*$"},
    [707880]={"^Reduces the cost of |cffffffffAnimate|r and |cffffffffRaise|r spells by (.-)%%%.%s*$"},
    [707881]={"^Your next Command: Skeletal Mages deals additional damage to your primary target%.%s*$"},
    [712299]={"^Magic Damage dealt by the Runemaster is increased by (.-)%%%.%s*$"},
    [712301]={"^Magic Damage dealt by the Runemaster is increased by (.-)%%%.%s*$"},
    [712302]={"^Magic Damage dealt by the Runemaster is increased by (.-)%%%.%s*$"},
    [712303]={"^Magic Damage dealt by the Runemaster is increased by (.-)%%%.%s*$"},
    [712304]={"^Magic Damage dealt by the Runemaster is increased by (.-)%%%.%s*$"},
    [712305]={"^Magic Damage dealt by the Runemaster is increased by (.-)%%%.%s*$"},
    [712306]={"^Magic Damage dealt by the Runemaster is increased by (.-)%%%.%s*$"},
    [712307]={"^Magic Damage dealt by the Runemaster is increased by (.-)%%%.%s*$"},
    [712322]={"^Magic Damage dealt by the Runemaster is increased by (.-)%%%.%s*$"},
    [712326]={"^Chance to trigger Weapon Engravings increased by (.-)%%%.%s*$"},
    [712330]={"^Chance to trigger Weapon Engravings increased by (.-)%%%.%s*$"},
    [712331]={"^Chance to trigger Weapon Engravings increased by (.-)%%%.%s*$"},
    [712332]={"^Chance to trigger Weapon Engravings increased by (.-)%%%.%s*$"},
    [712333]={"^Chance to trigger Weapon Engravings increased by (.-)%%%.%s*$"},
    [712334]={"^Chance to trigger Weapon Engravings increased by (.-)%%%.%s*$"},
    [712335]={"^Chance to trigger Weapon Engravings increased by (.-)%%%.%s*$"},
    [712342]={"^Damage dealt by Crow's Harvest, Dark Fate, and Red Wake increased by (.-)%%%.%s*$"},
    [712404]={"^Your Primordial Blast has transformed into Stratus!%s*$"},
    [712462]={"^Stunned by Elune's light%.%s*$"},
    [712668]={"^Your Primordial Blast has transformed into Ignis!%s*$"},
    [712858]={"^Your Primordial Blast has transformed into Lithos!%s*$"},
    [713002]={"^Your Primordial Blast has transformed into Hydros!%s*$"},
    [760011]={"^Cloudburst%s*$"},
    [760436]={"^You are using your Shotgun%.\
\
Scrap Shot has reduced range and deals less damage, but has increased Critical Strike chance and hits multiple enemies in a small cone%.%s*$"},
    [760440]={"^You are using your Shotgun%.\
\
Scrap Shot has reduced range and deals less damage, but has increased Critical Strike chance and hits multiple enemies in a small cone%.%s*$"},
    [800045]={"^Threat generated increased by (.-)%%%. Doubled with Frost or Shadow spells and abilities%.%s*$"},
    [800051]={"^Threat generated increased by (.-)%%%. Doubled with Frost or Shadow spells and abilities%.%s*$"},
    [800080]={"^Generates Focus%s*$"},
    [800083]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [800131]={"^Armor penetration and movement speed increased by (.-)%%%.%s*$"},
    [800142]={"^Damage Taken reduced by (.-)%%%.%s*$"},
    [800148]={"^A Rotling is active%.%s*$"},
    [800150]={"^Critical strike chance and damage dealt increased by (.-)%%%.%s*$"},
    [800165]={"^Your next Bolt ability does (.-)%% increased damage and has (.-)%% increased duration%.%s*$"},
    [800178]={"^Increases the damage of |cffffffffPrimal Shred|r by (.-)%% and reduces its Rage cost by (.-)%.%s*$"},
    [800316]={"^You may now use Reprisal!%s*$"},
    [800360]={"^You may reactivate Hookshot on a bleeding target to deal additional damage and drag yourself to them%.%s*$"},
    [800370]={"^Healing over time%.%s*$"},
    [800463]={"^Next Blade of the Empire deals more damage and strikes and additional target%.%s*$"},
    [800504]={"^The Starcaller's Huntress Shot ability heals you for a small amount%.%s*$"},
    [800518]={"^Damage of Righteous Upheaval and Divine Fury increased by (.-)%%%.%s*$"},
    [800570]={"^Next attack delivers a devastating strike to an enemy, dealing (.-) Physical Damage%.%s*$"},
    [800685]={"^Your next Skullpiercer or Precision Shot is instant and deals (.-)%% increased damage per stack%.%s*$"},
    [800724]={"^Firing a magic missile every (.-) sec%.%s*$"},
    [800756]={"^Absorption of Rune of Guarding increased by (.-)%%%.%s*$"},
    [800776]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [800790]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [800811]={"^Critical strike chance of your |cffffffffLava Shard|r, |cffffffffExplode|r, or |cffffffffFlare Bolt|r increased by (.-)%% until one of these abilities critically strike%.%s*$"},
    [800813]={"^Damage of next Destroyer's Maw increased by (.-)%%%.%s*$"},
    [800936]={"^A Rotling is active%.%s*$"},
    [800977]={"^Losing (.-)%% of your Maximum Rage every (.-) sec%.\
\
This effect is applied when you leave Spider Form or Beetle Form, and is removed when you enter one of these forms again%.%s*$"},
    [801022]={"^Attack Speed increased by (.-)%%%.%s*$"},
    [801091]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [801122]={"^Nearby enemies suffer (.-) Acane Damage every (.-) sec\
\
When this ends, nearby enemies are Stunned for (.-)%.%s*$"},
    [801179]={"^Charging up%.%.%.%s*$"},
    [801234]={"^Increases the Critical Strike Damage Bonus of your Wildclaw ability by (.-)%%, and reduces the Cooldown of your Primal Charge and Bear's Maw abilities by (.-)%%%.%s*$"},
    [801325]={"^When this expires, you are healed for (.-)%% of your maximum health and reduce the cooldown of Bolstered Form by (.-) sec%.%s*$"},
    [801546]={"^Heals the next time you take damage%.%s*$"},
    [801589]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [801652]={"^Damage taken reduced by (.-)%%%. Redirecting (.-)%% of all damage taken to the Barbarian%.%s*$"},
    [801674]={"^Allows |cffffffffHexing Strike|r to strike (.-) enemies%.%s*$"},
    [801731]={"^Deals (.-) Frost damage every second%. Chance to be critically struck by Lichfrost increased by (.-)%%%.%s*$"},
    [801745]={"^After (.-), an air strike will be launched to your position%.%s*$"},
    [801787]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [801788]={"^Taking (.-) additional damage every (.-) sec%.%s*$"},
    [801792]={"^Healing received reduced by (.-)%%%. Immune to fear%. Dealing damage has a chance to empower allies%.%s*$"},
    [801820]={"^Next |cffffffffScrap Shot|r deals (.-)%% increased damage, and then shoots an additional time%.%s*$"},
    [801838]={"^Cloudburst%s*$"},
    [801839]={"^Deals damage based on first instance of Aeroblast%.%s*$"},
    [801844]={"^Deals nature damage%.%s*$"},
    [801860]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [801901]={"^Recently used Twin Slice%.%s*$"},
    [801939]={"^Dealing (.-) Plague Damage to enemies within (.-) yds%.%s*$"},
    [802092]={"^Damage and critical strike chance increased by (.-)%%%s*$"},
    [802114]={"^Drains (.-) health every (.-) sec to the caster, or causes healing to an ally%.%s*$"},
    [802127]={"^Armor and Magical Resistances increased%.%s*$"},
    [802133]={"^Taking Plague damage every (.-) sec%.%s*$"},
    [802165]={"^Damage of your next direct spell increased by (.-)%%%.%s*$"},
    [802271]={"^Physical Attacks heal you equal to (.-)%% of the damage dealt%.%s*$"},
    [802296]={"^Increases Dodge Chance by (.-)%%, Movement Speed by (.-)%%, Attack Power by (.-)%% of Agility, and boosts the damage of Death Ram and Death Sentence by (.-)%%%.%s*$"},
    [802314]={"^Gives direct Shadow Damage and healing effects a (.-)%% chance to cause a |cffffffffBloodsore|r, stacking (.-) times%.\
\
|cffffffffLifedrinker|r ticks consume a stack of |cffffffffBloodsore|r to increase the damage or healing of subsequent ticks by (.-)%%%.%s*$"},
    [802394]={"^You may reactivate Hookshot on a bleeding target to deal additional damage and drag yourself to them%.%s*$"},
    [802395]={"^You may reactivate Hookshot on a bleeding target to deal additional damage and drag yourself to them%.%s*$"},
    [802396]={"^You may reactivate Hookshot on a bleeding target to deal additional damage and drag yourself to them%.%s*$"},
    [802397]={"^You may reactivate Hookshot on a bleeding target to deal additional damage and drag yourself to them%.%s*$"},
    [802398]={"^You may reactivate Hookshot on a bleeding target to deal additional damage and drag yourself to them%.%s*$"},
    [802487]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [802553]={"^Increases the damage of |cffffffffPrimal Shred|r by (.-)%% and reduces its Rage cost by (.-)%.%s*$"},
    [802554]={"^Increases the damage of |cffffffffPrimal Shred|r by (.-)%% and reduces its Rage cost by (.-)%.%s*$"},
    [802555]={"^Increases the damage of |cffffffffPrimal Shred|r by (.-)%% and reduces its Rage cost by (.-)%.%s*$"},
    [802556]={"^Increases the damage of |cffffffffPrimal Shred|r by (.-)%% and reduces its Rage cost by (.-)%.%s*$"},
    [802557]={"^Increases the damage of |cffffffffPrimal Shred|r by (.-)%% and reduces its Rage cost by (.-)%.%s*$"},
    [802567]={"^Fire Crit Chance increased by (.-)%%%.%s*$"},
    [802576]={"^Drains (.-) health every (.-) sec to the caster, or causes healing to an ally%.%s*$"},
    [802581]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [802582]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [802583]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [802584]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [802585]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [802586]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [802616]={"^The barely contained power of Xoroth resonates through Grol's body, amplifying his power, but cracking his flesh%.%.%.\
\
Damage taken increased by (.-)%%%.%s*$"},
    [802629]={"^Your Heavy Blow has transformed into Paragon Smash!%s*$"},
    [802739]={"^You may now use Reprisal!%s*$"},
    [802740]={"^You may now use Reprisal!%s*$"},
    [802741]={"^You may now use Reprisal!%s*$"},
    [802742]={"^You may now use Reprisal!%s*$"},
    [802743]={"^You may now use Reprisal!%s*$"},
    [802744]={"^You may now use Reprisal!%s*$"},
    [802881]={"^Increases the effectiveness of Harvest Time by (.-)%%%.%s*$"},
    [802890]={"^Increasing the movement speed of allies by (.-)%%, and reducing the movement speed of enemies by (.-)%%%.%s*$"},
    [803030]={"^Absorbs (.-) Damage%.%s*$"},
    [803058]={"^Your next Blade of the Empire has increased range, and deals bonus Shadow Damage scaling with spell power, and Insanity%.%s*$"},
    [803117]={"^Melee Attack Power increased by (.-)%%%. Cost of Beastslayer reduced by (.-)%%%.%s*$"},
    [803132]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [803154]={"^Taking (.-) Holy damage every (.-) sec%.%s*$"},
    [803155]={"^Taking (.-) Holy damage every (.-) sec%.%s*$"},
    [803156]={"^Taking (.-) Holy damage every (.-) sec%.%s*$"},
    [803161]={"^Critical Strike Rating and Spirit increased by (.-)%.%s*$"},
    [803163]={"^Reduces the cooldown and increases the tick rate of your next Blade of Faith by (.-)%%%. Stacks (.-) times%.%s*$"},
    [803170]={"^Causes |cffffffffGrace of Aman'Thul|r to also reduce the chance that you gain a |cffffffffBroken Ward|r stack by (.-)%%%.%s*$"},
    [803201]={"^Healing taken increased by (.-)%%%. Healing for (.-) every (.-) sec%.%s*$"},
    [803202]={"^|cffffffffHivebreak|r consumes (.-) sec of your |cffffffffVenomtip Poison's|r duration to gush toxic slime, causing (.-) Nature damage to enemies within (.-)yd%.%s*$"},
    [803385]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [803388]={"^Damage taken from the Accursed Bloodmage is increased by (.-)%%%.%s*$"},
    [803389]={"^Damage taken from the Accursed Bloodmage is increased by (.-)%%%.%s*$"},
    [803420]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [803534]={"^Increases the damage of |cffffffffPrimal Shred|r by (.-)%% and reduces its Rage cost by (.-)%.%s*$"},
    [803554]={"^The Starcaller's Huntress Shot ability heals you for a small amount%.%s*$"},
    [803602]={"^Healing received reduced by (.-)%%%. Immune to fear%. Dealing damage has a chance to empower allies%.%s*$"},
    [803603]={"^Healing received reduced by (.-)%%%. Immune to fear%. Dealing damage has a chance to empower allies%.%s*$"},
    [803604]={"^Healing received reduced by (.-)%%%. Immune to fear%. Dealing damage has a chance to empower allies%.%s*$"},
    [803605]={"^Healing received reduced by (.-)%%%. Immune to fear%. Dealing damage has a chance to empower allies%.%s*$"},
    [803680]={"^Curing (.-) poison effects every (.-)%.%s*$"},
    [803850]={"^Critical strikes dealt now have a (.-)%% chance to apply a stack of |cffffffffDeathchill|r%.%s*$"},
    [803886]={"^Your Shadow Hound cannot cast Darkhowl%.%s*$"},
    [803914]={"^Increases the damage of |cffffffffPrimal Shred|r by (.-)%% and reduces its Rage cost by (.-)%.%s*$"},
    [803999]={"^Threat generated increased by (.-)%%%. Doubled with Frost or Shadow spells and abilities%.%s*$"},
    [804030]={"^Your Critical Strikes with Holy Damage Spells set the target ablaze with Burning Light, causing (.-) Fire Damage over (.-)%.%s*$"},
    [804032]={"^Holy damage taken by the Paladin increased by (.-)%%%.%s*$"},
    [804059]={"^Allows you to cast all of your spells while moving%.%s*$"},
    [804133]={"^Melee auto attacks deal an additional (.-)%% of the damage dealt as Holy damage%.%s*$"},
    [804177]={"^Direct Physical damage dealt now has a (.-)%% chance to refresh a |cffffffffSpread Shot|r charge%.%s*$"},
    [804199]={"^You now heal for (.-)%% of all damage you deal%.%s*$"},
    [804250]={"^Haste increased by (.-)%%%. Damage increased by (.-)%%%.%s*$"},
    [804254]={"^Deflecting the next harmful spell cast upon you%.%s*$"},
    [804278]={"^Call Lightning damage increased by (.-)%%%s*$"},
    [804287]={"^Gain (.-) Intellect equal to portion of your Strength%.%s*$"},
    [804404]={"^Your next Damnation is usable regardless of the target's current health%.%s*$"},
    [804451]={"^Movement speed increased by (.-)%%%.\
\
Your next Reverse Wound consumes this effect to critically strike and cast instantly%.%s*$"},
    [804617]={"^Your Calamity spell is now Instant%.%s*$"},
    [804630]={"^Your next Dawnsear strikes twice and launches a Solar Flare%.%s*$"},
    [804638]={"^Praise the Loa!%s*$"},
    [804651]={"^Your next attack will cause you to cast Gift of the Loa%.%s*$"},
    [804655]={"^Taking Nature damage every (.-) sec%.%s*$"},
    [804721]={"^Your next attack will cause you to cast Gift of the Loa%.%s*$"},
    [804748]={"^Restoring health and mana%.%s*$"},
    [804752]={"^Battering nearby enemies with holy hammers%.%s*$"},
    [804930]={"^Heals the next time you take damage%.%s*$"},
    [804941]={"^Duelist Strike global cooldown reduced by (.-)%%%. Stacks (.-) times%.%s*$"},
    [804989]={"^Damage taken by Mushrooms, Big Mushrooms, and Fungal Assailants increased by (.-)%%%.%s*$"},
    [805038]={"^You are in range of your Scourge Transporter%.%s*$"},
    [805104]={"^You're now a Serpent Lord, gives some of your Spider Form abilities a short cast time and (.-) yds of increased range%. Spells suffer (.-)%% less pushback from enemy attacks%.\
\
Cost of Withering Venom is increased by (.-)%%, and now creates a Miasma%.%s*$"},
    [805107]={"^(.-)%% of all damage you take is redirected to the Primalist%.%s*$"},
    [805183]={"^Healing for (.-)%% of your Maximum Health every (.-) sec%. Physical Damage taken reduced by (.-)%%%.%s*$"},
    [805194]={"^Increases the effectiveness of abilities that require |cff5ee2ffSoul Infusion|r by (.-)%%%.%s*$"},
    [805204]={"^Damage of Reap and Slaughter increased by (.-)%%%.%s*$"},
    [805205]={"^Bleeding for (.-) Physical Damage every (.-) sec%.%s*$"},
    [805245]={"^Maximum health increased by (.-)%.%s*$"},
    [805358]={"^Your Raise and Animate spells cost no mana and are instant cast%.%s*$"},
    [805359]={"^Your Raise and Animate spells cost no mana and are instant cast%.%s*$"},
    [805360]={"^Being guarded by a Sun Cleric%.%s*$"},
    [805367]={"^Frost damage increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [805483]={"^Increases the critical strike chance of Lava Shard by (.-)%%%.%s*$"},
    [805487]={"^Movement Speed increased by (.-)%%, Critical Strike Chance increased by (.-)%%, and healing taken from the Pyromancer's Path of Flames increased by (.-)%%%.%s*$"},
    [805536]={"^Your next Dawnsear strikes twice and launches a Solar Flare%.%s*$"},
    [805548]={"^Huntress Shot will hit (.-) additional enemies%.%s*$"},
    [805591]={"^Gives direct Shadow Damage and healing effects a (.-)%% chance to cause a |cffffffffBloodsore|r, stacking (.-) times%.\
\
|cffffffffLifedrinker|r ticks consume a stack of |cffffffffBloodsore|r to increase the damage or healing of subsequent ticks by (.-)%%%.%s*$"},
    [805601]={"^Being struck with a blast of molten slag every (.-) sec%.%s*$"},
    [805670]={"^Increases the damage of the |cffffffffUnleash|r effect of |cffffffffPestilence of Apocalypse|r by (.-)%% and its duration is increased by (.-) sec%.%s*$"},
    [805711]={"^All damage taken reduced by (.-)%%%.%s*$"},
    [805715]={"^Parry rating increased by (.-) plus (.-)%% of Stamina%. Successful parries cause (.-)%% Weapon Damage to nearby enemies%.%s*$"},
    [805717]={"^Time between attacks increased by (.-)%%%.%s*$"},
    [805724]={"^Movement speed by (.-)%%%.%s*$"},
    [805834]={"^|cFFFFFFFFThrow Weapon|r, |cffffffffGutspiller|r, and |cFFFFFFFFBerserker Axe|r hit (.-) nearby enemy%.%s*$"},
    [805893]={"^Allows |cffffffffGutspiller|r and |cffffffffPiercing Throw|r to bounce to (.-) additional enemies%.%s*$"},
    [805960]={"^Your next Dawnsear strikes twice and launches a Solar Flare%.%s*$"},
    [805968]={"^Absorbs (.-) Damage%.%s*$"},
    [805969]={"^When this expires, you are healed for (.-)%% of your maximum health and reduce the cooldown of Bolstered Form by (.-) sec%.%s*$"},
    [805979]={"^Scrap Shots or Rocket Launchers will launch an additional Rocket at the target%.%s*$"},
    [805980]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [806060]={"^Damage taken from Sunflare and Dawnsear increased by (.-)%%%.%s*$"},
    [806073]={"^Your melee attacks and abilities heal nearby allies and damage nearby enemies for (.-)%% of the damage dealt%.%s*$"},
    [806111]={"^Bleeding for Physical damage every (.-) seconds%.%s*$"},
    [806140]={"^Inspiring Speech is instant and costs (.-) less Energy%.%s*$"},
    [806162]={"^Healing done by your next Fabric of Time increased by (.-)%% per stack, stacking (.-) times%.%s*$"},
    [806207]={"^|cffffffffGlorious Execution|r now grants an additional |cffffffffDaybreak|r stack%.%s*$"},
    [806219]={"^At the end of Chainwhip's duration the target will take damage and be slowed%.%s*$"},
    [806245]={"^|cffffffffSandblast|r and |cffffffffEpoch|r reduce the cooldown of |cffffffffSand Bomb|r by (.-) sec%.%s*$"},
    [806251]={"^Your next Blade of the Empire has increased Range, and deals bonus Shadow Damage scaling with Spell Power, Attack Power, and Insanity%.%s*$"},
    [806270]={"^Takes (.-)%% increased healing from the Chronomancer's next Reverse Wound spell%.%s*$"},
    [806271]={"^Increases the healing of your Loa's Brew by (.-)%%%.%s*$"},
    [806274]={"^Absorbs (.-) Physical Damage%.%s*$"},
    [806321]={"^Damage taken from further Skeletal Blades increased by (.-)%%%.%s*$"},
    [806324]={"^Increases spell damage taken by (.-)%%%.%s*$"},
    [806338]={"^Cast time of your next Reverse Wound is reduced by (.-)%%%.%s*$"},
    [806365]={"^|cffffffffHorns|r now allow the use of |cffffffffToxic Dart|r as if you were in |cffffffffElude|r, and reduces its duration by (.-)%% and increases its damage dealt by (.-)%% for (.-)%.\
\
In addition, periodic damage dealt by your |cffffffffToxic Dart|r can now critically strike%.%s*$"},
    [806414]={"^Damage taken from the caster's Shock increased by (.-)%%%.%s*$"},
    [806424]={"^Your next Sanguine Mend is instant cast%.%s*$"},
    [806502]={"^Striking nearby enemies%.%s*$"},
    [806536]={"^Your next Mending Growth heals for (.-)%% more, is instant cast, and costs (.-)%% less mana%.%s*$"},
    [806699]={"^Your next Glorious Execution will incur no cooldown%.%s*$"},
    [806711]={"^|cffffffffPrimal Shred|r deals (.-)%% increased damage%.%s*$"},
    [806734]={"^Reduces the cooldown of |cffffffffConvergence|r by (.-) sec%.%s*$"},
    [806738]={"^Chance for Aspect of the Warden to proc by (.-)%%%.%s*$"},
    [806744]={"^|cffffffffCinderheart|r and |cffffffffLava Shard|r now reduces the cooldown of |cffffffffTide of Fire|r and |cffffffffSunstrider Array|r by (.-) sec%.%s*$"},
    [806764]={"^Taking Fire damage%.%s*$"},
    [806797]={"^Increases haste by (.-)%%%.%s*$"},
    [806840]={"^Time between attacks increased by (.-)%%%.%s*$"},
    [806841]={"^Time between attacks increased by (.-)%%%.%s*$"},
    [806842]={"^Time between attacks increased by (.-)%%%.%s*$"},
    [806843]={"^Time between attacks increased by (.-)%%%.%s*$"},
    [806844]={"^Time between attacks increased by (.-)%%%.%s*$"},
    [806845]={"^Time between attacks increased by (.-)%%%.%s*$"},
    [806993]={"^Absorbing the life force of the four conduits, Sulfuron Harbinger surrounds himself in Devastating Flames%.%s*$"},
    [806994]={"^Absorbing the life force of the four conduits, Sulfuron Harbinger surrounds himself in Devastating Flames%.%s*$"},
    [807058]={"^Damage taken from Sunflare and Dawnsear increased by (.-)%%%.%s*$"},
    [807096]={"^Increases flight speed by (.-)%%%.%s*$"},
    [807101]={"^(.-)%% of all damage taken will be shared with the WItch Hunter%.%s*$"},
    [807122]={"^Taking extra damage from the Barbarian%.%s*$"},
    [807158]={"^|cffffffffEpoch|r's cast time is reduced by (.-)%% and it's mana cost is reduced by (.-)%%, and it now reduces the target's damage taken by (.-)%% for (.-)%.%s*$"},
    [807233]={"^Your next Storm Alert or Torrential Wrath is instant cast%.%s*$"},
    [807297]={"^Increases the damage of your next Pulverize, Death Ram, or Centurion Strike by (.-)%%%.%s*$"},
    [807380]={"^When this expires, you are healed for (.-)%% of your maximum health and reduce the cooldown of Bolstered Form by (.-) sec%.%s*$"},
    [807519]={"^ and increases bonus damage |cFFFFFFFFSerrated Shot|r receives from ranged attack power by (.-)%%%.%s*$"},
    [807527]={"^Your next Quickdraw has transformed into Sixfold Shot!%s*$"},
    [807544]={"^Critical damage of next Bloodmoon Blast is increased by (.-)%%%.%s*$"},
    [807578]={"^You may cast Chromatic Shard while moving%.%s*$"},
    [807587]={"^Your next Shieldgore deals (.-)%% increased damage%. Stacks (.-) times%.%s*$"},
    [807629]={"^Reduces the cooldown of |cffffffffRunemaster's Rage|r by (.-) sec and increases its duration by (.-) sec%.%s*$"},
    [807651]={"^Your melee attacks and abilities heal nearby allies and damage nearby enemies for (.-)%% of the damage dealt%.%s*$"},
    [807788]={"^Your Bloodfang Bite is now guaranteed to critically strike%.%s*$"},
    [807882]={"^Your Calamity spell is now Instant%.%s*$"},
    [807888]={"^Damage of Reap and Slaughter increased by (.-)%%%.%s*$"},
    [807912]={"^Your Calamity spell is now Instant%.%s*$"},
    [807979]={"^Reduces the cooldown of |cffffffffRunemaster's Rage|r by (.-) sec and increases its duration by (.-) sec%.%s*$"},
    [807980]={"^Reduces the cooldown of |cffffffffRunemaster's Rage|r by (.-) sec and increases its duration by (.-) sec%.%s*$"},
    [808027]={"^Gives auto attacks a (.-)%% chance to deal (.-) Fire Damage%.%s*$"},
    [808029]={"^Movement speed and attack speed reduced by (.-)%%%.%s*$"},
    [808063]={"^Gives auto attacks a (.-)%% chance to deal (.-) Nature Damage and reduce your target's casting speed by (.-)%% for (.-)%.%s*$"},
    [808065]={"^Casting speed reduced by (.-)%%%.%s*$"},
    [808066]={"^Casting speed reduced by (.-)%%%.%s*$"},
    [808652]={"^Gives auto attacks a (.-)%% chance to reduce the target's movement speed and attack speed by (.-)%% for (.-)%.%s*$"},
    [808879]={"^Movement speed and attack speed reduced by (.-)%%%.%s*$"},
    [811103]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [814183]={"^Increases the duration of |cffffffffSlayer's Mark|r by (.-) sec%.%s*$"},
    [814184]={"^Increases the duration of |cffffffffSlayer's Mark|r by (.-) sec%.%s*$"},
    [857499]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [892142]={"^Recently hit by a Molten Blast%.%s*$"},
    [892241]={"^Deals (.-) fire damage per second%.%s*$"},
    [901302]={"^Dynamic %% of damage taken by master is taken by the demon instead%.\
Demon cannot attack, be attacked or use abilities and spells%.%s*$"},
    [909023]={"^Call Lightning has (.-)%% increased critical strike chance%.%s*$"},
    [909592]={"^Your next Sunflare is instant cast%.%s*$"},
    [909593]={"^Your next Sunflare is instant cast%.%s*$"},
    [909594]={"^Your next Sunflare is instant cast%.%s*$"},
    [909595]={"^Your next Sunflare is instant cast%.%s*$"},
    [911103]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [911430]={"^Increases ground speed by (.-)%%%. Increases flying speed by (.-)%%%.%s*$"},
    [912281]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [912357]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [912358]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [914057]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [914072]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [932477]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [954025]={"^Increases fire damage taken by (.-)%%%.%s*$"},
    [954326]={"^|cffffffffCrypt Swarm|r now bounces to (.-) additional nearby enemies%.%s*$"},
    [954327]={"^|cffffffffCrypt Swarm|r now bounces to (.-) additional nearby enemies%.%s*$"},
    [954639]={"^Movement speed increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [957499]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [965211]={"^Blanket of Stars cooldown reduced%.%s*$"},
    [965213]={"^Blanket of Stars cooldown reduced%.%s*$"},
    [965365]={"^Increases all damage by (.-)%%%.%s*$"},
    [965366]={"^Increases all damage by (.-)%%%.%s*$"},
    [965389]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [965390]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [965391]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [965392]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [965393]={"^Every (.-) sec, you now trigger |cffffffffCall of the Shadow Pack|r and apply a |cffffffffWorgen Bite|r to the target%.%s*$"},
    [966184]={"^Increases the damage of |cffffffffDesolate|r by (.-)%%%.%s*$"},
    [966230]={"^Increases the damage of |cffffffffDesolate|r by (.-)%%%.%s*$"},
    [966343]={"^Your next Sunflare is instant cast%.%s*$"},
    [977745]={"^Next Sargeron Smite has (.-)%% increased critical strike chance%. Stacks (.-) times%.%s*$"},
    [977894]={"^Increases your critical strike chance by (.-)%%%s*$"},
    [977895]={"^Increases your critical strike chance by (.-)%%%s*$"},
    [977972]={"^Storing cast time%. If you cancel your cast, the cast time of you next Temporal Blast will be reduced%.%s*$"},
    [978219]={"^Envenom preserves (.-) combo points and increases the damage done by Warrior abilities by (.-)%%%.%s*$"},
    [982011]={"^You now heal for (.-)%% of all damage you deal%.%s*$"},
    [982480]={"^Increases the duration of |cffffffffTome of Time|r by (.-) sec%.%s*$"},
    [982482]={"^Increases the duration of |cffffffffTome of Time|r by (.-) sec%.%s*$"},
    [983635]={"^Your next Geode Barrage or Earthquake is instant cast and costs (.-)%% less%.%s*$"},
    [984163]={"^Increases the direct damage of your next Chaos Bolt, Chaos Burn and Chaos Meteor by (.-)%%, your Pure Chaos Bolt by (.-)%%, and reduces its cast time by (.-)%%%.%s*$"},
    [984167]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [984306]={"^Cannot be stopped unless disarmed and strike nearby targets every (.-) sec%. No other abilities can be used%.%s*$"},
    [984572]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [984573]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [984574]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [984575]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [984576]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [984577]={"^Magic resistances reduced%.\
Damage from spells increased by (.-)%%%.%s*$"},
    [984581]={"^Your Bomb Toss now deals additional physical damage%.%s*$"},
    [984734]={"^Increases Nature damage by (.-)%%, Lightning Blade deals (.-)%% increased damage, and Lightning Blade, Thunder Clap, Chain Lightning and Lightning Bolt gains a (.-)%% chance to Overload%.%s*$"},
    [984890]={"^Causes damage done by |cffffffffSavage Smash|r to remove two stacks of |cffffffffRipper|r%.%s*$"},
    [984891]={"^Causes damage done by |cffffffffSavage Smash|r to remove two stacks of |cffffffffRipper|r%.%s*$"},
    [984892]={"^Causes damage done by |cffffffffSavage Smash|r to remove two stacks of |cffffffffRipper|r%.%s*$"},
    [984911]={"^Unrelenting Assault%s*$"},
    [990032]={"^Your Felguard's attack speed is increased by (.-)%%%.%s*$"},
    [990287]={"^(.-) Shadowflame damage every (.-) seconds%.%s*$"},
    [991543]={"^When activated, plays a random assortment of Millhouse Manastorm's most eccentric sayings and vocalizations%s*$"},
    [992953]={"^(.-) Nature damage inflicted every (.-) sec%.%s*$"},
    [993020]={"^A meteor is launched towards you every 15 seconds%.%s*$"},
    [993075]={"^Cloudburst%s*$"},
    [1003098]={"^Damage taken from the Stormbringer increased by (.-)%%%. Movement speed reduced by (.-)%%%.\
\
Stacks up to (.-) times%.%s*$"},
    [1100800]={"^Your next Pulverize hits up to (.-) targets%.%s*$"},
    [1105721]={"^When the Accursed Blood Mage runs over this, they gain a stack of |cffffffffDarkcasting|r for 30 sec, stacking 10 times%.%s*$"},
    [1111103]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [1112281]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [1112318]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [1112357]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [1112358]={"^Next Fire Blast or Meteor stuns targets for (.-)%.%s*$"},
    [1112812]={"^Melee haste is increased by (.-)%%, and the cost of spells is reduced by (.-)%%%.%s*$"},
    [1112857]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [1112858]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [1112860]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [1112861]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [1114057]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1114072]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1114158]={"^Restores mana%s*$"},
    [1114159]={"^Restores mana%s*$"},
    [1117788]={"^The caster has (.-)%% increased Critical Strike chance against this enemy%.%s*$"},
    [1117789]={"^The caster has (.-)%% increased Critical Strike chance against this enemy%.%s*$"},
    [1118126]={"^The demons of the Tainted Scar bear a portion of Kazzak's power%. Even as the Manastorm shifts and changes, that power is not likely to fade so easily%.%.%.%s*$"},
    [1118127]={"^The demons of the Tainted Scar bear a portion of Kazzak's power%. Even as the Manastorm shifts and changes, that power is not likely to fade so easily%.%.%.%s*$"},
    [1118220]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [1118937]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [1118938]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [1119028]={"^(.-)%% of damage taken by master is taken by the demon instead%.%s*$"},
    [1120575]={"^Unable to stop moving%.%s*$"},
    [1120576]={"^Unable to stop moving%.%s*$"},
    [1121563]={"^Unable to stop moving%.%s*$"},
    [1127265]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [1130300]={"^Dodge chance increased by (.-)%%%.%s*$"},
    [1132477]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [1132483]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [1132484]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [1133009]={"^Your next Sunflare is instant cast%.%s*$"},
    [1133191]={"^Reduces the cooldown of Wrath of the Black Empire by (.-) seconds%.%s*$"},
    [1133192]={"^Reduces the cooldown of Wrath of the Black Empire by (.-) seconds%.%s*$"},
    [1133193]={"^Reduces the cooldown of Wrath of the Black Empire by (.-) seconds%.%s*$"},
    [1134981]={"^|cffffffffPrimal Shred|r deals (.-)%% increased damage%.%s*$"},
    [1143750]={"^Your next Primordial Blast is instant cast%.%s*$"},
    [1146859]={"^Unrelenting Assault%s*$"},
    [1146860]={"^Unrelenting Assault%s*$"},
    [1149188]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [1151468]={"^Your Infernal Strike has transformed into Annihilation!%s*$"},
    [1152795]={"^Critical damage of Shatter Echo increased by (.-)%%%.%s*$"},
    [1152797]={"^Critical damage of Shatter Echo increased by (.-)%%%.%s*$"},
    [1152798]={"^Critical damage of Shatter Echo increased by (.-)%%%.%s*$"},
    [1153511]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [1153512]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [1154562]={"^Unable to stop moving%.%s*$"},
    [1156822]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [1157499]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [1159057]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [1159092]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [1160096]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [1160097]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [1162759]={"^Ticks of |cffffffffSlipstream|r and |cffffffffTorrent|r now cause sharks to attack enemies in their area of effect for (.-) Frost damage%.\
\
Learning this gives |cffffffffTorrent|r a (.-) sec cooldown%.%s*$"},
    [1162760]={"^Ticks of |cffffffffSlipstream|r and |cffffffffTorrent|r now cause sharks to attack enemies in their area of effect for (.-) Frost damage%.\
\
Learning this gives |cffffffffTorrent|r a (.-) sec cooldown%.%s*$"},
    [1164913]={"^Your next Primordial Blast is instant cast%.%s*$"},
    [1165222]={"^Unable to stop moving%.%s*$"},
    [1166343]={"^Your next Sunflare is instant cast%.%s*$"},
    [1181320]={"^Your next Starsurge is instant cast%.%s*$"},
    [1181451]={"^Increases your Block Value by (.-)%% and the armor gained from your shield by (.-)%%%.%s*$"},
    [1187528]={"^Recently hit by a Molten Blast%.%s*$"},
    [1187633]={"^Deals (.-) fire damage per second%.%s*$"},
    [1209076]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1209077]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1209078]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1209079]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1209080]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1209819]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [1209820]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [1209821]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [1209822]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [1209823]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [1210220]={"^Blanket of Stars cooldown reduced%.%s*$"},
    [1210221]={"^Blanket of Stars cooldown reduced%.%s*$"},
    [1210222]={"^Blanket of Stars cooldown reduced%.%s*$"},
    [1210223]={"^Blanket of Stars cooldown reduced%.%s*$"},
    [1210224]={"^Blanket of Stars cooldown reduced%.%s*$"},
    [1210265]={"^Increases all damage by (.-)%%%.%s*$"},
    [1210266]={"^Increases all damage by (.-)%%%.%s*$"},
    [1210267]={"^Increases all damage by (.-)%%%.%s*$"},
    [1210268]={"^Increases all damage by (.-)%%%.%s*$"},
    [1212318]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [1212857]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [1212858]={"^Pulverize applies Line Formation damage to enemies struck%. Generating (.-) Energy every (.-) sec%. Honorguard Damage increased by (.-)%%%.%s*$"},
    [1214057]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1214072]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1218126]={"^The demons of the Tainted Scar bear a portion of Kazzak's power%. Even as the Manastorm shifts and changes, that power is not likely to fade so easily%.%.%.%s*$"},
    [1218127]={"^The demons of the Tainted Scar bear a portion of Kazzak's power%. Even as the Manastorm shifts and changes, that power is not likely to fade so easily%.%.%.%s*$"},
    [1218220]={"^Sacrifices Fizzle, transfering his remaining health and mana to Elriss%.%s*$"},
    [1219028]={"^(.-)%% of damage taken by master is taken by the demon instead%.%s*$"},
    [1232477]={"^Bleeding for (.-) Shadow Damage every (.-) sec%.%s*$"},
    [1246859]={"^Unrelenting Assault%s*$"},
    [1246860]={"^Unrelenting Assault%s*$"},
    [1249188]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [1253511]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [1253512]={"^Gluth entered a feeding frenzy after casting Decimate causing him to devour nearby Zombie Chows without a cooldown%. \
\
While the Feeding Frenzy lasts, all Zombie Chow's constantly walk towards Gluth to sate his hunger%.%s*$"},
    [1256822]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [1257499]={"^Transforms |cFFFFFFFFFlames of Xoroth|r into |cFFFFFFFFWarbringer|r%.%s*$"},
    [1259057]={"^Your Glacial Dagger spell will now have a 10%% chance to reset the cooldown of Black Ice%.%s*$"},
    [1262759]={"^Ticks of |cffffffffSlipstream|r and |cffffffffTorrent|r now cause sharks to attack enemies in their area of effect for (.-) Frost damage%.\
\
Learning this gives |cffffffffTorrent|r a (.-) sec cooldown%.%s*$"},
    [1262760]={"^Ticks of |cffffffffSlipstream|r and |cffffffffTorrent|r now cause sharks to attack enemies in their area of effect for (.-) Frost damage%.\
\
Learning this gives |cffffffffTorrent|r a (.-) sec cooldown%.%s*$"},
    [1314072]={"^Increases fire damage you deal to enemies stunned by |cffffffffPetrifying Visage|r by (.-)%%%.%s*$"},
    [1318127]={"^The demons of the Tainted Scar bear a portion of Kazzak's power%. Even as the Manastorm shifts and changes, that power is not likely to fade so easily%.%.%.%s*$"},
    [1398163]={"^Dominating dragonkin%.%s*$"},
    [1398188]={"^Your next Sunflare is instant cast%.%s*$"},
    [1398207]={"^Able to transfer damage%-over%-time effects%.%s*$"},
    [1398246]={"^(.-)%% of damage taken by master is taken by the demon instead%.%s*$"},
    [1441632]={"^Dominating dragonkin%.%s*$"},
    [1469028]={"^(.-)%% of damage taken by master is taken by the demon instead%.%s*$"},
    [1568763]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [1568765]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [1568766]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [1568768]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [1568769]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [1568799]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [1569645]={"^|cffffffffCrypt Swarm|r now bounces to (.-) additional nearby enemies%.%s*$"},
    [1570327]={"^Your continuous Bestial Assault restores a charge of Unrelenting Wrath%.%s*$"},
    [1571913]={"^Your next Geode Barrage or Earthquake is instant cast and costs (.-)%% less%.%s*$"},
    [1572787]={"^Storing cast time%. If you cancel your cast, the cast time of you next Temporal Blast will be reduced%.%s*$"},
    [1572875]={"^Reduces the cast time of your next direct damage spell except Arcane Blast by (.-)%%%.%s*$"},
    [1573538]={"^Envenom preserves (.-) combo points and increases the damage done by Warrior abilities by (.-)%%%.%s*$"},
    [1573649]={"^Healing done by your next Ember Touch is increased by (.-)%% and its cast time is reduced by (.-) sec%.%s*$"},
    [1573650]={"^Healing done by your next Ember Touch is increased by (.-)%% and its cast time is reduced by (.-) sec%.%s*$"},
    [1574444]={"^Causes your next Astral Flare critical strike to reset the cooldown of Astral Plasma, make it instant cast and deal (.-)%% additional damage %((.-)%% to players%)%.%s*$"},
    [1574469]={"^Fireball and Pyroblast grant Solar Flames, empowering each stack with (.-)%% intensity%.%s*$"},
    [1576284]={"^Increases the direct damage of your next Chaos Bolt, Chaos Burn and Chaos Meteor by (.-)%%, your Pure Chaos Bolt by (.-)%%, and reduces its cast time by (.-)%%%.%s*$"},
    [1579134]={"^Increases the damage of |cffffffffIcequake|r and |cffffffffWinds of Northrend|r by (.-)%%%.%s*$"},
    [1579923]={"^Cloudburst%s*$"},
    [1580027]={"^Your non%-periodic Critical Strikes reduce the cooldown of your Endbringer ability by (.-) sec%.%s*$"},
    [1580047]={"^Your non%-periodic Critical Strikes reduce the cooldown of your Endbringer ability by (.-) sec%.%s*$"},
    [1580049]={"^Your non%-periodic Critical Strikes reduce the cooldown of your Endbringer ability by (.-) sec%.%s*$"},
    [1580177]={"^Your melee strikes exasperate the flames lingering on your target, refreshing your Immolate effect%.%s*$"},
    [1582341]={"^Heals the next time you take damage%.%s*$"},
    [1582343]={"^Heals the next time you take damage%.%s*$"},
    [1583653]={"^Taking extra damage from the Barbarian%.%s*$"},
    [1583657]={"^Taking extra damage from the Barbarian%.%s*$"},
    [1584627]={"^Movement speed increased by (.-)%%%. Stacks (.-) times%.%s*$"},
    [1585123]={"^Holy damage taken by the Paladin increased by (.-)%%%.%s*$"},
    [1585522]={"^Next Sargeron Smite has (.-)%% increased critical strike chance%. Stacks (.-) times%.%s*$"},
    [1590904]={"^Increases healing done by (.-)%%, and healing received by (.-)%%%.%s*$"},
    [1590913]={"^|cffffffffCrypt Swarm|r now bounces to (.-) additional nearby enemies%.%s*$"},
    [2106225]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [2106226]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [2106227]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [2106228]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [2110011]={"^Cloudburst%s*$"},
    [2130000]={"^Strength reduced by (.-)%%%.\
Stamina reduced by (.-)%%%.%s*$"},
    [3106225]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [3106226]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [3106227]={"^Being healed by Loa's Brew spills the concoction, healing nearby allies%.%s*$"},
    [3130000]={"^Strength reduced by (.-)%%%.\
Stamina reduced by (.-)%%%.%s*$"},
    [9931131]={"^Increases the damage of |cffffffffIcequake|r and |cffffffffWinds of Northrend|r by (.-)%%%.%s*$"},
    [9934028]={"^Increases ground speed by (.-)%%%. Increases flying speed by (.-)%%%.%s*$"},
    [9934030]={"^Increases ground speed by (.-)%%%. Increases flying speed by (.-)%%%.%s*$"},
    [9934051]={"^Increases ground speed by (.-)%%%. Increases flying speed by (.-)%%%.%s*$"},
}
local function mergePairs(target, incoming)
    local bySource = {}
    local nextIndex = 0
    for i, pair in pairs(target) do
        if type(i) == "number" and i > nextIndex then nextIndex = i end
        if pair and pair[1] then bySource[pair[1]] = i end
    end
    for _, pair in ipairs(incoming) do
        if not bySource[pair[1]] then
            nextIndex = nextIndex + 1
            target[nextIndex] = pair
            bySource[pair[1]] = nextIndex
        end
    end
    return bySource
end
local function addPrefixIndexes(target, incoming, bySource)
    for _, pair in ipairs(incoming) do
        local source, index = pair[1], bySource[pair[1]]
        local clean = source:gsub("^%^", ""):gsub("|c%%x+", " "):gsub("|r", " ")
        clean = clean:gsub("%%b()", " "):gsub("%%%%.", " ")
        local words = {}
        for word in clean:gmatch("%%a+") do if #words < 12 then words[#words + 1] = word:lower() end end
        for amount = 3, #words do
            local prefix = table.concat(words, " ", 1, amount)
            local bucket = target[prefix]
            if not bucket then bucket = {}; target[prefix] = bucket end
            local present = false
            for _, current in ipairs(bucket) do if current == index then present = true; break end end
            if not present then bucket[#bucket + 1] = index end
        end
    end
end
local function mergeIDs(target, incoming, bySource)
    for id, sources in pairs(incoming) do
        if target[id] == nil then
            local indexes = {}
            for _, source in ipairs(sources) do
                local index = bySource[source]
                if index then indexes[#indexes + 1] = index end
            end
            if #indexes == 1 then target[id] = indexes[1] elseif #indexes > 1 then target[id] = indexes end
        end
    end
end
local descBySource = mergePairs(A.DescPairs, descPairs)
local tipBySource = mergePairs(A.TipPairs, tipPairs)
A.DescByPrefix = A.DescByPrefix or {}
A.TipByPrefix = A.TipByPrefix or {}
addPrefixIndexes(A.DescByPrefix, descPairs, descBySource)
addPrefixIndexes(A.TipByPrefix, tipPairs, tipBySource)
mergeIDs(A.DescByID, descIDs, descBySource)
mergeIDs(A.TipByID, tipIDs, tipBySource)
