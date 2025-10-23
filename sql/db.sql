create table users (
    user_id varchar(255) primary key not null,
    username varchar(255) not null default '',
    email varchar(255) not null unique default '',
    password varchar(255) not null default '',
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp
);

create table authors (
    author_id varchar(255) primary key not null,
    author_name varchar(255) not null default '',
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp
);

create table lexicons (
    lexicon_id varchar(255) primary key not null,
    title varchar(255) not null default '',
    words_in_total int not null default 0,
    description text not null,
    date_of_prep date not null,
    place_of_prep varchar(255) not null default '',
    author_id varchar(255) not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
    foreign key (author_id) references authors(author_id)
);

create table dictionaries (
    dict_id varchar(255) primary key not null,
    entry varchar(255) not null default '',
    meaning varchar(255) not null default '',
    lexicon_id varchar(255) not null,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
    foreign key (lexicon_id) references lexicons(lexicon_id)
);

create table lexicon_bookmarks (
    bookmark_id varchar(255) primary key not null,
    user_id varchar(255) not null,
    lexicon_id varchar(255) not null,
    created_at timestamp not null default current_timestamp,
    foreign key (user_id) references users(user_id),
    foreign key (lexicon_id) references lexicons(lexicon_id)
);

create table dictionary_bookmarks (
    bookmark_id varchar(255) primary key not null,
    user_id varchar(255) not null,
    dict_id varchar(255) not null,
    created_at timestamp not null default current_timestamp,
    foreign key (user_id) references users(user_id),
    foreign key (dict_id) references dictionaries(dict_id)
);

-- Seeding Data untuk Database Kamus
-- Script ini hanya mengisi data master: authors, lexicons, dan dictionaries
-- Data users dan bookmarks akan diisi secara berkala saat pengujian

-- ============================================
-- 1. SEEDING TABLE AUTHORS
-- ============================================
INSERT INTO authors (author_id, author_name) VALUES
                                                 ('author_001', 'Dr. Hasan Alwi'),
                                                 ('author_002', 'Prof. Anton M. Moeliono'),
                                                 ('author_003', 'Dr. Dendy Sugono'),
                                                 ('author_004', 'Prof. Abdul Chaer'),
                                                 ('author_005', 'Dr. Kridalaksana'),
                                                 ('author_006', 'Prof. Gorys Keraf'),
                                                 ('author_007', 'Dr. Sutan Takdir Alisjahbana'),
                                                 ('author_008', 'Prof. Satya Dharma');

-- ============================================
-- 2. SEEDING TABLE LEXICONS
-- ============================================
INSERT INTO lexicons (lexicon_id, title, words_in_total, description, date_of_prep, place_of_prep, author_id) VALUES
                                                                                                                  ('lex_001', 'Kamus Besar Bahasa Indonesia Edisi Kelima', 127000, 'Kamus lengkap bahasa Indonesia yang memuat kosakata bahasa Indonesia modern beserta penjelasan makna, ejaan, dan penggunaannya dalam konteks kalimat.', '2016-10-28', 'Jakarta', 'author_001'),
                                                                                                                  ('lex_002', 'Kamus Linguistik', 8500, 'Kamus istilah-istilah linguistik yang mencakup fonologi, morfologi, sintaksis, semantik, dan pragmatik untuk keperluan akademis.', '2008-05-15', 'Bandung', 'author_005'),
                                                                                                                  ('lex_003', 'Kamus Istilah Sastra', 6200, 'Kumpulan istilah sastra Indonesia dan dunia, termasuk genre, gaya bahasa, dan tokoh-tokoh penting dalam kesusastraan.', '2010-08-20', 'Yogyakarta', 'author_006'),
                                                                                                                  ('lex_004', 'Kamus Sinonim dan Antonim', 15000, 'Kamus praktis untuk menemukan persamaan dan lawan kata dalam bahasa Indonesia, berguna untuk penulisan dan pengayaan kosakata.', '2012-03-12', 'Jakarta', 'author_002'),
                                                                                                                  ('lex_005', 'Kamus Bahasa Indonesia-Inggris', 45000, 'Kamus dwibahasa yang memuat terjemahan kata dan frasa dari bahasa Indonesia ke bahasa Inggris dengan contoh penggunaan.', '2015-11-30', 'Jakarta', 'author_003'),
                                                                                                                  ('lex_006', 'Kamus Istilah Komputer dan Teknologi', 9800, 'Kamus terminologi komputer, internet, dan teknologi informasi dalam bahasa Indonesia dengan padanan bahasa Inggris.', '2018-07-14', 'Surabaya', 'author_004'),
                                                                                                                  ('lex_007', 'Kamus Kata Serapan Bahasa Indonesia', 12500, 'Koleksi kata-kata serapan dari berbagai bahasa asing yang telah diadopsi ke dalam bahasa Indonesia beserta asal-usulnya.', '2014-09-25', 'Jakarta', 'author_007'),
                                                                                                                  ('lex_008', 'Kamus Peribahasa Indonesia', 3400, 'Kumpulan peribahasa, ungkapan, dan idiom bahasa Indonesia lengkap dengan makna dan contoh penggunaan dalam kehidupan sehari-hari.', '2011-04-18', 'Bandung', 'author_008'),
                                                                                                                  ('lex_009', 'Kamus Bahasa Daerah Sunda-Indonesia', 18000, 'Kamus dwibahasa Sunda-Indonesia untuk melestarikan dan mempermudah pemahaman bahasa daerah Sunda.', '2017-02-10', 'Bandung', 'author_001'),
                                                                                                                  ('lex_010', 'Kamus Istilah Hukum', 7600, 'Kamus istilah hukum Indonesia yang mencakup terminologi perundang-undangan, hukum perdata, pidana, dan tata negara.', '2019-06-22', 'Jakarta', 'author_003');

-- ============================================
-- 3. SEEDING TABLE DICTIONARIES
-- ============================================
-- Dictionary entries untuk Kamus Besar Bahasa Indonesia (lex_001)
INSERT INTO dictionaries (dict_id, entry, meaning, lexicon_id) VALUES
                                                                   ('dict_0001', 'rumah', 'bangunan untuk tempat tinggal', 'lex_001'),
                                                                   ('dict_0002', 'makan', 'memasukkan makanan ke dalam mulut serta mengunyah dan menelannya', 'lex_001'),
                                                                   ('dict_0003', 'belajar', 'berusaha memperoleh kepandaian atau ilmu', 'lex_001'),
                                                                   ('dict_0004', 'membaca', 'melihat serta memahami isi dari apa yang tertulis', 'lex_001'),
                                                                   ('dict_0005', 'menulis', 'membuat huruf, angka, dan sebagainya dengan pena', 'lex_001'),
                                                                   ('dict_0006', 'bekerja', 'melakukan sesuatu pekerjaan; berbuat sesuatu', 'lex_001'),
                                                                   ('dict_0007', 'tidur', 'dalam keadaan berhenti menggunakan akal dan pikiran', 'lex_001'),
                                                                   ('dict_0008', 'air', 'cairan jernih tidak berwarna, tidak berasa, dan tidak berbau', 'lex_001'),
                                                                   ('dict_0009', 'api', 'panas dan cahaya yang berasal dari sesuatu yang terbakar', 'lex_001'),
                                                                   ('dict_0010', 'angin', 'udara yang bergerak', 'lex_001'),
                                                                   ('dict_0011', 'tanah', 'permukaan bumi atau lapisan bumi yang di atas sekali', 'lex_001'),
                                                                   ('dict_0012', 'langit', 'ruang luas yang terbentang di atas bumi', 'lex_001'),
                                                                   ('dict_0013', 'matahari', 'bintang yang memancarkan cahaya ke bumi pada siang hari', 'lex_001'),
                                                                   ('dict_0014', 'bulan', 'benda langit yang mengitari bumi sebagai satelitnya', 'lex_001'),
                                                                   ('dict_0015', 'bintang', 'benda langit yang memancarkan cahaya', 'lex_001'),
                                                                   ('dict_0016', 'gunung', 'bukit yang sangat besar dan tinggi', 'lex_001'),
                                                                   ('dict_0017', 'laut', 'kumpulan air asin yang sangat luas dan mengelilingi daratan', 'lex_001'),
                                                                   ('dict_0018', 'sungai', 'air yang mengalir dari hulu ke hilir', 'lex_001'),
                                                                   ('dict_0019', 'pohon', 'tumbuhan berbatang keras dan tinggi', 'lex_001'),
                                                                   ('dict_0020', 'bunga', 'bagian tumbuhan yang berwarna-warni', 'lex_001'),
                                                                   ('dict_0021', 'awan', 'kumpulan titik-titik air yang melayang di udara', 'lex_001'),
                                                                   ('dict_0022', 'hujan', 'titik-titik air yang jatuh dari udara karena pendinginan uap air', 'lex_001'),
                                                                   ('dict_0023', 'petir', 'kilat yang disertai bunyi gemuruh', 'lex_001'),
                                                                   ('dict_0024', 'pelangi', 'gejala optik berupa busur spektrum berwarna di langit', 'lex_001'),
                                                                   ('dict_0025', 'salju', 'hablur es yang turun ke bumi seperti hujan', 'lex_001'),

-- Dictionary entries untuk Kamus Linguistik (lex_002)
                                                                   ('dict_0026', 'fonologi', 'cabang linguistik yang mempelajari bunyi bahasa', 'lex_002'),
                                                                   ('dict_0027', 'morfologi', 'cabang linguistik tentang morfem dan kombinasi-kombinasinya', 'lex_002'),
                                                                   ('dict_0028', 'sintaksis', 'cabang linguistik tentang susunan kalimat dan bagian-bagiannya', 'lex_002'),
                                                                   ('dict_0029', 'semantik', 'cabang linguistik yang mempelajari makna', 'lex_002'),
                                                                   ('dict_0030', 'pragmatik', 'cabang linguistik yang mempelajari bahasa dalam konteks penggunaan', 'lex_002'),
                                                                   ('dict_0031', 'fonem', 'satuan bunyi terkecil yang membedakan makna', 'lex_002'),
                                                                   ('dict_0032', 'morfem', 'satuan gramatikal terkecil yang memiliki makna', 'lex_002'),
                                                                   ('dict_0033', 'kalimat', 'satuan bahasa yang secara relatif dapat berdiri sendiri', 'lex_002'),
                                                                   ('dict_0034', 'kata', 'satuan bahasa yang dapat berdiri sendiri', 'lex_002'),
                                                                   ('dict_0035', 'frasa', 'gabungan dua kata atau lebih yang bersifat non-predikatif', 'lex_002'),
                                                                   ('dict_0036', 'klausa', 'satuan gramatikal berupa kelompok kata yang sekurang-kurangnya terdiri dari subjek dan predikat', 'lex_002'),
                                                                   ('dict_0037', 'prefiks', 'imbuhan yang diletakkan di depan kata dasar', 'lex_002'),
                                                                   ('dict_0038', 'sufiks', 'imbuhan yang diletakkan di belakang kata dasar', 'lex_002'),
                                                                   ('dict_0039', 'infiks', 'imbuhan yang disisipkan di tengah kata dasar', 'lex_002'),
                                                                   ('dict_0040', 'afiks', 'imbuhan pada kata dasar', 'lex_002'),
                                                                   ('dict_0041', 'reduplikasi', 'pengulangan bentuk kata', 'lex_002'),
                                                                   ('dict_0042', 'homonim', 'kata yang sama bentuk dan bunyinya tetapi berbeda maknanya', 'lex_002'),
                                                                   ('dict_0043', 'sinonim', 'kata yang berbeda bentuk tetapi sama atau mirip maknanya', 'lex_002'),
                                                                   ('dict_0044', 'antonim', 'kata yang maknanya berlawanan', 'lex_002'),
                                                                   ('dict_0045', 'polisemi', 'kata yang memiliki lebih dari satu makna', 'lex_002'),

-- Dictionary entries untuk Kamus Istilah Sastra (lex_003)
                                                                   ('dict_0046', 'puisi', 'karya sastra yang terikat oleh irama, rima, dan penyusunan larik', 'lex_003'),
                                                                   ('dict_0047', 'prosa', 'karya sastra yang tidak terikat oleh kaidah yang mengikat', 'lex_003'),
                                                                   ('dict_0048', 'novel', 'karangan prosa yang panjang mengandung rangkaian cerita kehidupan', 'lex_003'),
                                                                   ('dict_0049', 'cerpen', 'cerita pendek yang hanya menceritakan sebagian kecil kehidupan tokoh', 'lex_003'),
                                                                   ('dict_0050', 'drama', 'karya sastra yang dipentaskan', 'lex_003'),
                                                                   ('dict_0051', 'metafora', 'gaya bahasa yang membandingkan sesuatu dengan sesuatu yang lain', 'lex_003'),
                                                                   ('dict_0052', 'personifikasi', 'gaya bahasa yang memberikan sifat manusia pada benda mati', 'lex_003'),
                                                                   ('dict_0053', 'hiperbola', 'gaya bahasa yang melebih-lebihkan', 'lex_003'),
                                                                   ('dict_0054', 'simbolisme', 'penggunaan simbol untuk menyampaikan makna tertentu', 'lex_003'),
                                                                   ('dict_0055', 'aliterasi', 'pengulangan bunyi konsonan pada awal kata', 'lex_003'),
                                                                   ('dict_0056', 'asonansi', 'pengulangan bunyi vokal dalam puisi', 'lex_003'),
                                                                   ('dict_0057', 'rima', 'persamaan bunyi pada akhir baris puisi', 'lex_003'),
                                                                   ('dict_0058', 'tema', 'gagasan pokok atau ide pikiran tentang sesuatu', 'lex_003'),
                                                                   ('dict_0059', 'alur', 'rangkaian peristiwa yang membentuk cerita', 'lex_003'),
                                                                   ('dict_0060', 'tokoh', 'pelaku dalam cerita', 'lex_003'),
                                                                   ('dict_0061', 'penokohan', 'cara pengarang menggambarkan karakter tokoh', 'lex_003'),
                                                                   ('dict_0062', 'latar', 'tempat, waktu, dan suasana terjadinya peristiwa dalam cerita', 'lex_003'),
                                                                   ('dict_0063', 'sudut pandang', 'posisi pengarang dalam membawakan cerita', 'lex_003'),
                                                                   ('dict_0064', 'amanat', 'pesan moral yang ingin disampaikan pengarang', 'lex_003'),
                                                                   ('dict_0065', 'epilog', 'bagian penutup cerita', 'lex_003'),

-- Dictionary entries untuk Kamus Sinonim dan Antonim (lex_004)
                                                                   ('dict_0066', 'besar', 'sinonim: raksasa, jumbo, luas; antonim: kecil, mungil, sempit', 'lex_004'),
                                                                   ('dict_0067', 'cantik', 'sinonim: indah, elok, molek; antonim: jelek, buruk, hodoh', 'lex_004'),
                                                                   ('dict_0068', 'cepat', 'sinonim: kilat, gesit, laju; antonim: lambat, pelan, lamban', 'lex_004'),
                                                                   ('dict_0069', 'pintar', 'sinonim: cerdas, pandai, jenius; antonim: bodoh, dungu, tolol', 'lex_004'),
                                                                   ('dict_0070', 'senang', 'sinonim: gembira, bahagia, suka; antonim: sedih, duka, susah', 'lex_004'),
                                                                   ('dict_0071', 'terang', 'sinonim: cerah, jelas, benderang; antonim: gelap, redup, suram', 'lex_004'),
                                                                   ('dict_0072', 'kaya', 'sinonim: makmur, berada, mampu; antonim: miskin, papa, melarat', 'lex_004'),
                                                                   ('dict_0073', 'panas', 'sinonim: hangat, gerah, membara; antonim: dingin, sejuk, adem', 'lex_004'),
                                                                   ('dict_0074', 'jauh', 'sinonim: nun, berjarak, terpencil; antonim: dekat, rapat, berdempetan', 'lex_004'),
                                                                   ('dict_0075', 'tinggi', 'sinonim: jangkung, menjulang, rimbun; antonim: rendah, pendek, ceper', 'lex_004'),
                                                                   ('dict_0076', 'kuat', 'sinonim: kokoh, tangguh, perkasa; antonim: lemah, rapuh, ringkih', 'lex_004'),
                                                                   ('dict_0077', 'rajin', 'sinonim: tekun, giat, ulet; antonim: malas, lesu, santai', 'lex_004'),
                                                                   ('dict_0078', 'berani', 'sinonim: gagah, perkasa, nekat; antonim: takut, pengecut, penakut', 'lex_004'),
                                                                   ('dict_0079', 'jujur', 'sinonim: tulus, ikhlas, lurus; antonim: bohong, dusta, curang', 'lex_004'),
                                                                   ('dict_0080', 'sabar', 'sinonim: tabah, tenang, tahan; antonim: emosi, tergesa, gegabah', 'lex_004'),

-- Dictionary entries untuk Kamus Bahasa Indonesia-Inggris (lex_005)
                                                                   ('dict_0081', 'sekolah', 'school (noun): tempat untuk belajar dan mengajar', 'lex_005'),
                                                                   ('dict_0082', 'guru', 'teacher (noun): orang yang mengajar di sekolah', 'lex_005'),
                                                                   ('dict_0083', 'siswa', 'student (noun): orang yang belajar di sekolah', 'lex_005'),
                                                                   ('dict_0084', 'buku', 'book (noun): kumpulan kertas yang dijilid berisi tulisan', 'lex_005'),
                                                                   ('dict_0085', 'perpustakaan', 'library (noun): tempat penyimpanan dan peminjaman buku', 'lex_005'),
                                                                   ('dict_0086', 'komputer', 'computer (noun): alat elektronik untuk mengolah data', 'lex_005'),
                                                                   ('dict_0087', 'telepon', 'telephone/phone (noun): alat komunikasi jarak jauh', 'lex_005'),
                                                                   ('dict_0088', 'mobil', 'car (noun): kendaraan bermotor dengan empat roda', 'lex_005'),
                                                                   ('dict_0089', 'kereta', 'train (noun): kendaraan yang berjalan di atas rel', 'lex_005'),
                                                                   ('dict_0090', 'pesawat', 'airplane (noun): kendaraan udara yang dapat terbang', 'lex_005'),
                                                                   ('dict_0091', 'rumah sakit', 'hospital (noun): tempat untuk merawat orang sakit', 'lex_005'),
                                                                   ('dict_0092', 'dokter', 'doctor (noun): orang yang mengobati penyakit', 'lex_005'),
                                                                   ('dict_0093', 'kantor', 'office (noun): tempat untuk bekerja', 'lex_005'),
                                                                   ('dict_0094', 'pasar', 'market (noun): tempat untuk berjual beli', 'lex_005'),
                                                                   ('dict_0095', 'restoran', 'restaurant (noun): tempat untuk makan', 'lex_005'),

-- Dictionary entries untuk Kamus Istilah Komputer (lex_006)
                                                                   ('dict_0096', 'algoritma', 'urutan langkah-langkah logis untuk menyelesaikan masalah', 'lex_006'),
                                                                   ('dict_0097', 'database', 'kumpulan data yang terorganisir dan dapat diakses secara elektronik', 'lex_006'),
                                                                   ('dict_0098', 'interface', 'antarmuka pengguna untuk berinteraksi dengan sistem', 'lex_006'),
                                                                   ('dict_0099', 'server', 'komputer yang menyediakan layanan untuk komputer lain', 'lex_006'),
                                                                   ('dict_0100', 'client', 'komputer yang menggunakan layanan dari server', 'lex_006'),
                                                                   ('dict_0101', 'bandwidth', 'kapasitas maksimal transfer data dalam jaringan', 'lex_006'),
                                                                   ('dict_0102', 'firewall', 'sistem keamanan untuk melindungi jaringan dari akses tidak sah', 'lex_006'),
                                                                   ('dict_0103', 'software', 'perangkat lunak atau program komputer', 'lex_006'),
                                                                   ('dict_0104', 'hardware', 'perangkat keras atau komponen fisik komputer', 'lex_006'),
                                                                   ('dict_0105', 'cloud computing', 'penyimpanan dan pengolahan data melalui internet', 'lex_006'),
                                                                   ('dict_0106', 'encryption', 'proses mengubah data menjadi kode rahasia', 'lex_006'),
                                                                   ('dict_0107', 'debugging', 'proses mencari dan memperbaiki kesalahan dalam program', 'lex_006'),
                                                                   ('dict_0108', 'framework', 'kerangka kerja untuk membangun aplikasi', 'lex_006'),
                                                                   ('dict_0109', 'API', 'Application Programming Interface, antarmuka untuk komunikasi antar aplikasi', 'lex_006'),
                                                                   ('dict_0110', 'repository', 'tempat penyimpanan kode sumber program', 'lex_006'),

-- Dictionary entries untuk Kamus Kata Serapan (lex_007)
                                                                   ('dict_0111', 'organisasi', 'dari bahasa Inggris organization, berarti susunan atau kelompok', 'lex_007'),
                                                                   ('dict_0112', 'teknologi', 'dari bahasa Yunani technologia, berarti ilmu pengetahuan praktis', 'lex_007'),
                                                                   ('dict_0113', 'filosofi', 'dari bahasa Yunani philosophia, berarti cinta kebijaksanaan', 'lex_007'),
                                                                   ('dict_0114', 'demokrasi', 'dari bahasa Yunani demokratia, berarti pemerintahan rakyat', 'lex_007'),
                                                                   ('dict_0115', 'ekonomi', 'dari bahasa Yunani oikonomia, berarti pengelolaan rumah tangga', 'lex_007'),
                                                                   ('dict_0116', 'televisi', 'dari bahasa Inggris television, berarti penglihatan jarak jauh', 'lex_007'),
                                                                   ('dict_0117', 'fotografi', 'dari bahasa Yunani photos dan graphein, berarti menulis dengan cahaya', 'lex_007'),
                                                                   ('dict_0118', 'biografi', 'dari bahasa Yunani bios dan graphein, berarti tulisan tentang kehidupan', 'lex_007'),
                                                                   ('dict_0119', 'geografi', 'dari bahasa Yunani geo dan graphein, berarti gambaran bumi', 'lex_007'),
                                                                   ('dict_0120', 'psikologi', 'dari bahasa Yunani psyche dan logos, berarti ilmu jiwa', 'lex_007'),
                                                                   ('dict_0121', 'sosiologi', 'dari bahasa Latin socius dan logos, berarti ilmu tentang masyarakat', 'lex_007'),
                                                                   ('dict_0122', 'bibliografi', 'dari bahasa Yunani biblion dan graphein, berarti daftar pustaka', 'lex_007'),
                                                                   ('dict_0123', 'kronologi', 'dari bahasa Yunani chronos dan logos, berarti urutan waktu', 'lex_007'),
                                                                   ('dict_0124', 'antropologi', 'dari bahasa Yunani anthropos dan logos, berarti ilmu tentang manusia', 'lex_007'),
                                                                   ('dict_0125', 'metodologi', 'dari bahasa Yunani methodos dan logos, berarti ilmu tentang metode', 'lex_007'),

-- Dictionary entries untuk Kamus Peribahasa (lex_008)
                                                                   ('dict_0126', 'air beriak tanda tak dalam', 'orang yang berilmu tinggi tidak sombong', 'lex_008'),
                                                                   ('dict_0127', 'bagai pungguk merindukan bulan', 'mengharapkan sesuatu yang mustahil', 'lex_008'),
                                                                   ('dict_0128', 'seperti katak dalam tempurung', 'berpandangan sempit dan tidak tahu dunia luar', 'lex_008'),
                                                                   ('dict_0129', 'besar pasak daripada tiang', 'pengeluaran lebih besar daripada pemasukan', 'lex_008'),
                                                                   ('dict_0130', 'ada udang di balik batu', 'ada maksud tersembunyi', 'lex_008'),
                                                                   ('dict_0131', 'sepandai-pandai tupai melompat', 'orang yang pandai pun dapat berbuat salah', 'lex_008'),
                                                                   ('dict_0132', 'tak ada rotan akar pun jadi', 'bila tidak ada yang baik, yang kurang baik pun dapat dipakai', 'lex_008'),
                                                                   ('dict_0133', 'menepuk air di dulang', 'perbuatan yang merugikan diri sendiri', 'lex_008'),
                                                                   ('dict_0134', 'sambil menyelam minum air', 'mendapat dua keuntungan sekaligus', 'lex_008'),
                                                                   ('dict_0135', 'berat sama dipikul ringan sama dijinjing', 'saling tolong-menolong dalam kesulitan', 'lex_008'),
                                                                   ('dict_0136', 'buah bibir', 'bahan pembicaraan orang banyak', 'lex_008'),
                                                                   ('dict_0137', 'bunga desa', 'orang yang sangat cantik atau gagah di desa', 'lex_008'),
                                                                   ('dict_0138', 'makan hati', 'merasa sakit hati atau dendam', 'lex_008'),
                                                                   ('dict_0139', 'panjang tangan', 'suka mencuri', 'lex_008'),
                                                                   ('dict_0140', 'ringan tangan', 'suka membantu', 'lex_008'),

-- Dictionary entries untuk Kamus Bahasa Sunda (lex_009)
                                                                   ('dict_0141', 'imah', 'rumah', 'lex_009'),
                                                                   ('dict_0142', 'tuang', 'makan', 'lex_009'),
                                                                   ('dict_0143', 'diajar', 'belajar', 'lex_009'),
                                                                   ('dict_0144', 'maca', 'membaca', 'lex_009'),
                                                                   ('dict_0145', 'nulis', 'menulis', 'lex_009'),
                                                                   ('dict_0146', 'pagawean', 'pekerjaan', 'lex_009'),
                                                                   ('dict_0147', 'sare', 'tidur', 'lex_009'),
                                                                   ('dict_0148', 'cai', 'air', 'lex_009'),
                                                                   ('dict_0149', 'seuneu', 'api', 'lex_009'),
                                                                   ('dict_0150', 'angin', 'angin', 'lex_009'),
                                                                   ('dict_0151', 'leuweung', 'hutan', 'lex_009'),
                                                                   ('dict_0152', 'sagara', 'laut', 'lex_009'),
                                                                   ('dict_0153', 'gunung', 'gunung', 'lex_009'),
                                                                   ('dict_0154', 'sawah', 'sawah', 'lex_009'),
                                                                   ('dict_0155', 'pasar', 'pasar', 'lex_009'),

-- Dictionary entries untuk Kamus Istilah Hukum (lex_010)
                                                                   ('dict_0156', 'gugatan', 'tuntutan hak yang diajukan oleh penggugat kepada tergugat', 'lex_010'),
                                                                   ('dict_0157', 'dakwaan', 'surat yang memuat perumusan tindak pidana yang didakwakan', 'lex_010'),
                                                                   ('dict_0158', 'vonis', 'keputusan hakim tentang perkara yang diadilinya', 'lex_010'),
                                                                   ('dict_0159', 'saksi', 'orang yang melihat atau mengalami sendiri suatu peristiwa', 'lex_010'),
                                                                   ('dict_0160', 'terdakwa', 'orang yang didakwa melakukan tindak pidana', 'lex_010'),
                                                                   ('dict_0161', 'penggugat', 'pihak yang mengajukan gugatan dalam perkara perdata', 'lex_010'),
                                                                   ('dict_0162', 'tergugat', 'pihak yang digugat dalam perkara perdata', 'lex_010'),
                                                                   ('dict_0163', 'banding', 'upaya hukum terhadap putusan pengadilan tingkat pertama', 'lex_010'),
                                                                   ('dict_0164', 'kasasi', 'upaya hukum terhadap putusan pengadilan tingkat banding', 'lex_010'),
                                                                   ('dict_0165', 'eksekusi', 'pelaksanaan putusan pengadilan yang telah berkekuatan hukum tetap', 'lex_010'),
                                                                   ('dict_0166', 'hukum perdata', 'hukum yang mengatur hubungan antara individu dengan individu', 'lex_010'),
                                                                   ('dict_0167', 'hukum pidana', 'hukum yang mengatur tentang kejahatan dan pelanggaran', 'lex_010'),
                                                                   ('dict_0168', 'hukum tata negara', 'hukum yang mengatur tentang organisasi negara', 'lex_010'),
                                                                   ('dict_0169', 'yurisprudensi', 'keputusan pengadilan yang dijadikan pedoman', 'lex_010'),
                                                                   ('dict_0170', 'notaris', 'pejabat umum yang berwenang membuat akta otentik', 'lex_010');


-- ============================================
-- END OF SEEDING FILE
-- ============================================
select
    d.dict_id, d.entry, d.meaning, l.title,
    case when db.bookmark_id is not null then true else false end as is_bookmarked
from dictionaries d
inner join lexicons l on d.lexicon_id = l.lexicon_id
left join dictionary_bookmarks db on d.dict_id = db.dict_id and db.user_id = 'a79736f83c5acdece05cd67d862dd413'
where d.entry like '%hukum%'
limit 5 offset 0;

select * from dictionary_bookmarks;
select * from users;
-- a79736f83c5acdece05cd67d862dd413

describe lexicon_bookmarks;
select * from authors;
select * from lexicons;

select
    l.lexicon_id, l.title, l.words_in_total, l.description, l.date_of_prep, l.place_of_prep,
    a.author_name,
    IF(lb.bookmark_id is not null, true, false) as is_bookmarked
from lexicons l
inner join authors a on l.author_id = a.author_id
left join lexicon_bookmarks lb on l.lexicon_id = lb.lexicon_id and lb.user_id = 'a79736f83c5acdece05cd67d862dd';

select * from lexicon_bookmarks;