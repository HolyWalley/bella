# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe Bella::Latinizer do
  context "when converting vovels" do
    specify { expect(described_class.latinize("ЮрліВец лЮбіЦь лІю п'ю")).to eq("JurliViec lUbiĆ lIju pju") }
    specify { expect(described_class.latinize("Яз'яваЗЯпазЬяВА")).to eq("JazjavaZIapaźjaVA") }
  end

  context "when converting consonants" do
    specify { expect(described_class.latinize("ЛаЭлЯЛуЛіЛюЛЁлЕлЬ лЛя")).to eq("ŁaElAŁuLiLuLOlEl lLa") }
    specify do
      expect(described_class.latinize("ХаХу ХЫВАХххххх Хіх")).to eq("ChaChu ChYVAChchchchchch Chich")
    end
    specify { expect(described_class.latinize("ШашуШышшшшшшш")).to eq("ŠašuŠyššššššš") }
    specify { expect(described_class.latinize("чАЧыЧУ")).to eq("čAČyČU") }
    specify do
      expect(described_class.latinize("жУрАвІнЫЖэЖЫ")).to eq("žUrAvInYŽeŽY")
    end
    specify do
      expect(described_class.latinize("войт і Ваявода")).to eq("vojt i Vajavoda")
    end
  end

  context "when converting mixed text" do
    subject { described_class.latinize(text) }

    context "text 1" do
      let(:text) do
        <<~TEXT
          Вітаем цябе, чытачу!
          Гэта трэці нумар PAMYŁKA ZIN!
          Мы вельмі цешымся, што да каманды стваральнікаў працягваюць далучацца
          новыя навукоўцы і мастакі! І мы будзем радыя кожнаму новаму ўдзельніку!
          Сябры, мы рэдакцыяй надумалі запачаткаваць прэмію – «Бізон Гіґс». Таму гэты
          нумар мы прысвячаем усім беларускім навукоўцам і хочам анансаваць прэмію,
          якая будзе ўвасабляць сабой Беларусь і навуку разам! Гэта ўзнагарода для
          беларускіх навукоўцаў і даследнікаў дакладных і прыродазнаўчых навук ад
          навукова-папулярнага часопісу Pamyłka Zin.
          Больш дэталяў апавядае першы артыкул нумару.
        TEXT
      end

      let(:expected_result) do
        <<~TEXT
          Vitajem ciabie, čytaču!
          Heta treci numar PAMYŁKA ZIN!
          My vielmi ciešymsia, što da kamandy stvaralnikaŭ praciahvajuć dałučacca
          novyja navukoŭcy i mastaki! I my budziem radyja kožnamu novamu ŭdzielniku!
          Siabry, my redakcyjaj nadumali zapačatkavać premiju – «Bizon Higs». Tamu hety
          numar my prysviačajem usim biełaruskim navukoŭcam i chočam anansavać premiju,
          jakaja budzie ŭvasablać saboj Biełaruś i navuku razam! Heta ŭznaharoda dla
          biełaruskich navukoŭcaŭ i daslednikaŭ dakładnych i pryrodaznaŭčych navuk ad
          navukova-papularnaha časopisu Pamyłka Zin.
          Bolš detalaŭ apaviadaje pieršy artykuł numaru.
        TEXT
      end

      specify { expect(subject).to eq(expected_result) }
    end

    context "text 2" do
      let(:text) do
        <<~TEXT
          Маладыя гады,
          Маладыя жаданні!
          Ні жуды, ні нуды,
          Толькі шчасьце каханьня!

          Помніш толькі красу,
          Мілы тварык дзявочы,
          Залатую касу,
          Сіняватыя вочы!

          Цёмны сад-вінаград,
          Цьвет бяленькі вішнёвы, —
          І агністы пагляд,
          І гарачыя словы!

          Будзь жа, век малады,
          Поўны сьветлымі днямі!
          Пралятайце, гады,
          Залатымі агнямі!
        TEXT
      end

      let(:expected_result) do
        <<~TEXT
          Maładyja hady,
          Maładyja žadanni!
          Ni žudy, ni nudy,
          Tolki ščaście kachańnia!

          Pomniš tolki krasu,
          Miły tvaryk dziavočy,
          Załatuju kasu,
          Siniavatyja vočy!

          Ciomny sad-vinahrad,
          Ćviet bialeńki višniovy, —
          I ahnisty pahlad,
          I haračyja słovy!

          Budź ža, viek małady,
          Poŭny śvietłymi dniami!
          Pralatajcie, hady,
          Załatymi ahniami!
        TEXT
      end

      specify { expect(subject).to eq(expected_result) }
    end
  end
end
# rubocop:enable Metrics/BlockLength
