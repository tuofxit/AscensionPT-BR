import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const SRC = path.resolve('C:/Users/bolin/Downloads/peripecias/AscensionES-main/AscensionES');
const DST = path.resolve(__dirname, '..');
const SECONDARY_DST = path.resolve('C:/Users/bolin/Downloads/peripecias/Data/Interface/AddOns/AscensionPTBR');

const SKIP = new Set(['Voice.lua', 'Voices.lua', 'sounds', 'AscensionES.toc']);

const IDENT_REPLACEMENTS = [
  ['AscensionESDB', 'AscensionPTBRDB'],
  ['AscensionES', 'AscensionPTBR'],
  ['SpellNameEN2ES', 'SpellNameEN2PT'],
  ['ItemNameEN2ES', 'ItemNameEN2PT'],
  ['UnitNameEN2ES', 'UnitNameEN2PT'],
  ['QuestTitleEN2ES', 'QuestTitleEN2PT'],
  ['QuestTitleES2ID', 'QuestTitlePT2ID'],
  ['QuestTitleES2IDs', 'QuestTitlePT2IDs'],
  ['GossipEN2ES', 'GossipEN2PT'],
  ['AchNameEN2ES', 'AchNameEN2PT'],
  ['AchCritEN2ES', 'AchCritEN2PT'],
  ['AchCatEN2ES', 'AchCatEN2PT'],
  ['RankEN2ES', 'RankEN2PT'],
  ['SLASH_ASCENSIONES', 'SLASH_ASCENSIONPTBR'],
  ['SlashCmdList["ASCENSIONES"]', 'SlashCmdList["ASCENSIONPTBR"]'],
  ['local AES = AscensionPTBR', 'local APT = AscensionPTBR'],
  ['AES.', 'APT.'],
  [' AES', ' APT'],
  ['(AES', '(APT'],
  ['= AES', '= APT'],
  ['function AES', 'function APT'],
];

function applyIdentReplacements(text) {
  let out = text;
  for (const [from, to] of IDENT_REPLACEMENTS) {
    out = out.split(from).join(to);
  }
  return out;
}

// Phrase and Sentence Translations (Longest first)
const PHRASE_TRANSLATIONS = [
  ['Instantáneamente hace invisible al lanzador', 'Instantaneamente torna o conjurador invisível'],
  ['Instantáneamente sobrepotencia al enemigo', 'Instantaneamente sobrepõe o inimigo'],
  ['Instantáneamente sobrepotencia al', 'Instantaneamente sobrepõe o'],
  ['Instantáneamente golpea al objetivo', 'Instantaneamente golpeia o alvo'],
  ['Instantáneamente hiere al objetivo', 'Instantaneamente fere o alvo'],
  ['Instantáneamente', 'Instantaneamente'],
  ['instantáneamente', 'instantaneamente'],
  ['Instantánea', 'Instantânea'],
  ['instantánea', 'instantânea'],
  ['Se aprovecha del alma del objetivo aliado', 'Aproveita a alma do alvo aliado'],
  ['para protegerlo, absorbiendo', 'para protegê-lo, absorvendo'],
  ['Mientras la protección resista', 'Enquanto a proteção resistir'],
  ['el lanzamiento de hechizos no será interrumpido por el daño', 'a conjuração de feitiços não será interrumpida por dano'],
  ['el lanzamiento de hechizos', 'a conjuração de feitiços'],
  ['lanzamiento de hechizos', 'conjuração de feitiços'],
  ['Una vez que se ha protegido al objetivo', 'Uma vez protegido o alvo'],
  ['este no puede volver a ser protegido durante', 'ele não pode ser protegido novamente durante'],
  ['Apuñala al objetivo por la espalda', 'Apunhala o alvo pelas costas'],
  ['por la espalda', 'pelas costas'],
  ['desde atrás', 'pelas costas'],
  ['de daño de arma más', 'de dano de arma mais'],
  ['de daño de arma', 'de dano de arma'],
  ['Inflige un 20% más de daño', 'Causa 20% a mais de dano'],
  ['Debes estar detrás del objetivo si es un jugador', 'Você deve estar atrás do alvo se for um jogador'],
  ['Requiere una daga en la mano principal', 'Requer uma adaga na mão principal'],
  ['en la mano principal', 'na mão principal'],
  ['en la mano izquierda', 'na mão secundária'],
  ['en la mano libre', 'na mão secundária'],
  ['reduciendo toda amenaza', 'reduzindo toda a ameaça'],
  ['Mientras estés invisible', 'Enquanto estiver invisível'],
  ['solo puedes ver a otros objetivos invisibles y aquellos que pueden verte', 'você só pode ver outros alvos invisíveis e aqueles que podem ver você'],
  ['Elimina las invulnerabilidades al usarse', 'Remove invulnerabilidades ao usar'],
  ['Hace que el lanzador se vuelva gradualmente invisible durante', 'Faz com que o conjurador fique gradualmente invisível durante'],
  ['reduciendo la amenaza cada segundo', 'reduzindo a ameaça a cada segundo'],
  ['Aumenta significativamente tu generación de amenaza', 'Aumenta significativamente a sua geração de ameaça'],
  ['generación de amenaza', 'geração de ameaça'],
  ['Aumenta tu armadura en', 'Aumenta sua armadura em'],
  ['y disminuye el daño recibido en', 'e diminui o dano recebido em'],
  ['daño recibido', 'dano recibido'],
  ['disminuye el daño', 'diminui o dano'],
  ['que realizas en', 'que você realiza em'],
  ['Te enseña a ', 'Ensina '],
  ['Te enseña ', 'Ensina '],
  ['Enseña ', 'Ensina '],
  ['El daño recibido en PvP aumenta en', 'O dano recebido em JxJ aumenta em'],
  ['Golpea al objetivo con tu escudo aturdándolo e interrumpe', 'Golpeia o alvo com seu escudo atordoando-o e interrompe'],
  ['lo que previene la realización de hechizos de esa escuela durante', 'o que impede a conjuração de feitiços dessa escola durante'],
  ['Este hechizo no puede fallar', 'Este feitiço não pode errar'],
  ['Esta habilidad comparte tiempo de reutilización con otras interrupciones', 'Esta habilidade compartilha recarga com outras interrupções'],
  ['tiempo de reutilización', 'tempo de recarga'],
  ['tiempo de recarga', 'tempo de recarga'],
  ['reutilización', 'recarga'],
  ['Dispara automáticamente al objetivo hasta que se cancele', 'Dispara automaticamente no alvo até ser cancelado'],
  ['Aumenta tu velocidad de ataque a distancia en', 'Aumenta sua velocidade de ataque à distância em'],
  ['velocidad de ataque a distancia', 'velocidade de ataque à distância'],
  ['y escala con el poder de ataque a distancia', 'e escala com seu poder de ataque à distância'],
  ['poder de ataque a distancia', 'poder de ataque à distância'],
  ['poder de ataque cuerpo a cuerpo', 'poder de ataque corpo a corpo'],
  ['poder de ataque', 'poder de ataque'],
  ['poder con hechizos', 'poder com feitiços'],
  ['daño de Fuego', 'dano de Fogo'],
  ['daño de Escarcha', 'dano de Gelo'],
  ['daño de Naturaleza', 'dano de Natureza'],
  ['daño de Sombras', 'dano de Sombra'],
  ['daño de Sagrado', 'dano Sagrado'],
  ['daño Arcano', 'dano Arcano'],
  ['daño Físico', 'dano Físico'],
  ['Tem certeza que quieres abandonar tu mascota para siempre?', 'Tem certeza que deseja abandonar seu ajudante para sempre?'],
  ['¿Abandonar ', 'Abandonar '],
  ['Si abandonas ', 'Se você abandonar '],
  ['destruirás ', 'você destruirá '],
  ['Solo puedes hacer el seguimiento de ', 'Você só pode rastrear '],
  ['a la vez.', 'ao mesmo tempo.'],
  ['Son bancos de teclas que te permiten acceder a facultades y objetos del inventario con rapidez. Aquí podrás activar más Barras de acción y controlar su configuración.', 'São barras de atalhos que permitem acessar habilidades e itens do inventário com rapidez. Aqui você poderá ativar mais Barras de Ação e controlar suas configurações.'],
  ['Anunciar conquista', 'Anunciar conquista'],
  ['Conquistas ganados', 'Conquistas obtidas'],
  ['ha ganado el conquista', 'ganhou a conquista'],
  ['ha ganado la conquista', 'ganhou a conquista'],
  ['Resumen de progreso', 'Resumo do progresso'],
  ['Resumen', 'Resumo'],
  ['Solo se puede usar', 'Só pode ser usado'],
  ['Solo se puede', 'Só pode ser'],
  ['Solo se pode', 'Só pode ser'],
  ['se puede usar', 'pode ser usado'],
  ['se puede', 'pode ser'],
  ['se pode', 'pode ser'],
  ['después de que', 'depois que'],
  ['después de', 'depois de'],
  ['a lo largo de', 'ao longo de'],
  ['fuerza aturdidora', 'força atordoante'],
  ['aturdándolo', 'atordoando-o'],
  ['aturdiendo', 'atordoando'],
  ['aturdimiento', 'atordoamento'],
  ['Aturdimiento', 'Atordoamento'],
  ['sobrepotencia', 'sobrepõe'],
  ['deshacer', 'dissipar'],
  ['Ojo de Kilrogg', 'Olho de Kilrogg'],
  ['une tu visión a él', 'conecta sua visão a ele'],
  ['se mueve rápidamente', 'move-se rapidamente'],
  ['muy frágil', 'muito frágil'],
  ['Ralentiza la velocidad de caída', 'Desacelera a velocidade de queda'],
  ['velocidad de caída', 'velocidade de queda'],
  ['respirar bajo el agua', 'respirar debaixo d\'água'],
  ['bajo el agua', 'debaixo d\'água'],
  ['velocidad de natación', 'velocidade de nado'],
  ['velocidad de nado', 'velocidade de nado'],
  ['menor invisibilidad', 'invisibilidade menor'],
  ['Sanas a tu Mascota', 'Cura seu Ajudante'],
  ['Sanas al objetivo', 'Cura o alvo'],
  ['Sanas a', 'Cura'],
  ['Modo Selva', 'Modo Selvagem'],
  ['Si un enemigo ataca al lanzador', 'Se um inimigo atacar o conjurador'],
  ['pueden tener su movimiento ralentizado por', 'podem ter seu movimento desacelerado em'],
  ['y el tiempo entre sus ataques aumentado por', 'e o tempo entre seus ataques aumentado em'],
  ['tiempo entre sus ataques', 'tempo entre seus ataques'],
  ['Forma de Gato', 'Forma de Gato'],
  ['Forma de Oso', 'Forma de Urso'],
  ['Forma de león marino', 'Forma Aquática'],
  ['Forma de viaje', 'Forma de Viagem'],
  ['Forma de lechúcico lunar', 'Forma de Sábio-da-lua'],
  ['Forma de árbol de la vida', 'Forma de Árvore da Vida'],
  ['probabilidad de bloqueo', 'chance de bloqueio'],
  ['valor del bloqueo', 'valor de bloqueio'],
  ['valor de bloqueo', 'valor de bloqueio'],
  ['salud máxima', 'vida máxima'],
  ['salud base', 'vida base'],
  ['maná máximo', 'mana máxima'],
  ['maná base', 'mana base'],
  ['por debajo de tu velocidad normal de movimiento', 'abaixo da sua velocidade normal de movimento'],
  ['velocidad normal de movimiento', 'velocidade normal de movimento'],
  ['En silencio', 'Furtivo'],
  ['Daño de Sombras', 'Dano de Sombra'],
  ['efectos mágicos dañinos', 'efeitos mágicos nocivos'],
  ['amenaza total', 'ameaça total'],
  ['habilidades físicas', 'habilidades físicas'],
  ['ataques físicos', 'ataques físicos'],
  ['interrupciones y silenciamientos', 'interrupções e silêncios'],
  ['Inmune a los ataques físicos', 'Imune a ataques físicos'],
  ['daño mágico recibido', 'dano mágico recebido'],
  ['daño mágico', 'dano mágico'],
  ['nivel de amenaza', 'nível de ameaça'],
  ['efectos de Aturdimiento', 'efeitos de Atordoamento'],
  ['recompensa por', 'recompensa por'],
  ['Guerras del Espíritu', 'Guerras do Espírito'],
  ['Recuperando', 'Recuperando'],
  ['Campos de la muerte', 'Campos da Morte'],
  ['La Limpieza del Campamento', 'A Limpeza do Acampamento'],
  ['Missão del Sirviente', 'Missão do Servo'],
  ['Misión del Sirviente', 'Missão do Servo'],
  ['Ritos del nacido del Felo', 'Ritos do Nascido do Fel'],
  ['Nacido del Felo', 'Nascido do Fel'],
  ['Araña del bosque', 'Aranha da Floresta'],
  ['Gólem de la cosecha', 'Gólem da Colheita'],
  ['Vigía de la cosecha', 'Vigia da Colheita'],
  ['Segador de la cosecha', 'Ceifador da Colheita'],
  ['Guarda de la ciudad de Ventobravo', 'Guarda da Cidade de Ventobravo'],
  ['Guarda de la ciudad de Ventormenta', 'Guarda da Cidade de Ventobravo'],
  ['Guarda de la ciudad', 'Guarda da Cidade'],
  ['Guardia de la ciudad de Ventormenta', 'Guarda da Cidade de Ventobravo'],
  ['Guardia de la ciudad', 'Guarda da Cidade'],
  ['Guarda de', 'Guarda de'],
  ['Guardia de', 'Guarda de'],
  ['Pregonero', 'Arauto'],
  ['Bocadillo de nudillos', 'Sanduíche de Soco'],
  ['Muchas mascotas', 'Muitos Ajudantes'],
  ['Fiordo Aquilonal', 'Fiorde Uivante'],
  ['He paseado por el', 'Caminhei pelo'],
  ['Comprobación de función', 'Verificação de Função'],
  ['Tu grupo se pondrá en cola', 'Seu grupo entrará na fila'],
  ['casilla del icono de armadura', 'slot do ícone de armadura'],
  ['para poder usar la munición', 'para poder usar a munição'],
  ['debes colocarla en', 'você deve colocá-la em'],
  ['Hay un cambio de dificultad de la banda en curso', 'Há uma mudança de dificultad da raide em andamento'],
  ['en curso', 'em andamento'],
  ['Warmaster de facción', 'Mestre de Guerra da Facção'],
  ['Fortaleza de Allerian', 'Bastião de Allerian'],
  ['Este objeto no puede ser devuelto o reembolsado una vez que se ha comprado', 'Este item não pode ser devolvido ou reembolsado após a compra'],
  ['pociones de cura y mana', 'poções de cura e mana'],
  ['pociones de sanación y maná', 'poções de cura e mana'],
  ['pueden usarse con un', 'podem ser usadas com um'],
  ['separado del resto de las pociones', 'separado do restante das poções'],
  ['espadas de dos manos', 'espadas de duas mãos'],
  ['hachas de dos manos', 'machados de duas mãos'],
  ['mazas de dos manos', 'maças de duas mãos'],
  ['un arma cuerpo a cuerpo de dos manos', 'uma arma corpo a corpo de duas mãos'],
  ['de cólera de la Naturaleza', 'da Cólera da Natureza'],
  ['Golpe m. izq.', 'Golpe m. esq.'],
  ['Info del personaje', 'Info do personagem'],
  ['Ciudad de Ventormenta', 'Ventobravo'],
  ['Ventormenta', 'Ventobravo'],
  ['Forjaz', 'Altaforja'],
  ['Entrañas', 'Cidade Baixa'],
  ['Luna de Plata', 'Luaprata'],
  ['Cima del Trueno', 'Penhasco do Trovão'],
  ['Colinas Pardas', 'Colinas Grizares'],
  ['Corona de Hielo', 'Coroa de Gelo'],
  ['Cuenca de Sholazar', 'Bacia de Sholazar'],
  ['Cumbres Tormentosas', 'Cumes Tempestuosos'],
  ['Paso de la Muerte', 'Trilha da Morte'],
  ['Reinos del Este', 'Reinos do Leste'],
  ['Guanteletes de batalla', 'Manoplas de batalha'],
  ['Guanteletes', 'Manoplas'],
  ['Guantes de', 'Luvas de'],
  ['Guantes', 'Luvas'],
  ['Hombreras de', 'Ombreiras de'],
  ['Hombreras', 'Ombreiras'],
  ['Pantalones de', 'Calças de'],
  ['Pantalones', 'Calças'],
  ['Leotardos de', 'Macacão de'],
  ['Leotardos', 'Macacão'],
  ['Brazalete de', 'Bracelete de'],
  ['Brazalete', 'Bracelete'],
  ['Brazales de', 'Pulseiras de'],
  ['Brazales', 'Pulseiras'],
  ['Pechera de', 'Peitoral de'],
  ['Pechera', 'Peitoral'],
  ['Yelmo de', 'Elmo de'],
  ['Yelmo', 'Elmo'],
  ['Casco de', 'Elmo de'],
  ['Casco', 'Elmo'],
  ['Botas de', 'Botas de'],
  ['Botas', 'Botas'],
  ['Capucha de', 'Capuz de'],
  ['Capucha', 'Capuz'],
  ['Manto de', 'Manto de'],
  ['Manto', 'Manto'],
  ['Túnica de', 'Túnica de'],
  ['Túnica', 'Túnica'],
  ['Colgante de', 'Pingente de'],
  ['Colgante', 'Pingente'],
  ['Cinturón de', 'Cinto de'],
  ['Cinturón', 'Cinto'],
  ['Faja de', 'Faixa de'],
  ['Faja', 'Faixa'],
  ['Grebas de', 'Grevas de'],
  ['Grebas', 'Grevas'],
  ['Sello de', 'Selo de'],
  ['Sello', 'Selo'],
  ['Glifo de', 'Glifo de'],
  ['Glifo', 'Glifo'],
  ['Corona de', 'Coroa de'],
  ['Corona', 'Coroa'],
  ['Cota de malla', 'Cota de Malha'],
  ['Cota de', 'Cota de'],
  ['Cota', 'Cota'],
  ['Libram de', 'Livro Sagrado de'],
  ['Libram', 'Livro Sagrado'],
  ['Tótem de', 'Tótem de'],
  ['Totem de', 'Tótem de'],
  ['Tótem', 'Tótem'],
  ['Totem', 'Tótem'],
  ['Hoja de', 'Lâmina de'],
  ['Hoja', 'Lâmina'],
  ['Garra de', 'Garra de'],
  ['Garra', 'Garra'],
  ['Martillo de', 'Martelo de'],
  ['Martillo', 'Martelo'],
  ['Camisota de', 'Camisola de'],
  ['Camisota', 'Camisola'],
  ['Silbato de', 'Apito de'],
  ['Silbato', 'Apito'],
  ['Tarjeta de', 'Carta de'],
  ['Tarjeta', 'Carta'],
  ['Piedra de', 'Pedra de'],
  ['Piedra', 'Pedra'],
  ['Escudo de', 'Escudo de'],
  ['Escudo', 'Escudo'],
  ['Arco de', 'Arco de'],
  ['Arco', 'Arco'],
  ['Amuleto de', 'Amuleto de'],
  ['Amuleto', 'Amuleto'],
  ['Anillo de', 'Anel de'],
  ['Anillo', 'Anel'],
  ['Cajado de', 'Cajado de'],
  ['Cajado', 'Cajado'],
  ['Capa de', 'Capa de'],
  ['Capa', 'Capa'],
  ['Requires Level', 'Requer Nível'],
  ['Increases ', 'Aumenta '],
  ['Decreases ', 'Diminui '],
  ['Deals ', 'Causa '],
  ['Restores ', 'Restaura '],
  ['Chance on hit', 'Chance ao acertar'],
  ['Equip:', 'Equipar:'],
  ['Use:', 'Usar:'],
  ['Cooldown', 'Recarga'],
  ['sec cooldown', 'seg de recarga'],
  ['yard range', 'm de alcance'],
  ['yards', 'metros'],
  ['Instant', 'Instantâneo'],
  ['Cast time', 'Tempo de conjuração'],
  ['Channeled', 'Canalizado'],
  ['Passive', 'Passivo'],
  ['Shoulders', 'Ombros'],
  ['Chest', 'Torso'],
  ['Waist', 'Cintura'],
  ['Legs', 'Pernas'],
  ['Feet', 'Pés'],
  ['Wrist', 'Pulsos'],
  ['Hands', 'Mãos'],
  ['Finger', 'Dedo'],
  ['Trinket', 'Berloque'],
  ['Back', 'Costas'],
  ['Neck', 'Pescoço'],
  ['Two-Hand', 'Duas Mãos'],
  ['One-Hand', 'Uma Mão'],
  ['Main Hand', 'Mão Principal'],
  ['Off Hand', 'Mão Secundária'],
  ['Ranged', 'À Distância'],
  ['Deprecated', '[Obsoleto]'],
  ['Unused', '[Não Usado]']
];

// Word Boundary Word Translations (Matched safely with \b)
const WORD_TRANSLATIONS = [
  // Compound Prepositions & Connectives
  ['en', 'em'],
  ['En', 'Em'],
  ['y', 'e'],
  ['Y', 'E'],
  ['al', 'ao'],
  ['Al', 'Ao'],
  ['más', 'mais'],
  ['Más', 'Mais'],
  ['sin', 'sem'],
  ['Sin', 'Sem'],
  ['sea', 'seja'],
  ['Sea', 'Seja'],
  ['uno', 'um'],
  ['Uno', 'Um'],
  ['otros', 'outros'],
  ['Otros', 'Outros'],
  ['golpea', 'golpeia'],
  ['Golpea', 'Golpeia'],
  ['obtienes', 'obtém'],
  ['Obtienes', 'Obtém'],
  ['personaje', 'personagem'],
  ['Personaje', 'Personagem'],
  ['de la', 'da'],
  ['De la', 'Da'],
  ['de las', 'das'],
  ['De las', 'Das'],
  ['de los', 'dos'],
  ['De los', 'Dos'],
  ['del', 'do'],
  ['Del', 'Do'],
  ['en el', 'no'],
  ['En el', 'No'],
  ['en la', 'na'],
  ['En la', 'Na'],
  ['en los', 'nos'],
  ['En los', 'Nos'],
  ['en las', 'nas'],
  ['En las', 'Nas'],
  ['por el', 'pelo'],
  ['Por el', 'Pelo'],
  ['por la', 'pela'],
  ['Por la', 'Pela'],
  ['por los', 'pelos'],
  ['Por los', 'Pelos'],
  ['por las', 'pelas'],
  ['Por las', 'Pelas'],
  ['con el', 'com o'],
  ['Con el', 'Com o'],
  ['con la', 'com a'],
  ['Con la', 'Com a'],
  ['con los', 'com os'],
  ['Con los', 'Com os'],
  ['con las', 'com as'],
  ['Con las', 'Com as'],
  ['para el', 'para o'],
  ['Para el', 'Para o'],
  ['para la', 'para a'],
  ['Para la', 'Para a'],
  ['para los', 'para os'],
  ['Para los', 'Para os'],
  ['para las', 'para as'],
  ['Para las', 'Para as'],
  ['sobre el', 'sobre o'],
  ['Sobre el', 'Sobre o'],
  ['sobre la', 'sobre a'],
  ['Sobre la', 'Sobre a'],
  ['sobre los', 'sobre os'],
  ['Sobre los', 'Sobre os'],
  ['sobre las', 'sobre as'],
  ['Sobre las', 'Sobre as'],
  ['hasta el', 'até o'],
  ['Hasta el', 'Até o'],
  ['hasta la', 'até a'],
  ['Hasta la', 'Até a'],
  ['desde el', 'desde o'],
  ['Desde el', 'Desde o'],
  ['desde la', 'desde a'],
  ['Desde la', 'Desde a'],
  ['hacia el', 'em direção ao'],
  ['Hacia el', 'Em direção ao'],
  ['hacia la', 'em direção à'],
  ['Hacia la', 'Em direção à'],
  ['hacia', 'para'],
  ['Hacia', 'Para'],
  ['hasta', 'até'],
  ['Hasta', 'Até'],
  ['sin embargo', 'no entanto'],
  ['Sin embargo', 'No entanto'],
  ['después de', 'depois de'],
  ['Después de', 'Depois de'],
  ['antes de', 'antes de'],
  ['Antes de', 'Antes de'],
  ['golpe crítico', 'acerto crítico'],
  ['Golpe crítico', 'Acerto crítico'],

  // Articles & Pronouns
  ['un', 'um'],
  ['Un', 'Um'],
  ['una', 'uma'],
  ['Una', 'Uma'],
  ['unos', 'alguns'],
  ['Unos', 'Alguns'],
  ['unas', 'algumas'],
  ['Unas', 'Algumas'],
  ['el', 'o'],
  ['El', 'O'],
  ['la', 'a'],
  ['La', 'A'],
  ['los', 'os'],
  ['Los', 'Os'],
  ['las', 'as'],
  ['Las', 'As'],
  ['tu', 'seu'],
  ['Tu', 'Seu'],
  ['tus', 'seus'],
  ['Tus', 'Seus'],
  ['su', 'seu'],
  ['Su', 'Seu'],
  ['sus', 'seus'],
  ['Sus', 'Seus'],
  ['nuestro', 'nosso'],
  ['Nuestro', 'Nosso'],
  ['nuestra', 'nossa'],
  ['Nuestra', 'Nossa'],
  ['nuestros', 'nossos'],
  ['Nuestros', 'Nossos'],
  ['nuestras', 'nossas'],
  ['Nuestras', 'Nossas'],
  ['este', 'este'],
  ['Este', 'Este'],
  ['esta', 'esta'],
  ['Esta', 'Esta'],
  ['estos', 'estes'],
  ['Estos', 'Estes'],
  ['estas', 'estas'],
  ['Estas', 'Estas'],
  ['ese', 'esse'],
  ['Ese', 'Esse'],
  ['esa', 'essa'],
  ['Esa', 'Essa'],
  ['esos', 'esses'],
  ['Esos', 'Esses'],
  ['esas', 'essas'],
  ['Esas', 'Essas'],
  ['aquel', 'aquele'],
  ['Aquel', 'Aquele'],
  ['aquella', 'aquela'],
  ['Aquella', 'Aquela'],
  ['aquellos', 'aqueles'],
  ['Aquellos', 'Aqueles'],
  ['aquellas', 'aquelas'],
  ['Aquellas', 'Aquelas'],

  // Connectives & Adverbs
  ['pero', 'mas'],
  ['Pero', 'Mas'],
  ['aunque', 'embora'],
  ['Aunque', 'Embora'],
  ['cuando', 'quando'],
  ['Cuando', 'Quando'],
  ['mientras', 'enquanto'],
  ['Mientras', 'Enquanto'],
  ['después', 'depois'],
  ['Después', 'Depois'],
  ['antes', 'antes'],
  ['Antes', 'Antes'],
  ['luego', 'logo'],
  ['Luego', 'Logo'],
  ['entonces', 'então'],
  ['Entonces', 'Então'],
  ['también', 'também'],
  ['También', 'Também'],
  ['además', 'além disso'],
  ['Además', 'Além disso'],
  ['siempre', 'sempre'],
  ['Siempre', 'Sempre'],
  ['nunca', 'nunca'],
  ['Nunca', 'Nunca'],
  ['jamás', 'jamais'],
  ['Jamás', 'Jamais'],
  ['como', 'como'],
  ['Como', 'Como'],
  ['donde', 'onde'],
  ['Donde', 'Onde'],
  ['quien', 'quem'],
  ['Quien', 'Quem'],
  ['quienes', 'quem'],
  ['Quienes', 'Quem'],
  ['cual', 'qual'],
  ['Cual', 'Qual'],
  ['cuales', 'quais'],
  ['Cuales', 'Quais'],
  ['con', 'com'],
  ['Con', 'Com'],

  // Core WoW Nouns (Plurals first!)
  ['hechizos', 'feitiços'],
  ['Hechizos', 'Feitiços'],
  ['hechizo', 'feitiço'],
  ['Hechizo', 'Feitiço'],
  ['misiones', 'missões'],
  ['Misiones', 'Missões'],
  ['misión', 'missão'],
  ['Misión', 'Missão'],
  ['logros', 'conquistas'],
  ['Logros', 'Conquistas'],
  ['logro', 'conquista'],
  ['Logro', 'Conquista'],
  ['mazmorras', 'masmorras'],
  ['Mazmorras', 'Masmorras'],
  ['mazmorra', 'masmorra'],
  ['Mazmorra', 'Masmorra'],
  ['bandas', 'raides'],
  ['Bandas', 'Raides'],
  ['banda', 'raide'],
  ['Banda', 'Raide'],
  ['sanación', 'cura'],
  ['Sanación', 'Cura'],
  ['sanar', 'curar'],
  ['Sanar', 'Curar'],
  ['daños', 'danos'],
  ['Daños', 'Danos'],
  ['daño', 'dano'],
  ['Daño', 'Dano'],
  ['mascotas', 'ajudantes'],
  ['Mascotas', 'Ajudantes'],
  ['mascota', 'ajudante'],
  ['Mascota', 'Ajudante'],
  ['lanzadores', 'lançadores'],
  ['Lanzadores', 'Lançadores'],
  ['lanzador', 'lançador'],
  ['Lanzador', 'Lançador'],
  ['lanzamiento', 'conjuração'],
  ['Lanzamiento', 'Conjuração'],
  ['objetivos', 'alvos'],
  ['Objetivos', 'Alvos'],
  ['objetivo', 'alvo'],
  ['Objetivo', 'Alvo'],
  ['enemigos', 'inimigos'],
  ['Enemigos', 'Inimigos'],
  ['enemigo', 'inimigo'],
  ['Enemigo', 'Inimigo'],
  ['jugadores', 'jogadores'],
  ['Jugadores', 'Jogadores'],
  ['jugador', 'jogador'],
  ['Jugador', 'Jogador'],
  ['criaturas', 'criaturas'],
  ['Criaturas', 'Criaturas'],
  ['criatura', 'criatura'],
  ['Criatura', 'Criatura'],
  ['objetos', 'itens'],
  ['Objetos', 'Itens'],
  ['objeto', 'item'],
  ['Objeto', 'Item'],
  ['recompensas', 'recompensas'],
  ['Recompensas', 'Recompensas'],
  ['recompensa', 'recompensa'],
  ['Recompensa', 'Recompensa'],
  ['experiencia', 'experiência'],
  ['Experiencia', 'Experiência'],
  ['salud', 'vida'],
  ['Salud', 'Vida'],
  ['maná', 'mana'],
  ['Maná', 'Mana'],
  ['oro', 'ouro'],
  ['Oro', 'Ouro'],
  ['plata', 'prata'],
  ['Plata', 'Prata'],
  ['cobre', 'cobre'],
  ['Cobre', 'Cobre'],
  ['acumulaciones', 'acúmulos'],
  ['Acumulaciones', 'Acúmulos'],
  ['acumulación', 'acúmulo'],
  ['Acumulación', 'Acúmulo'],
  ['probabilidad', 'chance'],
  ['Probabilidad', 'Chance'],
  ['efectos', 'efeitos'],
  ['Efectos', 'Efeitos'],
  ['efecto', 'efeito'],
  ['Efeito', 'Efeito'],
  ['escudos', 'escudos'],
  ['Escudos', 'Escudos'],
  ['escudo', 'escudo'],
  ['Escudo', 'Escudo'],
  ['durante', 'durante'],
  ['Durante', 'Durante'],
  ['segundos', 'segundos'],
  ['Segundos', 'Segundos'],
  ['segundo', 'segundo'],
  ['Segundo', 'Segundo'],
  ['minutos', 'minutos'],
  ['Minutos', 'Minutos'],
  ['minuto', 'minuto'],
  ['Minuto', 'Minuto'],
  ['horas', 'horas'],
  ['Horas', 'Horas'],
  ['hora', 'hora'],
  ['Hora', 'Hora'],
  ['días', 'dias'],
  ['Días', 'Dias'],
  ['día', 'dia'],
  ['Día', 'Dia'],
  ['puntos', 'pontos'],
  ['Puntos', 'Pontos'],
  ['punto', 'ponto'],
  ['Punto', 'Ponto'],
  ['alcance', 'alcance'],
  ['Alcance', 'Alcance'],
  ['habilidades', 'habilidades'],
  ['Habilidades', 'Habilidades'],
  ['habilidad', 'habilidade'],
  ['Habilidad', 'Habilidade'],
  ['facultades', 'habilidades'],
  ['Facultades', 'Habilidades'],
  ['facultad', 'habilidade'],
  ['Facultad', 'Habilidade'],
  ['resistencias', 'resistências'],
  ['Resistencias', 'Resistências'],
  ['resistencia', 'resistência'],
  ['Resistencia', 'Resistência'],
  ['armadura', 'armadura'],
  ['Armadura', 'Armadura'],
  ['sangre', 'sangue'],
  ['Sangre', 'Sangue'],
  ['alma', 'alma'],
  ['Alma', 'Alma'],
  ['espíritu', 'espírito'],
  ['Espíritu', 'Espírito'],
  ['cólera', 'cólera'],
  ['Cólera', 'Cólera'],
  ['guerra', 'guerra'],
  ['Guerra', 'Guerra'],
  ['batalla', 'batalha'],
  ['Batalla', 'Batalha'],
  ['hermandad', 'guilda'],
  ['Hermandad', 'Guilda'],
  ['gremio', 'guilda'],
  ['Gremio', 'Guilda'],
  ['subasta', 'leilão'],
  ['Subasta', 'Leilão'],
  ['correo', 'correio'],
  ['Correo', 'Correio'],
  ['banco', 'banco'],
  ['Banco', 'Banco'],
  ['taberna', 'taberna'],
  ['Taberna', 'Taberna'],
  ['posada', 'estalagem'],
  ['Posada', 'Estalagem'],
  ['pesadilla', 'pesadelo'],
  ['Pesadilla', 'Pesadelo'],

  // Common Verbs
  ['inflige', 'causa'],
  ['Inflige', 'Causa'],
  ['otorga', 'concede'],
  ['Otorga', 'Concede'],
  ['aumenta', 'aumenta'],
  ['Aumenta', 'Aumenta'],
  ['reduce', 'reduz'],
  ['Reduce', 'Reduz'],
  ['restaura', 'restaura'],
  ['Restaura', 'Restaura'],
  ['absorbe', 'absorve'],
  ['Absorbe', 'Absorve'],
  ['requiere', 'requer'],
  ['Requiere', 'Requer'],
  ['obtiene', 'obtém'],
  ['Obtiene', 'Obtém'],
  ['hacer', 'fazer'],
  ['Hacer', 'Fazer'],
  ['hecho', 'feito'],
  ['Hecho', 'Feito'],
  ['hace', 'faz'],
  ['Hace', 'Faz'],
  ['tienes', 'tem'],
  ['tiene', 'tem'],
  ['tienen', 'têm'],
  ['Tiene', 'Tem'],
  ['Tienen', 'Têm'],
  ['puedes', 'pode'],
  ['puede', 'pode'],
  ['pueden', 'podem'],
  ['Puede', 'Pode'],
  ['Pueden', 'Podem'],
  ['quieres', 'quer'],
  ['quiere', 'quer'],
  ['quieren', 'querem'],
  ['Quiere', 'Quer'],
  ['encuentra', 'encontra'],
  ['Encuentra', 'Encontra'],
  ['encuentran', 'encontram'],
  ['Encuentran', 'Encontram'],
  ['busca', 'busca'],
  ['Busca', 'Busca'],
  ['buscan', 'buscam'],
  ['Buscan', 'Buscam'],
  ['habla', 'fale'],
  ['Habla', 'Fale'],
  ['hablan', 'falam'],
  ['Hablan', 'Falam'],
  ['mata', 'mate'],
  ['Mata', 'Mate'],
  ['matan', 'matam'],
  ['Matan', 'Matam'],
  ['derrota', 'derrote'],
  ['Derrota', 'Derrote'],
  ['derrotan', 'derrotam'],
  ['Derrotan', 'Derrotam'],
  ['destruye', 'destrua'],
  ['Destruye', 'Destrua'],
  ['destruyen', 'destroem'],
  ['Destruyen', 'Destroem'],
  ['protege', 'proteja'],
  ['Protege', 'Proteja'],
  ['protegen', 'protegem'],
  ['Protegen', 'Protegem'],
  ['defiende', 'defenda'],
  ['Defiende', 'Defenda'],
  ['defienden', 'defendem'],
  ['Defienden', 'Defendem'],
  ['rescata', 'resgate'],
  ['Rescata', 'Resgate'],
  ['rescatan', 'resgatam'],
  ['Rescatan', 'Resgatam'],
  ['recupera', 'recupere'],
  ['Recupera', 'Recupere'],
  ['recuperan', 'recuperam'],
  ['Recuperan', 'Recuperam'],
  ['entrega', 'entregue'],
  ['Entrega', 'Entregue'],
  ['entregan', 'entregam'],
  ['Entregan', 'Entregue'],
  ['trae', 'traga'],
  ['Trae', 'Traga'],
  ['traen', 'trazem'],
  ['Traen', 'Trazem'],
  ['lleva', 'leve'],
  ['Lleva', 'Leve'],
  ['llevan', 'levam'],
  ['Llevan', 'Levam'],
  ['consigue', 'consiga'],
  ['Consigue', 'Consiga'],
  ['consiguen', 'consiguem'],
  ['Consiguen', 'Consiguem'],

  // Numbers / Ordinals
  ['Primera', 'Primeira'],
  ['Primer', 'Primeiro'],
  ['Primero', 'Primeiro'],
  ['Segunda', 'Segunda'],
  ['Segundo', 'Segundo'],
  ['Tercera', 'Terceira'],
  ['Tercero', 'Terceiro']
];

function esToPt(text) {
  let out = text;

  // 1. Phrase replacements
  const sortedPhrases = [...PHRASE_TRANSLATIONS].sort((a, b) => b[0].length - a[0].length);
  const phraseTokens = [];
  for (const [from, to] of sortedPhrases) {
    if (from === to) continue;
    const token = `\x00PTOKEN${phraseTokens.length}\x00`;
    if (out.includes(from)) {
      out = out.split(from).join(token);
      phraseTokens.push(to);
    }
  }

  // 2. Word boundary replacements
  const wordTokens = [];
  for (const [from, to] of WORD_TRANSLATIONS) {
    if (from === to) continue;
    const token = `\x00WTOKEN${wordTokens.length}\x00`;
    const reg = new RegExp('\\b' + from.replace(/ /g, '\\s+') + '\\b', 'g');
    if (reg.test(out)) {
      out = out.replace(reg, token);
      wordTokens.push(to);
    }
  }

  // Restore Word Tokens
  for (let i = 0; i < wordTokens.length; i++) {
    out = out.split(`\x00WTOKEN${i}\x00`).join(wordTokens[i]);
  }

  // Restore Phrase Tokens
  for (let i = 0; i < phraseTokens.length; i++) {
    out = out.split(`\x00PTOKEN${i}\x00`).join(phraseTokens[i]);
  }

  // Phrase translations are intentionally restored last so they cannot be
  // damaged by shorter substitutions. Some legacy phrase entries, however,
  // still contain isolated Spanish words. Run one non-tokenizing cleanup pass
  // after restoration so the complete WORD_TRANSLATIONS glossary is applied
  // to those phrases as well.
  for (const [from, to] of WORD_TRANSLATIONS) {
    if (from === to) continue;
    const reg = new RegExp('\\b' + from.replace(/ /g, '\\s+') + '\\b', 'g');
    out = out.replace(reg, to);
  }

  return out;
}

function transformContent(relPath, content) {
  let out = applyIdentReplacements(content);

  if (relPath === 'Core.lua') {
    out = out.replace(/\{ key = "voice".+\},\n/, '');
    out = out.replace(/elseif msg == "voz" or msg == "voice" then[\s\S]*?return\n/, '');
    out = esToPt(out);
  } else if (relPath.startsWith('data/')) {
    const lines = out.split('\n');
    const transformedLines = lines.map(line => {
      if (!line.trim() || line.trim().startsWith('--')) return line;

      // Tuple format: T[id] = {"pattern", "translation"}
      // Pattern may contain escaped quotes \" so we use (?:[^"\\]|\\.)*
      // E.g., T[6]={"^Pattern...$", "Spanish text..."}
      // E.g., T[6]={"^\"Pattern\"...$", "Spanish text with \"quoted\" words..."}
      if (/T\[.+\]\s*=\s*\{"/.test(line)) {
        // Match tuple: ID={"pattern", "translation"}
        // Use a parser that skips escaped characters in the pattern
        const tupleMatch = line.match(/^(T\[.+?\]\s*=\s*\{")((?:[^"\\]|\\.)*)("\s*,\s*")((?:[^"\\]|\\.)*)("\})(.*)?$/);
        if (tupleMatch) {
          // tupleMatch[4] = translation value, apply esToPt only to translation
          return tupleMatch[1] + tupleMatch[2] + tupleMatch[3] + esToPt(tupleMatch[4]) + tupleMatch[5] + (tupleMatch[6] || '');
        }
      }

      // Key-value format: T[id]="val", G["key"]="val", ["key"]="val", T[id]="val" E[id]="eng"
      if (line.includes('="')) {
        return line.replace(/(=\s*")((?:[^"\\]|\\.)*)(")/g, (match, prefix, val, suffix) => {
          return prefix + esToPt(val) + suffix;
        });
      }

      return line;
    });
    out = transformedLines.join('\n');
  } else {
    out = esToPt(out);
  }

  return out;
}

function walkCopy(srcDir, dstDir, rel = '') {
  for (const entry of fs.readdirSync(srcDir, { withFileTypes: true })) {
    if (SKIP.has(entry.name)) continue;
    const relPath = rel ? `${rel}/${entry.name}` : entry.name;
    const srcPath = path.join(srcDir, entry.name);
    const dstPath = path.join(dstDir, entry.name);
    if (entry.isDirectory()) {
      if (entry.name === 'sounds') continue;
      fs.mkdirSync(dstPath, { recursive: true });
      walkCopy(srcPath, dstPath, relPath);
    } else if (entry.name.endsWith('.lua') || entry.name.endsWith('.toc')) {
      const raw = fs.readFileSync(srcPath, 'utf8');
      const transformed = transformContent(relPath.replace(/\\/g, '/'), raw);
      fs.writeFileSync(dstPath, transformed, 'utf8');
      console.log('OK', relPath);
    }
  }
}

console.log('Starting build-ptbr process...');
const residualToc = path.join(DST, 'AscensionES.toc');
if (fs.existsSync(residualToc)) {
  fs.unlinkSync(residualToc);
  console.log('Removed residual AscensionES.toc');
}

fs.mkdirSync(path.join(DST, 'data'), { recursive: true });
walkCopy(SRC, DST);

const toc = `## Interface: 30300
## Title: AscensionPTBR |cff33ff99português|r
## Notes: Tradução para português brasileiro de feitiços, talentos, itens e PNJs para Ascension (Conquest of Azeroth)
## Author: Baseado em AscensionES (HideXs)
## Version: 1.0.0
## SavedVariables: AscensionPTBRDB

data\\Patterns.lua
data\\CustomUI.lua
data\\UIStrings.lua
data\\Achievements.lua
data\\SpellNames.lua
data\\SpellDescs.lua
data\\SpellTips.lua
data\\SpellRanks.lua
data\\ItemNames.lua
data\\ItemDescs.lua
data\\UnitNames.lua
data\\Quests.lua
data\\Gossip.lua
data\\Errors.lua
data\\Chat.lua
Core.lua
Errors.lua
Chat.lua
`;
fs.writeFileSync(path.join(DST, 'AscensionPTBR.toc'), toc, 'utf8');
console.log('Wrote AscensionPTBR.toc');

// Synchronize to secondary workspace if present
if (fs.existsSync(SECONDARY_DST)) {
  console.log('Syncing to secondary workspace:', SECONDARY_DST);
  function syncDir(src, dst) {
    fs.mkdirSync(dst, { recursive: true });
    for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
      const s = path.join(src, entry.name);
      const d = path.join(dst, entry.name);
      if (entry.isDirectory()) {
        syncDir(s, d);
      } else {
        fs.copyFileSync(s, d);
      }
    }
  }
  syncDir(DST, SECONDARY_DST);
  console.log('Synced successfully to secondary workspace.');
}

console.log('Done.');
