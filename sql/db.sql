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


-- ============================================
-- START OF SEEDING FILE
-- ============================================

-- ============================================================
-- SEEDING DATA: AUTHORS, LEXICONS, & DICTIONARIES (EXTENDED)
-- ============================================================

-- ------------------------------------------------------------
-- 1. TABLE: AUTHORS
-- ------------------------------------------------------------
INSERT INTO authors (author_id, author_name) VALUES
                                                 ('AUTH_001', 'W.J.S. Poerwadarminta'),
                                                 ('AUTH_002', 'S. Prawiroatmodjo'),
                                                 ('AUTH_003', 'Drs. Sudaryanto'),
                                                 ('AUTH_004', 'Tim Redaksi Sastra.org');

-- ------------------------------------------------------------
-- 2. TABLE: LEXICONS
-- ------------------------------------------------------------
-- Menghubungkan buku dengan penulisnya (Foreign Key: author_id)
INSERT INTO lexicons (lexicon_id, title, words_in_total, date_of_prep, place_of_prep, description, author_id) VALUES
                                                                                                                  ('LEX_001', 'Bausastra Jawa Lengkap', 50000, '1939-01-01', 'Batavia', 'Kamus standar bahasa Jawa klasik yang memuat ribuan entri lengkap.', 'AUTH_001'),
                                                                                                                  ('LEX_002', 'Kamus Indonesia-Jawa Populer', 15000, '2020-05-20', 'Yogyakarta', 'Kamus praktis untuk percakapan sehari-hari, cocok untuk pemula.', 'AUTH_004'),
                                                                                                                  ('LEX_003', 'Pepak Basa Jawi', 8500, '1995-08-17', 'Surabaya', 'Panduan tata bahasa, pewayangan, dan kawruh basa.', 'AUTH_002'),
                                                                                                                  ('LEX_004', 'Kamus Unggah-Ungguh Basa', 6000, '2010-12-12', 'Solo', 'Kamus spesifik yang membedakan Ngoko, Madya, dan Krama Inggil.', 'AUTH_003');

-- ------------------------------------------------------------
-- 3. TABLE: DICTIONARIES
-- ------------------------------------------------------------
-- Data ini disebar ke berbagai Lexicon ID untuk simulasi data yang beragam.

-- KATEGORI: KATA GANTI & SAPAAN (Masuk ke LEX_002 - Populer)
INSERT INTO dictionaries (dict_id, entry, meaning, lexicon_id) VALUES
                                                                   ('DICT_001', 'Saya', 'Aku (Ngoko); Kula (Krama); Dalem (Krama Inggil)', 'LEX_002'),
                                                                   ('DICT_002', 'Kamu', 'Kowe (Ngoko); Sampeyan (Madya); Panjenengan (Krama Inggil)', 'LEX_002'),
                                                                   ('DICT_003', 'Dia', 'Deweke (Ngoko); Piyambakipun (Krama)', 'LEX_002'),
                                                                   ('DICT_004', 'Kita', 'Awak dhewe (Ngoko); Kito (Krama)', 'LEX_002'),
                                                                   ('DICT_005', 'Mereka', 'Wong-wong kuwi (Ngoko); Tiyang-tiyang punika (Krama)', 'LEX_002'),
                                                                   ('DICT_006', 'Apa', 'Apa (Ngoko); Punapa (Krama)', 'LEX_002'),
                                                                   ('DICT_007', 'Siapa', 'Sapa (Ngoko); Sinten (Krama)', 'LEX_002'),
                                                                   ('DICT_008', 'Kapan', 'Kapan (Ngoko); Kala punapa (Krama)', 'LEX_002'),
                                                                   ('DICT_009', 'Dimana', 'Nang endi (Ngoko); Wonten pundi (Krama)', 'LEX_002'),
                                                                   ('DICT_010', 'Bagaimana', 'Piye (Ngoko); Kados pundi (Krama)', 'LEX_002');

-- KATEGORI: KATA KERJA / AKTIVITAS (Masuk ke LEX_001 - Bausastra)
INSERT INTO dictionaries (dict_id, entry, meaning, lexicon_id) VALUES
                                                                   ('DICT_011', 'Makan', 'Mangan (Ngoko); Nedha (Madya); Dahar (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_012', 'Minum', 'Ngombe (Ngoko); Ngunjuk (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_013', 'Tidur', 'Turu (Ngoko); Sare (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_014', 'Pergi', 'Lunga (Ngoko); Kesah (Madya); Tindak (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_015', 'Pulang', 'Mulih (Ngoko); Wangsul (Madya); Kondur (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_016', 'Datang', 'Teka (Ngoko); Dugi (Madya); Rawuh (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_017', 'Mandi', 'Adus (Ngoko); Siram (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_018', 'Duduk', 'Lungguh (Ngoko); Lenggah (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_019', 'Berdiri', 'Ngadek (Ngoko); Jumeneng (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_020', 'Melihat', 'Ndeleng (Ngoko); Ningali (Madya); Mirsani (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_021', 'Mendengar', 'Krungu (Ngoko); Mireng (Madya); Midhanget (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_022', 'Berbicara', 'Ngomong (Ngoko); Matur (Madya); Ngendika (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_023', 'Membeli', 'Tuku (Ngoko); Tumbas (Madya); Mundhut (Krama Inggil)', 'LEX_001'),
                                                                   ('DICT_024', 'Minta', 'Njaluk (Ngoko); Nyuwun (Krama)', 'LEX_001'),
                                                                   ('DICT_025', 'Memberi', 'Menehi (Ngoko); Nyaosi (Krama Inggil); Paring (Krama)', 'LEX_001');

-- KATEGORI: KELUARGA (Masuk ke LEX_003 - Pepak)
INSERT INTO dictionaries (dict_id, entry, meaning, lexicon_id) VALUES
                                                                   ('DICT_026', 'Ayah', 'Bapak (Ngoko); Rama (Krama Inggil)', 'LEX_003'),
                                                                   ('DICT_027', 'Ibu', 'Simbok/Emak (Ngoko); Ibu (Krama)', 'LEX_003'),
                                                                   ('DICT_028', 'Anak', 'Anak (Ngoko); Putra (Krama Inggil)', 'LEX_003'),
                                                                   ('DICT_029', 'Kakak Laki-laki', 'Kangmas / Kakang (Ngoko/Krama)', 'LEX_003'),
                                                                   ('DICT_030', 'Kakak Perempuan', 'Mbakyu (Ngoko/Krama)', 'LEX_003'),
                                                                   ('DICT_031', 'Adik', 'Adhik (Ngoko); Rayi (Krama)', 'LEX_003'),
                                                                   ('DICT_032', 'Kakek', 'Mbah Kakung (Ngoko); Eyang Kakung (Krama)', 'LEX_003'),
                                                                   ('DICT_033', 'Nenek', 'Mbah Putri (Ngoko); Eyang Putri (Krama)', 'LEX_003'),
                                                                   ('DICT_034', 'Orang Tua', 'Wong Tuwa (Ngoko); Tiyang Sepuh (Krama)', 'LEX_003');

-- KATEGORI: ANGKA & BILANGAN (Masuk ke LEX_002 - Populer)
INSERT INTO dictionaries (dict_id, entry, meaning, lexicon_id) VALUES
                                                                   ('DICT_035', 'Satu', 'Siji (Ngoko); Setunggal (Krama)', 'LEX_002'),
                                                                   ('DICT_036', 'Dua', 'Loro (Ngoko); Kalih (Krama)', 'LEX_002'),
                                                                   ('DICT_037', 'Tiga', 'Telu (Ngoko); Tiga (Krama)', 'LEX_002'),
                                                                   ('DICT_038', 'Empat', 'Papat (Ngoko); Sekawan (Krama)', 'LEX_002'),
                                                                   ('DICT_039', 'Lima', 'Lima (Ngoko); Gangsal (Krama)', 'LEX_002'),
                                                                   ('DICT_040', 'Enam', 'Enem (Ngoko/Krama)', 'LEX_002'),
                                                                   ('DICT_041', ' Tujuh', 'Pitu (Ngoko/Krama)', 'LEX_002'),
                                                                   ('DICT_042', 'Delapan', 'Wolu (Ngoko/Krama)', 'LEX_002'),
                                                                   ('DICT_043', 'Sembilan', 'Sanga (Ngoko/Krama)', 'LEX_002'),
                                                                   ('DICT_044', 'Sepuluh', 'Sepuluh (Ngoko); Sedasa (Krama)', 'LEX_002'),
                                                                   ('DICT_045', 'Dua Puluh Lima', 'Selawe (Ngoko); Selangkung (Krama)', 'LEX_002'),
                                                                   ('DICT_046', 'Lima Puluh', 'Seket (Ngoko/Krama)', 'LEX_002'),
                                                                   ('DICT_047', 'Seratus', 'Satus (Ngoko); Setunggal Atus (Krama)', 'LEX_002');

-- KATEGORI: KATA SIFAT / KEADAAN (Masuk ke LEX_004 - Unggah-Ungguh)
INSERT INTO dictionaries (dict_id, entry, meaning, lexicon_id) VALUES
                                                                   ('DICT_048', 'Bagus', 'Apik (Ngoko); Sae (Krama)', 'LEX_004'),
                                                                   ('DICT_049', 'Jelek', 'Elek (Ngoko); Awon (Krama)', 'LEX_004'),
                                                                   ('DICT_050', 'Besar', 'Gedhe (Ngoko); Ageng (Krama)', 'LEX_004'),
                                                                   ('DICT_051', 'Kecil', 'Cilik (Ngoko); Alit (Krama)', 'LEX_004'),
                                                                   ('DICT_052', 'Banyak', 'Akeh (Ngoko); Kathah (Krama)', 'LEX_004'),
                                                                   ('DICT_053', 'Sedikit', 'Sithik (Ngoko); Sekedhik (Krama)', 'LEX_004'),
                                                                   ('DICT_054', 'Baru', 'Anyar (Ngoko); Enggal (Krama)', 'LEX_004'),
                                                                   ('DICT_055', 'Lama', 'Lawas (Ngoko); Lami/Dangu (Krama)', 'LEX_004'),
                                                                   ('DICT_056', 'Sakit', 'Lara (Ngoko); Gerah (Krama Inggil)', 'LEX_004'),
                                                                   ('DICT_057', 'Mati', 'Mati (Ngoko); Pejah (Madya); Seda (Krama Inggil)', 'LEX_004'),
                                                                   ('DICT_058', 'Hidup', 'Urip (Ngoko); Gesang (Krama); Sugeng (Krama Inggil)', 'LEX_004'),
                                                                   ('DICT_059', 'Murah', 'Murah (Ngoko); Mirah (Krama)', 'LEX_004'),
                                                                   ('DICT_060', 'Mahal', 'Larang (Ngoko); Awis (Krama)', 'LEX_004');

-- ============================================================
-- DATA TAMBAHAN KHUSUS UJI COBA PAGINASI (LIMIT & OFFSET)
-- ============================================================

-- 1. Buat Leksikon Khusus untuk Penampung Data Banyak
INSERT INTO lexicons (lexicon_id, title, words_in_total, date_of_prep, place_of_prep, description, author_id) VALUES
    ('LEX_999', 'Kamus Uji Coba Paginasi', 100, '2025-11-21', 'Server', 'Leksikon khusus berisi banyak data untuk testing limit dan offset.', 'AUTH_004');

-- 2. Isi Data Masif (50+ Entri)
-- ID dimulai dari DICT_100 untuk menghindari tabrakan dengan data sebelumnya

INSERT INTO dictionaries (dict_id, entry, meaning, lexicon_id) VALUES
-- KELOMPOK: ANGGOTA TUBUH (BODY PARTS)
('DICT_100', 'Kepala', 'Sirah (Ngoko); Mustaka (Krama Inggil)', 'LEX_999'),
('DICT_101', 'Rambut', 'Rambut (Ngoko); Rikma (Krama Inggil)', 'LEX_999'),
('DICT_102', 'Mata', 'Mripat (Ngoko); Soca (Krama Inggil)', 'LEX_999'),
('DICT_103', 'Hidung', 'Irung (Ngoko); Grana (Krama Inggil)', 'LEX_999'),
('DICT_104', 'Mulut', 'Cangkem (Ngoko - Kasar); Tutuk (Krama Inggil)', 'LEX_999'),
('DICT_105', 'Gigi', 'Untu (Ngoko); Waja (Krama Inggil)', 'LEX_999'),
('DICT_106', 'Telinga', 'Kuping (Ngoko); Talingan (Krama Inggil)', 'LEX_999'),
('DICT_107', 'Leher', 'Gulu (Ngoko); Jangga (Krama Inggil)', 'LEX_999'),
('DICT_108', 'Tangan', 'Tangan (Ngoko); Asta (Krama Inggil)', 'LEX_999'),
('DICT_109', 'Jari', 'Driji (Ngoko); Racikan (Krama Inggil)', 'LEX_999'),
('DICT_110', 'Dada', 'Dhadha (Ngoko); Jaja (Krama Inggil)', 'LEX_999'),
('DICT_111', 'Perut', 'Weteng (Ngoko); Padharan (Krama Inggil)', 'LEX_999'),
('DICT_112', 'Punggung', 'Geger (Ngoko); Pengkeran (Krama Inggil)', 'LEX_999'),
('DICT_113', 'Kaki', 'Sikil (Ngoko); Sampeyan (Krama Inggil)', 'LEX_999'),
('DICT_114', 'Darah', 'Getih (Ngoko); Rah (Krama Inggil)', 'LEX_999'),

-- KELOMPOK: ALAM (NATURE)
('DICT_115', 'Air', 'Banyu (Ngoko); Toya (Krama)', 'LEX_999'),
('DICT_116', 'Api', 'Geni (Ngoko); Latu (Krama)', 'LEX_999'),
('DICT_117', 'Angin', 'Angin (Ngoko); Bayu (Krama)', 'LEX_999'),
('DICT_118', 'Tanah', 'Lemah (Ngoko); Siti (Krama)', 'LEX_999'),
('DICT_119', 'Batu', 'Watu (Ngoko); Sela (Krama)', 'LEX_999'),
('DICT_120', 'Kayu', 'Kayu (Ngoko); Kajeng (Krama)', 'LEX_999'),
('DICT_121', 'Gunung', 'Gunung (Ngoko); Redi (Krama)', 'LEX_999'),
('DICT_122', 'Laut', 'Segara (Ngoko); Seganten (Krama)', 'LEX_999'),
('DICT_123', 'Sungai', 'Kali (Ngoko); Lepen (Krama)', 'LEX_999'),
('DICT_124', 'Matahari', 'Srengenge (Ngoko); Surya (Krama)', 'LEX_999'),
('DICT_125', 'Bulan', 'Rembulan (Ngoko); Candra (Krama)', 'LEX_999'),
('DICT_126', 'Bintang', 'Lintang (Ngoko/Krama)', 'LEX_999'),
('DICT_127', 'Langit', 'Langit (Ngoko); Awang-awang (Krama)', 'LEX_999'),
('DICT_128', 'Hujan', 'Udan (Ngoko); Jawah (Krama)', 'LEX_999'),
('DICT_129', 'Panas', 'Panas (Ngoko); Bentar (Krama)', 'LEX_999'),
('DICT_130', 'Dingin', 'Adhem (Ngoko); Asrep (Krama)', 'LEX_999'),

-- KELOMPOK: HEWAN (ANIMALS)
('DICT_131', 'Ayam', 'Pitik (Ngoko); Ayam (Krama)', 'LEX_999'),
('DICT_132', 'Bebek', 'Bebek (Ngoko); Kambangan (Krama)', 'LEX_999'),
('DICT_133', 'Sapi', 'Sapi (Ngoko); Lembu (Krama)', 'LEX_999'),
('DICT_134', 'Kerbau', 'Kebo (Ngoko); Maesa (Krama)', 'LEX_999'),
('DICT_135', 'Kambing', 'Wedhus (Ngoko); Menda (Krama)', 'LEX_999'),
('DICT_136', 'Kuda', 'Jaran (Ngoko); Turangga (Krama)', 'LEX_999'),
('DICT_137', 'Anjing', 'Asu (Ngoko); Segawon (Krama)', 'LEX_999'),
('DICT_138', 'Ular', 'Ula (Ngoko); Sawer (Krama)', 'LEX_999'),
('DICT_139', 'Tikus', 'Tikus (Ngoko); Yerrah (Krama)', 'LEX_999'),
('DICT_140', 'Burung', 'Manuk (Ngoko); Peksi (Krama)', 'LEX_999'),
('DICT_141', 'Ikan', 'Iwak (Ngoko); Ulam (Krama)', 'LEX_999'),
('DICT_142', 'Gajah', 'Gajah (Ngoko); Liman (Krama)', 'LEX_999'),
('DICT_143', 'Harimau', 'Macan (Ngoko); Simo (Krama)', 'LEX_999'),
('DICT_144', 'Monyet', 'Ketuk (Ngoko); Wanara (Krama)', 'LEX_999'),
('DICT_145', 'Nyamuk', 'Nyamuk (Ngoko/Krama)', 'LEX_999'),

-- KELOMPOK: BENDA RUMAH (HOUSEHOLD)
('DICT_146', 'Rumah', 'Omah (Ngoko); Griya (Krama); Dalem (Krama Inggil)', 'LEX_999'),
('DICT_147', 'Pintu', 'Lawang (Ngoko); Konten (Krama)', 'LEX_999'),
('DICT_148', 'Jendela', 'Cendhela (Ngoko/Krama)', 'LEX_999'),
('DICT_149', 'Meja', 'Meja (Ngoko/Krama)', 'LEX_999'),
('DICT_150', 'Kursi', 'Kursi (Ngoko/Krama)', 'LEX_999'),
('DICT_151', 'Tidur', 'Turu (Ngoko); Sare (Krama Inggil)', 'LEX_999'),
('DICT_152', 'Kasur', 'Kasur (Ngoko/Krama)', 'LEX_999'),
('DICT_153', 'Bantal', 'Bantal (Ngoko); Kajang Sirah (Krama)', 'LEX_999'),
('DICT_154', 'Selimut', 'Kemul (Ngoko); Singep (Krama)', 'LEX_999'),
('DICT_155', 'Piring', 'Piring (Ngoko); Ambeng (Krama)', 'LEX_999');

-- ============================================================
-- DATA TAMBAHAN: KAMUS JAWA KE INDONESIA
-- ============================================================

-- 1. Buat Leksikon Khusus "Jawa - Indonesia"
-- Kita beri kode LEX_JI_01 agar mudah dikenali
INSERT INTO lexicons (lexicon_id, title, words_in_total, date_of_prep, place_of_prep, description, author_id) VALUES
    ('LEX_JI_01', 'Kamus Jawa - Indonesia (Dasar)', 50, '2025-10-25', 'Yogyakarta', 'Kamus balik untuk mencari arti kata Jawa ke dalam bahasa Indonesia.', 'AUTH_002');

-- 2. Isi Kosakata (Entry = Jawa, Meaning = Indonesia)
-- ID kita mulai dari DICT_JI_001 biar rapi

INSERT INTO dictionaries (dict_id, entry, meaning, lexicon_id) VALUES
-- KATA SAPAAN & TANYA
('DICT_JI_001', 'Sugeng', 'Selamat; Hidup (Krama Inggil)', 'LEX_JI_01'),
('DICT_JI_002', 'Wilujeng', 'Selamat (Krama)', 'LEX_JI_01'),
('DICT_JI_003', 'Punapa', 'Apa (Krama)', 'LEX_JI_01'),
('DICT_JI_004', 'Sinten', 'Siapa (Krama)', 'LEX_JI_01'),
('DICT_JI_005', 'Pinten', 'Berapa (Krama)', 'LEX_JI_01'),
('DICT_JI_006', 'Pripun', 'Bagaimana (Ngoko/Madya)', 'LEX_JI_01'),
('DICT_JI_007', 'Njih', 'Iya (Krama)', 'LEX_JI_01'),
('DICT_JI_008', 'Mboten', 'Tidak (Krama)', 'LEX_JI_01'),
('DICT_JI_009', 'Sampun', 'Sudah (Krama)', 'LEX_JI_01'),
('DICT_JI_010', 'Dereng', 'Belum (Krama)', 'LEX_JI_01'),

-- KATA BENDA (MAKANAN & ALAM)
('DICT_JI_011', 'Sega', 'Nasi (Ngoko)', 'LEX_JI_01'),
('DICT_JI_012', 'Sekul', 'Nasi (Krama)', 'LEX_JI_01'),
('DICT_JI_013', 'Gedhang', 'Pisang', 'LEX_JI_01'),
('DICT_JI_014', 'Kates', 'Pepaya', 'LEX_JI_01'),
('DICT_JI_015', 'Lombok', 'Cabai', 'LEX_JI_01'),
('DICT_JI_016', 'Uyah', 'Garam', 'LEX_JI_01'),
('DICT_JI_017', 'Gula', 'Gula', 'LEX_JI_01'),
('DICT_JI_018', 'Toyo', 'Air (Krama)', 'LEX_JI_01'),
('DICT_JI_019', 'Lepen', 'Sungai (Krama)', 'LEX_JI_01'),
('DICT_JI_020', 'Sawah', 'Sawah', 'LEX_JI_01'),

-- KATA KERJA (VERBS)
('DICT_JI_021', 'Dahar', 'Makan (Krama Inggil)', 'LEX_JI_01'),
('DICT_JI_022', 'Nedha', 'Makan (Krama Madya)', 'LEX_JI_01'),
('DICT_JI_023', 'Sare', 'Tidur (Krama Inggil)', 'LEX_JI_01'),
('DICT_JI_024', 'Tilem', 'Tidur (Krama)', 'LEX_JI_01'),
('DICT_JI_025', 'Mirsani', 'Melihat (Krama Inggil)', 'LEX_JI_01'),
('DICT_JI_026', 'Mireng', 'Mendengar (Krama)', 'LEX_JI_01'),
('DICT_JI_027', 'Tindak', 'Pergi (Krama Inggil)', 'LEX_JI_01'),
('DICT_JI_028', 'Rawuh', 'Datang (Krama Inggil)', 'LEX_JI_01'),
('DICT_JI_029', 'Kondur', 'Pulang (Krama Inggil)', 'LEX_JI_01'),
('DICT_JI_030', 'Gerah', 'Sakit (Krama Inggil)', 'LEX_JI_01');

-- ============================================
-- END OF SEEDING FILE
-- ============================================
