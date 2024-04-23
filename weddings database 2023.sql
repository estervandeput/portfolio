DROP DATABASE IF EXISTS weddings;

CREATE DATABASE IF NOT EXISTS weddings;

USE weddings;

-- Departments
CREATE TABLE departments (
    function_id CHAR(2) NOT NULL,
    functions VARCHAR(16),
    PRIMARY KEY (function_id)
);

-- prices Table
CREATE TABLE prices (
    price_id CHAR(1) NOT NULL,
    affordability VARCHAR(11) NOT NULL,
    PRIMARY KEY(price_id)
);

-- cities Table
CREATE TABLE cities(
	city_id CHAR(6) NOT NULL,
	city VARCHAR(15),
	PRIMARY KEY (city_id)
);


-- Vendors Table
CREATE TABLE vendors (
	vendor_id CHAR(5) NOT NULL,
    function_id CHAR(2) NOT NULL,
    vendor VARCHAR(75) NOT NULL,
    city_id CHAR(6) NOT NULL,
    price_id CHAR(1) NOT NULL,
    reviews INT(4) NOT NULL,
    avg_stars FLOAT(2,1) NOT NULL,
    PRIMARY KEY (vendor_id),
    FOREIGN KEY (function_id) REFERENCES departments(function_id),
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    FOREIGN KEY (price_id) REFERENCES prices(price_id)
);

-- companies Table
CREATE TABLE companies (
    cmp_id CHAR(5) NOT NULL,
    company VARCHAR(75) NOT NULL,
    PRIMARY KEY(cmp_id)
);

-- store_cmp Table
CREATE TABLE store_cmp (
    store_id CHAR(5) NOT NULL,
    cmp_id CHAR(5) NOT NULL,
    PRIMARY KEY (store_id),
	FOREIGN KEY (store_id) REFERENCES vendors(vendor_id),
	FOREIGN KEY (cmp_id) REFERENCES companies(cmp_id)
);

-- Sources
CREATE TABLE sources (
	url_id CHAR(5) NOT NULL,
    url VARCHAR(150),
    PRIMARY KEY(url_id),
    FOREIGN KEY(url_id) REFERENCES vendors(vendor_id)
);

-- planner_prices Table
CREATE TABLE planner_prices(
	wed_id CHAR(5) NOT NULL,
	hourly BOOL NOT NULL,
	daily FLOAT(7,2),
	`partial` FLOAT(7,2), 
   	`full`  FLOAT(7,2),
    PRIMARY KEY(wed_id),
    FOREIGN KEY(wed_id) REFERENCES vendors(vendor_id)
);

-- photo_prices Table
CREATE TABLE photo_prices (
    pho_id CHAR(5) NOT NULL,
    is_photographer BOOLEAN NOT NULL,
    package_price FLOAT(5,2),
    PRIMARY KEY (pho_id),
    FOREIGN KEY (pho_id) REFERENCES vendors(vendor_id)
);

-- music_type Table
CREATE TABLE music_type (
    type_id CHAR(1),
    `type` VARCHAR(22),
    PRIMARY KEY(type_id)
);

-- music_match Table
CREATE TABLE music_match (
    mus_id CHAR(5),
    type_id CHAR(1),
    PRIMARY KEY(mus_id),
    FOREIGN KEY (mus_id) REFERENCES vendors(vendor_id),
    FOREIGN KEY (type_id) REFERENCES music_type(type_id)
);

-- addresses Table
CREATE TABLE addresses(
	address_id CHAR(5) NOT NULL,
	address VARCHAR(50),
	PRIMARY KEY (address_id),
	FOREIGN KEY (address_id) REFERENCES  vendors(vendor_id) 
);

-- tasting_cities Table
CREATE TABLE tasting_cities (
    cat_id CHAR(5) NOT NULL,
    city_id CHAR(6) NOT NULL,
    PRIMARY KEY (cat_id),
    FOREIGN KEY(cat_id) REFERENCES vendors(vendor_id),
    FOREIGN KEY(city_id) REFERENCES cities(city_id)
);

-- hair_experience Table
CREATE TABLE hair_experience (
	hai_id CHAR(5) NOT NULL,
	years INT(2) NOT NULL,
	PRIMARY KEY(hai_id),
	FOREIGN KEY (hai_id) REFERENCES vendors(vendor_id)
);

-- hair_services Table
CREATE TABLE hair_services (
	hai_id CHAR(5) NOT NULL, 
	hair BOOLEAN NOT NULL, 
	makeup BOOLEAN NOT NULL, 
	pre_wedding BOOLEAN NOT NULL,
	PRIMARY KEY(hai_id),
	FOREIGN KEY (hai_id) REFERENCES vendors(vendor_id)
);

-- catering_services Table
CREATE TABLE catering_services (
    cat_id CHAR(5) NOT NULL,
    buffet BOOL NOT NULL,
    plate BOOL NOT NULL,
    PRIMARY KEY (cat_id),
    FOREIGN KEY (cat_id) REFERENCES vendors(vendor_id)
);

-- rental_services Table
CREATE TABLE rental_services (
	ren_id CHAR(5) NOT NULL,
    decor BOOLEAN NOT NULL,
    heating BOOLEAN NOT NULL,
    lighting BOOLEAN NOT NULL,
    linen BOOLEAN NOT NULL,
    lounge BOOLEAN NOT NULL,
    restroom BOOLEAN NOT NULL,
    shade BOOLEAN NOT NULL,
    speaker BOOLEAN NOT NULL,
    stage BOOLEAN NOT NULL,
    table_chair BOOLEAN NOT NULL,
    tableware BOOLEAN NOT NULL,
    tent BOOLEAN NOT NULL,
    PRIMARY KEY (ren_id),
    FOREIGN KEY (ren_id) REFERENCES vendors(vendor_id)
);

-- cake_services Table
CREATE TABLE cake_services (
    cak_id CHAR(5) NOT NULL,
    buffet_style BOOLEAN NOT NULL,
    cake_accessories BOOLEAN NOT NULL,
    cake_cutting_and_serving BOOLEAN NOT NULL,
    cake_delivery_and_setup BOOLEAN NOT NULL,
    cake_serving_sets BOOLEAN NOT NULL,
    cake_stands BOOLEAN NOT NULL,
    cake_table_decorations BOOLEAN NOT NULL,
    cake_tastings BOOLEAN NOT NULL,
    cake_toppers BOOLEAN NOT NULL,
    consultations BOOLEAN NOT NULL,
    cupcakes BOOLEAN NOT NULL,
    custom_orders BOOLEAN NOT NULL,
    groom_cakes BOOLEAN NOT NULL,
    other_desserts BOOLEAN NOT NULL,
    PRIMARY KEY(cak_id),
    FOREIGN KEY(cak_id) REFERENCES vendors(vendor_id)
);

-- cakes Table
CREATE TABLE cakes (
    cak_id CHAR(5) NOT NULL,
    almond BOOL NOT NULL,
    apple BOOL NOT NULL,
    carrot BOOL NOT NULL,
    champagne BOOL NOT NULL,
    cheese BOOL NOT NULL,
    chocolate BOOL NOT NULL,
    clementine BOOL NOT NULL,
    faux_display BOOL NOT NULL,
    fruit BOOL NOT NULL,
    lemon BOOL NOT NULL,
    red_velvet BOOL NOT NULL,
    sculpture BOOL NOT NULL,
    tower BOOL NOT NULL,
    vanilla BOOL NOT NULL,
    white BOOL NOT NULL,
    PRIMARY KEY(cak_id),
    FOREIGN KEY(cak_id) REFERENCES vendors(vendor_id)
);

-- diets Table
CREATE TABLE diets (
    diet_id CHAR(5) NOT NULL,
    dairy_free BOOL NOT NULL,
    gluten_free BOOL NOT NULL,
    halal BOOL NOT NULL,
    keto BOOL NOT NULL,
    kosher BOOL NOT NULL,
    nut_free BOOL NOT NULL,
    organic BOOL NOT NULL,
    spicy_cube BOOL NOT NULL,
    sugar_free BOOL NOT NULL,
    vegan BOOL NOT NULL,
    vegetarian BOOL NOT NULL,
    PRIMARY KEY(diet_id),
    FOREIGN KEY(diet_id) REFERENCES vendors(vendor_id)
);

-- invitations Table
CREATE TABLE invitations (
    inv_id CHAR(5) NOT NULL,
    min_quantity INT(5),
    PRIMARY KEY (inv_id),
    FOREIGN KEY (inv_id) REFERENCES vendors(vendor_id)
);

-- venues Table
CREATE TABLE venues(
	ven_id CHAR(5) NOT NULL,
	ballroom BOOL NOT NULL,
	barn BOOL NOT NULL,
	club_house BOOL NOT NULL,
	country_club BOOL NOT NULL,
	gallery BOOL NOT NULL,
	garden BOOL NOT NULL,
	golf_club BOOL NOT NULL,
	hotel BOOL NOT NULL,
	mansion BOOL NOT NULL,
	museum BOOL NOT NULL,
	private_club BOOL NOT NULL,
	private_estate BOOL NOT NULL,
	terrace BOOL NOT NULL,
	winery BOOL NOT NULL,
    PRIMARY KEY(ven_id),
    FOREIGN KEY(ven_id) REFERENCES vendors(vendor_id)
);

-- venue_capacities Table
CREATE TABLE venue_capacities (
	ven_id CHAR(5) NOT NULL,
    capacity INT(5),
    PRIMARY KEY(ven_id),
    FOREIGN KEY(ven_id) REFERENCES vendors(vendor_id)
);

-- venue_location Table
CREATE TABLE venue_locations (
    ven_id CHAR(5) NOT NULL,
    indoor BOOLEAN NOT NULL,
    outdoor BOOLEAN NOT NULL,
    PRIMARY KEY(ven_id),
    FOREIGN KEY (ven_id) REFERENCES vendors(vendor_id)
);

-- INSERT INTO departments (function_id, functions) VALUES 
INSERT INTO departments (function_id, functions) VALUES ('01', 'flowers');
INSERT INTO departments (function_id, functions) VALUES ('02', 'venues');
INSERT INTO departments (function_id, functions) VALUES ('03', 'music');
INSERT INTO departments (function_id, functions) VALUES ('04', 'jewelry');
INSERT INTO departments (function_id, functions) VALUES ('05', 'photo and video');
INSERT INTO departments (function_id, functions) VALUES ('06', 'hair and makeup');
INSERT INTO departments (function_id, functions) VALUES ('07', 'dress atire');
INSERT INTO departments (function_id, functions) VALUES ('08', 'catering');
INSERT INTO departments (function_id, functions) VALUES ('09', 'rentals');
INSERT INTO departments (function_id, functions) VALUES ('10', 'invitations');
INSERT INTO departments (function_id, functions) VALUES ('11', 'cake');
INSERT INTO departments (function_id, functions) VALUES ('12', 'wedding planners');

-- filling prices table
INSERT INTO prices (price_id, affordability) VALUES 
('1', 'inexpensive'),
('2', 'affordable'),
('3', 'moderate'),
('4', 'luxury');

-- filling cities
INSERT INTO cities VALUES ('city00', '');	
INSERT INTO cities VALUES ('city01', 'acampo');
INSERT INTO cities VALUES ('city02', 'alameda');
INSERT INTO cities VALUES ('city03', 'alamo');
INSERT INTO cities VALUES ('city04', 'antioch');
INSERT INTO cities VALUES ('city05', 'berkeley');
INSERT INTO cities VALUES ('city06', 'brentwood');
INSERT INTO cities VALUES ('city07', 'brisbane');
INSERT INTO cities VALUES ('city08', 'burlingame');
INSERT INTO cities VALUES ('city09', 'campbell');
INSERT INTO cities VALUES ('city10', 'castro calley');
INSERT INTO cities VALUES ('city11', 'concord');
INSERT INTO cities VALUES ('city12', 'contra costa');
INSERT INTO cities VALUES ('city13', 'cupertino');
INSERT INTO cities VALUES ('city14', 'daly city');
INSERT INTO cities VALUES ('city15', 'danville');
INSERT INTO cities VALUES ('city16', 'dublin');
INSERT INTO cities VALUES ('city17', 'emeryville');
INSERT INTO cities VALUES ('city18', 'fairfax');
INSERT INTO cities VALUES ('city19', 'foresthill');
INSERT INTO cities VALUES ('city20', 'fremont');
INSERT INTO cities VALUES ('city21', 'gilroy');
INSERT INTO cities VALUES ('city22', 'half moon bay');
INSERT INTO cities VALUES ('city23', 'harbor village');
INSERT INTO cities VALUES ('city24', 'hayward');
INSERT INTO cities VALUES ('city25', 'hollister');
INSERT INTO cities VALUES ('city26', 'la honda');
INSERT INTO cities VALUES ('city27', 'lafayette');
INSERT INTO cities VALUES ('city28', 'lakeshore');
INSERT INTO cities VALUES ('city29', 'livermore');
INSERT INTO cities VALUES ('city30', 'los altos');
INSERT INTO cities VALUES ('city31', 'los gatos');
INSERT INTO cities VALUES ('city32', 'marin');
INSERT INTO cities VALUES ('city33', 'martinez');
INSERT INTO cities VALUES ('city34', 'menlo park');
INSERT INTO cities VALUES ('city35', 'millbrae');
INSERT INTO cities VALUES ('city36', 'milpitas');
INSERT INTO cities VALUES ('city37', 'modesto');
INSERT INTO cities VALUES ('city38', 'monterey');
INSERT INTO cities VALUES ('city39', 'mountain view');
INSERT INTO cities VALUES ('city40', 'napa');
INSERT INTO cities VALUES ('city41', 'newark');
INSERT INTO cities VALUES ('city42', 'nicasio');
INSERT INTO cities VALUES ('city43', 'north oakland');
INSERT INTO cities VALUES ('city44', 'novato');
INSERT INTO cities VALUES ('city45', 'oakland');
INSERT INTO cities VALUES ('city46', 'pacifica');
INSERT INTO cities VALUES ('city47', 'palo alto');
INSERT INTO cities VALUES ('city48', 'pinole');
INSERT INTO cities VALUES ('city49', 'pittsburg');
INSERT INTO cities VALUES ('city50', 'pleasant hill');
INSERT INTO cities VALUES ('city51', 'pleasanton');
INSERT INTO cities VALUES ('city52', 'redwood');
INSERT INTO cities VALUES ('city53', 'roseville');
INSERT INTO cities VALUES ('city54', 'san bruno');
INSERT INTO cities VALUES ('city55', 'san carlos');
INSERT INTO cities VALUES ('city56', 'san francisco');
INSERT INTO cities VALUES ('city57', 'san jose');
INSERT INTO cities VALUES ('city58', 'san leandro');
INSERT INTO cities VALUES ('city59', 'san mateo');
INSERT INTO cities VALUES ('city60', 'san pablo');
INSERT INTO cities VALUES ('city61', 'san rafael');
INSERT INTO cities VALUES ('city62', 'san ramon');
INSERT INTO cities VALUES ('city63', 'santa clara');
INSERT INTO cities VALUES ('city64', 'santa rosa');
INSERT INTO cities VALUES ('city65', 'saratoga');
INSERT INTO cities VALUES ('city66', 'sausalito');
INSERT INTO cities VALUES ('city67', 'solana beach');
INSERT INTO cities VALUES ('city68', 'sonoma');
INSERT INTO cities VALUES ('city69', 'sunnyvale');
INSERT INTO cities VALUES ('city70', 'sunol');
INSERT INTO cities VALUES ('city71', 'telegraph hill');
INSERT INTO cities VALUES ('city72', 'walnut creek');
INSERT INTO cities VALUES ('city73', 'winters');
INSERT INTO cities VALUES ('city74', 'woodside');

-- Filling vendors table
INSERT INTO vendors (vendor_id, function_id, vendor, city_id, price_id, reviews, avg_stars) VALUES
('flo01', '01', 'dannas flowers', 'city22', '2', 89, 3.9),
('flo02', '01', 'the flower girl', 'city20', '2', 55, 4.2),
('flo03', '01', 'finer flora', 'city19', '2', 39, 4.2),
('flo04', '01', 'the botany shop florist', 'city18', '2', 54, 4.2),
('flo05', '01', 'fresh ideas flower cmpany', 'city37', '2', 98, 4.4),
('flo06', '01', 'edmond’s plaza floris', 'city19', '2', 291, 4.3),
('flo07', '01', 'wisteria rockbridge', 'city03', '2', 73, 4.5),
('flo08', '01', 'jorys flowers', 'city11', '2', 244, 4.3),
('flo09', '01', 'petals by cary', 'city11', '2', 34, 4.9),
('flo10', '01', 'fresh petals', 'city33', '1', 32, 5.0),
('flo11', '01', 'the love stop 2', 'city45', '2', 11, 4.6),
('flo12', '01', 'fringe flower cmpany', 'city26', '3', 65, 4.7),
('flo13', '01', 'pico soriano designs', 'city04', '2', 40, 5.0),
('flo14', '01', 'dandelion flowers', 'city02', '2', 203, 4.7),
('flo15', '01', 'nikkibana floral design', 'city22', '2', 64, 4.9),
('flo16', '01', 'belle- flower', 'city17', '2', 79, 5.0),
('flo17', '01', 'utsuwa floral design', 'city03', '2', 328, 5.0),
('flo18', '01', 'anns petals', 'city03', '2', 418, 4.9),
('flo19', '01', 'half moon flowers', 'city22', '2', 38, 4.9),
('flo20', '01', 'apple blossom florist', 'city45', '2', 113, 4.6),
('flo21', '01', 'petals and decor', 'city56', '2', 162, 4.8),
('flo22', '01', 'the floral loft', 'city56', '2', 132, 4.8),
('flo23', '01', 'stanford floral design', 'city47', '2', 135, 4.8),
('flo24', '01', 'flowers by sophia', 'city10', '2', 220, 4.7),
('flo25', '01', 'my wedding sense', 'city20', '2', 24, 5.0),
('flo26', '01', 'huyen flowers', 'city24', '2', 39, 5.0),
('flo27', '01', 'flowers by myrna', 'city45', '2', 63, 4.8),
('flo28', '01', 'urban flora', 'city57', '1', 319, 4.7),
('flo29', '01', 'flowers by janet', 'city57', '1', 149, 4.9),
('flo30', '01', 'vo floral design', 'city58', '2', 131, 4.7),
('flo31', '01', 'brother and sisters flower shop', 'city45', '2', 91, 4.7),
('flo32', '01', 'dream flowers', 'city58', '2', 137, 4.9),
('ven01', '02', 'viaggio estate and winery', 'city01', '1', 22, 4.1),
('ven02', '02', 'fort mason center for arts and culture', 'city56', '1', 17, 4.5),
('ven03', '02', 'curdiodyssey', 'city59', '1', 12, 4.9),
('ven04', '02', 'golden gate club at the presidio', 'city56', '2', 11, 4.5),
('ven05', '02', 'the terrace room at lake merritt', 'city45', '2', 32, 4.9),
('ven06', '02', 'the university club of san francisco', 'city56', '2', 51, 5.0),
('ven07', '02', 'doubletree by hilton hotel berkley marina', 'city05', '2', 20, 4.8),
('ven08', '02', 'chabot space and science center', 'city45', '2', 30, 5.0),
('ven09', '02', 'nella terra cellars', 'city70', '2', 105, 4.9),
('ven10', '02', 'eagle ridge by wedgewood weddings', 'city21', '2', 87, 4.8),
('ven11', '02', 'the mountain terrace', 'city74', '2', 55, 4.6),
('ven12', '02', 'stonetree by wedgewood', 'city44', '2', 53, 4.9),
('ven13', '02', 'the ranch at silvercreek by wedgewood weddings', 'city57', '2', 28, 3.9),
('ven14', '02', 'léal vineyards', 'city25', '2', 24, 4.8),
('ven15', '02', 'rancho nicasio', 'city42', '2', 71, 5.0),
('ven16', '02', 'the bridges golf club', 'city62', '3', 93, 4.8),
('ven17', '02', 'the westin st francis san francisco on union square', 'city56', '3', 77, 5.0),
('ven18', '02', 'the club at ruby hill', 'city51', '3', 108, 4.8),
('ven19', '02', 'the bridges golf club', 'city62', '2', 93, 4.8),
('ven20', '02', 'palm event center in the vineyard', 'city51', '3', 78, 4.9),
('ven21', '02', 'lomas santa fe country club', 'city67', '3', 75, 5.0),
('ven22', '02', 'casa real at ruby hill winery', 'city51', '3', 59, 5.0),
('ven23', '02', 'stemple creek ranch', 'city32', '3', 10, 5.0),
('ven24', '02', 'nestldown', 'city31', '3', 58, 4.5),
('ven25', '02', 'purple orchid wine resort and spa', 'city29', '3', 18, 4.6),
('ven26', '02', 'argonaut hotel', 'city56', '3', 18, 4.9),
('ven27', '02', 'monte verde inn', 'city19', '3', 51, 4.8),
('ven28', '02', 'park winters', 'city73', '3', 41, 5.0),
('ven29', '02', 'club los meganos', 'city06', '3', 30, 4.9),
('ven30', '02', 'villa montalvo at the montalvo arts center', 'city65', '4', 26, 4.6),
('ven31', '02', 'deer park villa', 'city18', '4', 31, 4.6),
('ven32', '02', 'exploratorium', 'city56', '4', 12, 5.0),
('ven33', '02', 'the mountain winery', 'city65', '4', 10, 4.3),
('mus01', '03', 'lucky devils band', 'city51', '2', 287, 4.9),
('mus02', '03', 'elite entertainment', 'city51', '3', 150, 4.8),
('mus03', '03', 'vyby society', 'city51', '2', 127, 5.0),
('mus04', '03', 'ceremony djs', 'city51', '4', 106, 5.0),
('mus05', '03', 'verducci event productions', 'city05', '3', 106, 4.9),
('mus06', '03', 'mark addington events', 'city67', '2', 104, 5.0),
('mus07', '03', 'twin spin entertainment', 'city14', '3', 77, 5.0),
('mus08', '03', 'sf deejays', 'city14', '2', 70, 5.0),
('mus09', '03', 'quantum party productions', 'city51', '2', 70, 4.7),
('mus10', '03', 'the celebration dj', 'city51', '2', 68, 5.0),
('mus11', '03', 'bluedge productions', 'city51', '3', 63, 5.0),
('mus12', '03', 'sounds elevated', 'city51', '3', 62, 5.0),
('mus13', '03', 'retro jukebox band', 'city05', '2', 60, 5.0),
('mus14', '03', 'cover me badd', 'city26', '2', 60, 5.0),
('mus15', '03', 'on the beat', 'city51', '3', 50, 5.0),
('mus16', '03', 'fog city entertainment', 'city51', '2', 50, 4.9),
('mus17', '03', 'the cosmo alleycats -a dance band with a vintage twist!', 'city05', '2', 47, 5.0),
('mus18', '03', 'pop rocks', 'city51', '3', 47, 5.0),
('mus19', '03', 'notorious', 'city51', '2', 45, 5.0),
('mus20', '03', 'dj jeremy productions', 'city51', '3', 45, 4.9),
('mus21', '03', 'hella fitzgerald', 'city51', '3', 41, 4.9),
('mus22', '03', 'bay area beats dj', 'city51', '3', 41, 4.9),
('mus23', '03', 'alan waltz entertainment', 'city51', '3', 36, 4.9),
('mus24', '03', 'pantera event productions', 'city51', '2', 35, 5.0),
('mus25', '03', 'mercy and the heartbeats', 'city51', '2', 33, 5.0),
('mus26', '03', 'cartwrights dj services', 'city51', '2', 33, 5.0),
('mus27', '03', 'boutique djs', 'city51', '3', 33, 4.8),
('mus28', '03', 'wonder bread 5', 'city51', '3', 32, 5.0),
('mus29', '03', 'honey of the heart and soul graffiti entertainment', 'city51', '2', 32, 5.0),
('mus30', '03', 'dream entertainment', 'city51', '2', 32, 5.0),
('mus31', '03', 'ivy hill entertainment', 'city41', '3', 28, 4.8),
('mus32', '03', 'w square event production', 'city51', '4', 28, 5.0),
('mus33', '03', 'los gatos dj cmpany', 'city28', '4', 28, 5.0),
('mus34', '03', 'the cheeseballs', 'city51', '3', 27, 5.0),
('mus35', '03', 'audio ecstasy event sound and lighting', 'city51', '2', 26, 5.0),
('mus36', '03', 'bell and co', 'city51', '3', 25, 5.0),
('mus37', '03', 'classic vybe', 'city51', '3', 23, 5.0),
('mus38', '03', 'rdm entertainment', 'city41', '2', 21, 4.5),
('mus39', '03', 'hip entertainment and events', 'city51', '3', 19, 5.0),
('mus40', '03', 'dj big cali llc', 'city41', '3', 19, 5.0),
('mus41', '03', 'radio gatsby', 'city51', '3', 18, 5.0),
('mus42', '03', 'lori carsillo jazz vocalist and ensemble', 'city51', '2', 18, 5.0),
('mus43', '03', 'mark welch entertainment', 'city30', '3', 18, 4.8),
('mus44', '03', 'the freshmakers band', 'city51', '2', 16, 5.0),
('mus45', '03', 'the klipptones', 'city51', '2', 16, 5.0),
('mus46', '03', 'spotlight occasions', 'city10', '1', 15, 4.9),
('mus47', '03', 'bay area goodtime wedding djs', 'city51', '2', 14, 4.9),
('mus48', '03', 'harpist krista strader', 'city51', '3', 13, 5.0),
('mus49', '03', 'synchonicity strings', 'city51', '3', 11, 4.7),
('mus50', '03', 'amethyst trio', 'city51', '2', 10, 5.0),
('jwl01', '04', 'derco fine jewelers', 'city56', '2', 1046, 4.8),
('jwl02', '04', 'brilliant earth', 'city56', '3', 1007, 4.2),
('jwl03', '04', 'geoffreys diamonds and goldsmith', 'city55', '2', 718, 4.9),
('jwl04', '04', 'shane co walnutcreek01', 'city72', '2', 520, 4.2),
('jwl05', '04', 'yadav diamonds and jewelry', 'city56', '2', 391, 4.8),
('jwl06', '04', 'la bijouterie', 'city56', '3', 312, 4.9),
('jwl07', '04', 'barons', 'city16', '3', 270, 4.8),
('jwl08', '04', 'appelblom jewelry', 'city59', '2', 259, 4.9),
('jwl09', '04', 'just bands', 'city56', '2', 210, 4.9),
('jwl10', '04', 'oaks jewelry', 'city05', '2', 208, 4.8),
('jwl11', '04', 'shane co cupertino01', 'city13', '2', 743, 4.3),
('jwl12', '04', 'shane co sanmateo01', 'city59', '2', 329, 4.3),
('jwl13', '04', 'design jewelers', 'city56', '2', 323, 5.0),
('jwl14', '04', 'heller jewelers', 'city62', '3', 240, 4.5),
('jwl15', '04', 'pavé fine jewelry', 'city45', '3', 190, 4.6),
('jwl16', '04', 'spitz jewelers', 'city45', '3', 166, 4.4),
('jwl17', '04', 'vardys jewelers', 'city13', '2', 430, 4.8),
('jwl18', '04', 'newark jewelry center', 'city41', '2', 356, 4.9),
('jwl19', '04', 'neil dahl jewelers of california', 'city34', '2', 288, 4.7),
('jwl20', '04', 'sausalito jewelers', 'city66', '3', 109, 5.0),
('jwl21', '04', 'willow glen diamond cmpany', 'city57', '2', 258, 4.8),
('jwl22', '04', 'joe escobar', 'city09', '3', 446, 4.7),
('jwl23', '04', 'jin wang', 'city56', '3', 277, 4.7),
('jwl24', '04', 'topper fines jewelry', 'city08', '3', 232, 4.7),
('jwl25', '04', 'the love of ganesha', 'city56', '1', 455, 4.9),
('jwl26', '04', 'master fix jewelers', 'city09', '1', 342, 4.8),
('jwl27', '04', 'general bead', 'city56', '1', 221, 3.9),
('jwl28', '04', 'louis vuitton bloomingdales santa clara', 'city57', '4', 677, 2.7),
('jwl29', '04', 'tiffany and co', 'city56', '4', 384, 3.5),
('jwl30', '04', 'chanel', 'city56', '4', 358, 3.5),
('pho01', '05', 'of his fold photography', 'city11', '2', 10, 5.0),
('pho02', '05', 'michaels wedding group', 'city13', '1', 16, 4.9),
('pho03', '05', 'kates captures photography', 'city14', '3', 65, 5.0),
('pho04', '05', 'photostm bay area photography', 'city20', '2', 12, 4.9),
('pho05', '05', 'julia rose photography', 'city24', '2', 14, 5.0),
('pho06', '05', 'megan trant photography', 'city29', '2', 13, 5.0),
('pho07', '05', 'adeline and grace photography', 'city40', '3', 53, 5.0),
('pho08', '05', 'kat ma photography', 'city45', '3', 112, 4.9),
('pho09', '05', 'joss li photo', 'city54', '2', 11, 5.0),
('pho10', '05', 'george street photo and video', 'city56', '1', 2610, 4.3),
('pho11', '05', 'duy ho photography', 'city56', '3', 75, 5.0),
('pho12', '05', 'home for brides wedding photography', 'city56', '1', 174, 5.0),
('pho13', '05', 'alexis exstrom photography', 'city56', '2', 19, 5.0),
('pho14', '05', 'anne-claire brun', 'city56', '2', 35, 5.0),
('pho15', '05', 'tyler vu photography', 'city57', '3', 33, 5.0),
('pho16', '05', 'imanstudiosnet', 'city57', '2', 10, 5.0),
('pho17', '05', 'tanya and victor', 'city61', '2', 13, 5.0),
('pho18', '05', 'martha hoang photography', 'city63', '3', 16, 5.0),
('pho19', '05', 'delumpa photography', 'city56', '3', 48, 5.0),
('pho20', '05', 'alice che photography', 'city69', '4', 16, 5.0),
('pho21', '05', 'meg sexton photography', 'city72', '2', 5, 5.0),
('pho22', '05', 'badger zhou photography', 'city59', '1', 20, 4.9),
('pho23', '05', 'matthew tw huang photography', 'city47', '2', 3, 5.0),
('pho24', '05', 'brad and rachel photography', 'city52', '2', 6, 5.0),
('pho25', '05', 'jessamyn photography', 'city50', '3', 7, 5.0),
('pho26', '05', 'wing hon films', 'city14', '1', 5, 4.0),
('pho27', '05', 'thournir productions', 'city29', '2', 9, 5.0),
('pho28', '05', 'inventive films', 'city40', '1', 46, 5.0),
('pho29', '05', 'life in digital', 'city45', '2', 8, 5.0),
('pho30', '05', 'drake and evan wedding films', 'city56', '1', 10, 5.0),
('pho31', '05', 'lux films', 'city56', '1', 16, 5.0),
('pho32', '05', 'iq videography', 'city56', '2', 26, 5.0),
('pho33', '05', 'cinematt', 'city56', '2', 22, 5.0),
('pho34', '05', 'reb6studios', 'city56', '2', 26, 5.0),
('pho35', '05', 'dreambook productions', 'city56', '2', 12, 5.0),
('pho36', '05', 'boiling frog entertainment llc', 'city56', '4', 5, 5.0),
('pho37', '05', 'nice shot films', 'city56', '1', 32, 5.0),
('pho38', '05', 'owl and tree wedding films', 'city56', '2', 26, 5.0),
('pho39', '05', 'hit maker films', 'city56', '1', 11, 5.0),
('pho40', '05', 'zamora creative', 'city56', '1', 7, 5.0),
('pho41', '05', 'likefilmstudio', 'city56', '2', 11, 5.0),
('pho42', '05', 'ivory sky media', 'city57', '1', 15, 4.5),
('pho43', '05', 'sunset productions', 'city57', '1', 5, 5.0),
('pho44', '05', 'moradi studios', 'city59', '1', 6, 5.0),
('pho45', '05', 'video impressions', 'city69', '1', 21, 5.0),
('pho46', '05', 'creative life house', 'city72', '1', 5, 5.0),
('hai01', '06', 'glamour by kary li', 'city56', '2', 151, 4.8),
('hai02', '06', 'avital beauty lounge', 'city72', '2', 407, 4.8),
('hai03', '06', 'wowpretty', 'city08', '2', 393, 4.7),
('hai04', '06', 'bounce blowdry bar', 'city28', '2', 252, 3.9),
('hai05', '06', 'the traveling stylist', 'city05', '2', 201, 4.9),
('hai06', '06', 'arty', 'city56', '3', 377, 4.3),
('hai07', '06', 'beauty by roya', 'city20', '1', 23, 3.4),
('hai08', '06', 'makeup x michelle', 'city11', '3', 25, 4.6),
('hai09', '06', 'dreamcatcher artistry', 'city56', '4', 127, 5.0),
('hai10', '06', 'stylebee', 'city56', '2', 286, 4.6),
('hai11', '06', 'fresh face makeup', 'city56', '2', 154, 4.8),
('hai12', '06', 'skyla arts', 'city39', '4', 39, 4.8),
('hai13', '06', 'the makeup dolls', 'city59', '3', 76, 4.8),
('hai14', '06', 'the glam bar', 'city72', '3', 75, 4.8),
('hai15', '06', 'ashley pollard hair studio', 'city03', '1', 161, 4.9),
('hai16', '06', 'primp hair and makeup design', 'city08', '3', 75, 3.3),
('hai17', '06', 'chritina choi cosmetics', 'city56', '4', 73, 5.0),
('hai18', '06', 'beauty by pace', 'city10', '1', 70, 4.9),
('hai19', '06', 'leanne hair and makeup', 'city02', '2', 55, 5.0),
('hai20', '06', 'ninis ephiphany makeup and hair', 'city56', '2', 101, 5.0),
('hai21', '06', 'little mermaid hair and makeup', 'city60', '2', 72, 4.5),
('hai22', '06', 'the makeup movement', 'city16', '2', 55, 5.0),
('hai23', '06', 'mari marry', 'city56', '2', 54, 4.9),
('hai24', '06', 'makeup and hairs by ps', 'city69', '3', 51, 5.0),
('hai25', '06', 'makeup by krystal kim', 'city59', '2', 49, 5.0),
('hai26', '06', 'beauty by maile', 'city14', '2', 46, 5.0),
('hai27', '06', 'hair and makeup by karina', 'city29', '2', 40, 4.8),
('hai28', '06', 'amanda j artistry', 'city11', '2', 39, 4.9),
('hai29', '06', 's studios', 'city56', '2', 169, 5.0),
('hai30', '06', 'beyond beauty', 'city45', '2', 46, 4.7),
('hai31', '06', 'the glamour room', 'city40', '2', 34, 4.8),
('hai32', '06', 'blowology dry bar and spa', 'city56', '2', 238, 4.6),
('hai33', '06', 'aqua beauty lounge', 'city23', '2', 117, 4.7),
('hai34', '06', 'glammface', 'city52', '2', 4108, 4.8),
('hai35', '06', 'glam and glow', 'city48', '2', 103, 4.9),
('hai36', '06', 'a-list makeup', 'city36', '2', 1188, 4.9),
('hai37', '06', '77 salon', 'city43', '2', 306, 4.6),
('hai38', '06', 'reign salon', 'city04', '2', 93, 4.7),
('hai39', '06', 'salon one', 'city02', '2', 406, 4.3),
('hai40', '06', 'bay area beautiful', 'city29', '2', 178, 5.0),
('hai41', '06', 'tamara-marie rtistry', 'city45', '2', 106, 4.8),
('dre01', '07', 'marina morrison', 'city02', '4', 215, 4.4),
('dre02', '07', 'franco masoma bespoke', 'city02', '3', 217, 4.0),
('dre03', '07', 'fabiola quinceaneras', 'city11', '2', 33, 5.0),
('dre04', '07', 'gesinee 2350', 'city11', '2', 34, 1.9),
('dre05', '07', 'le caprice', 'city13', '2', 290, 3.4),
('dre06', '07', 'nouvelle vogue', 'city14', '3', 109, 4.9),
('dre07', '07', 'joanna bridal boutique', 'city15', '2', 134, 4.4),
('dre08', '07', 'pearl white wedding', 'city20', '2', 63, 4.3),
('dre09', '07', 'garnet and grace bridal boutique', 'city24', '2', 422, 4.3),
('dre10', '07', 'las bonitas fashions', 'city24', '2', 86, 4.8),
('dre11', '07', 'bride and bustle', 'city31', '3', 36, 4.5),
('dre12', '07', 'in the olde manner', 'city31', '3', 57, 3.6),
('dre13', '07', 'anthropologie weddings', 'city34', '2', 109, 4.3),
('dre14', '07', 'bolee bridal couture', 'city34', '2', 559, 4.0),
('dre15', '07', 'camille la vie', 'city36', '2', 127, 4.8),
('dre16', '07', 'tuxedo wearhouse', 'city36', '2', 548, 3.2),
('dre17', '07', 'emerald city gowns', 'city45', '2', 274, 4.7),
('dre18', '07', 'kinsley james couture bridal', 'city45', '3', 222, 4.6),
('dre19', '07', 'lilac', 'city45', '2', 109, 4.8),
('dre20', '07', 'elegance preserved', 'city47', '3', 119, 4.9),
('dre21', '07', 'halena couture', 'city47', '1', 88, 4.9),
('dre22', '07', 'men warehouse', 'city50', '2', 167, 5.0),
('dre23', '07', 'janene bridal boutique', 'city52', '2', 1000, 3.2),
('dre24', '07', 'jc bridal boutique', 'city52', '2', 60, 4.8),
('dre25', '07', 'linda ayre', 'city54', '3', 7, 4.9),
('dre26', '07', 'tina bridal and creations', 'city54', '1', 10, 5.0),
('dre27', '07', 'rin bridal', 'city55', '2', 333, 2.8),
('dre28', '07', 'novella bridal', 'city56', '1', 433, 4.1),
('dre29', '07', 'lace and liberty', 'city56', '2', 198, 4.5),
('dre30', '07', 'sarah seven', 'city56', '3', 160, 4.8),
('dre31', '07', 'glamour closet', 'city56', '2', 499, 4.6),
('dre32', '07', 'ao dai bao han', 'city57', '2', 422, 4.2),
('dre33', '07', 'bridal gown studio', 'city57', '2', 237, 4.9),
('dre34', '07', 'queen bridals', 'city57', '2', 87, 4.7),
('dre35', '07', 'trudys bridges and special occasions', 'city57', '3', 1700, 4.2),
('dre36', '07', 'designs by fanny', 'city59', '2', 67, 3.9),
('dre37', '07', 'perfect details', 'city59', '3', 39, 4.8),
('dre38', '07', 'nelly bridal boutique', 'city56', '2', 233, 4.2),
('dre39', '07', 'tina bridal and creations', 'city56', '1', 10, 4.6),
('dre40', '07', 'flares bridal', 'city72', '2', 1185, 2.8),
('cat01', '08', 'trattoria da vittorio', 'city56', '2', 958, 4.4),
('cat02', '08', 'kitchenina', 'city56', '2', 78, 4.3),
('cat03', '08', 'bliss pops', 'city56', '2', 153, 4.9),
('cat04', '08', 'fogcutter', 'city56', '3', 57, 5.0),
('cat05', '08', 'classic culinaire', 'city68', '3', 84, 5.0),
('cat06', '08', 'wilma lott catering', 'city68', '3', 90, 4.9),
('cat07', '08', 'evntwrks', 'city02', '3', 59, 5.0),
('cat08', '08', 'taste catering and event planning', 'city59', '4', 48, 4.4),
('cat09', '08', 'diamond cut catering', 'city02', '2', 20, 4.7),
('cat10', '08', 'far out catering', 'city56', '2', 32, 3.9),
('cat11', '08', 'hurias woodfired catering', 'city68', '2', 98, 4.9),
('cat12', '08', 'preferred sonoma catering', 'city68', '2', 144, 4.6),
('cat13', '08', 'carvery catering', 'city56', '2', 41, 5.0),
('cat14', '08', 'marks the spot fine food', 'city40', '3', 80, 4.6),
('cat15', '08', 'a fork full of earth organic catering', 'city56', '3', 62, 4.8),
('cat16', '08', 'blue heron catering', 'city02', '3', 58, 5.0),
('cat17', '08', 'park avenue catering', 'city40', '2', 276, 4.6),
('cat18', '08', 'all seasons catering', 'city32', '2', 42, 4.8),
('cat19', '08', 'elaine bell catering', 'city68', '3', 134, 4.8),
('cat20', '08', 'elegant occasions catering and event planning', 'city12', '2', 111, 4.6),
('cat21', '08', 'famous creations', 'city68', '2', 228, 4.9),
('cat22', '08', 'culinary excellence', 'city02', '3', 223, 4.4),
('cat23', '08', 'total wine and more', 'city02', '2', 197, 4.9),
('cat24', '08', 'carrie dove catering and events', 'city02', '3', 195, 3.8),
('cat25', '08', 'fraiche catering', 'city56', '2', 58, 4.9),
('cat26', '08', 'liberation foods', 'city02', '3', 2, 4.8),
('cat27', '08', 'miraglia catering and event planning', 'city02', '3', 143, 2.5),
('cat28', '08', 'on the vine catering', 'city02', '2', 62, 4.7),
('cat29', '08', 'wylder space inc', 'city56', '3', 67, 4.8),
('cat30', '08', 'mccalls catering and events', 'city56', '3', 54, 4.4),
('cat31', '08', 'miller and lux', 'city56', '4', 301, 4.4),
('cat32', '08', 'steel smokin bbq catering', 'city12', '1', 62, 4.2),
('cat33', '08', 'slider shack', 'city56', '1', 144, 4.6),
('ren01', '09', 'pleasanton rentals inc', 'city29', '3', 134, 4.1),
('ren02', '09', 'celebrations! party rentals', 'city53', '2', 108, 4.1),
('ren03', '09', 'kona linen and decors', 'city56', '1', 10, 4.5),
('ren04', '09', 'archive rentals', 'city56', '2', 5, 5.0),
('ren05', '09', 'hernandez party rentals', 'city56', '1', 24, 5.0),
('ren06', '09', 'events by the bay', 'city56', '2', 11, 4.3),
('ren07', '09', 'bright event rentals', 'city07', '3', 13, 4.3),
('ren08', '09', 'kelsweet event rentals', 'city71', '1', 44, 2.9),
('ren09', '09', 'abbey party rentals', 'city14', '2', 150, 4.9),
('ren10', '09', 'peak productions event tent rentals', 'city36', '3', 8, 3.9),
('ren11', '09', 'quantum party productions', 'city56', '3', 10, 4.9),
('ren12', '09', 'all seasons event rentals', 'city52', '2', 40, 4.2),
('ren13', '09', 'icelebrate event rentals', 'city57', '2', 354, 4.7),
('ren14', '09', 'stuart event rentals', 'city36', '2', 219, 4.8),
('ren15', '09', 'chairs for affairs', 'city11', '2', 123, 4.5),
('ren16', '09', 'celebrations party equipment', 'city24', '3', 108, 4.8),
('ren17', '09', 'gagnons party rentals', 'city27', '1', 106, 4.7),
('ren18', '09', 'am party rentals', 'city58', '1', 96, 4.9),
('ren19', '09', 'eyc rentals', 'city45', '1', 95, 4.7),
('ren20', '09', 'event magic', 'city45', '1', 83, 4.8),
('ren21', '09', 'prime party rentals', 'city24', '3', 75, 4.5),
('ren22', '09', 'got light', 'city56', '3', 74, 4.3),
('ren23', '09', 'fantasy sound event services', 'city29', '3', 134, 4.7),
('ren24', '09', 'c and m party', 'city11', '1', 88, 4.7),
('ren25', '09', 'fine linen creation', 'city09', '1', 81, 4.0),
('ren26', '09', 'mom chairs', 'city56', '1', 125, 4.7),
('ren27', '09', 'piedmont party rentals', 'city45', '2', 114, 4.1),
('ren28', '09', 'unica party rentals', 'city55', '2', 62, 4.4),
('ren29', '09', 'chic event rentals', 'city38', '3', 55, 4.7),
('ren30', '09', 'seventh heaven vintage rentals', 'city20', '3', 37, 4.8),
('inv01', '10', 'psprint', 'city45', '3', 378, 4.9),
('inv02', '10', 'mikes camera dublin', 'city16', '1', 327, 3.4),
('inv03', '10', 'mikes camera menlo park', 'city34', '1', 234, 4.6),
('inv04', '10', 'hyegraph invitations and calligraphy', 'city56', '4', 226, 4.3),
('inv05', '10', 'fedex office print and ship center', 'city56', '2', 217, 4.8),
('inv06', '10', 'pine press printing binding and copying', 'city69', '3', 211, 2.5),
('inv07', '10', 'mikes camera pleasant hill', 'city50', '1', 182, 4.9),
('inv08', '10', 'fedex office print and ship center', 'city56', '2', 170, 4.2),
('inv09', '10', 'fedex office print and ship center', 'city57', '2', 161, 3.3),
('inv10', '10', 'fedex office print and ship center', 'city09', '2', 160, 2.4),
('inv11', '10', 'fedex office print and ship center', 'city63', '2', 127, 3.0),
('inv12', '10', 'coffee n cream press', 'city56', '4', 9, 2.4),
('inv13', '10', '123weddingcards', 'city52', '2', 19, 5.0),
('inv14', '10', 'minted', 'city56', '4', 2161, 4.6),
('inv15', '10', 'paper culture', 'city35', '3', 47, 4.5),
('inv16', '10', 'catprint', 'city56', '3', 345, 4.7),
('inv17', '10', 'jp stationery', 'city56', '4', 248, 4.9),
('inv18', '10', 'raoul martinez calligraphy', 'city56', '3', 12, 5.0),
('inv19', '10', 'gooseberry designs', 'city31', '1', 16, 5.0),
('inv20', '10', 'zazzle invitations', 'city52', '4', 1380, 4.9),
('inv21', '10', 'lemon leaf prints', 'city57', '2', 6, 4.7),
('inv22', '10', 'tknotes', 'city56', '1', 4, 5.0),
('inv23', '10', 'pro digital photos', 'city56', '1', 284, 5.0),
('inv24', '10', 'people ive loved', 'city45', '1', 8, 4.9),
('inv25', '10', 'reb peters press', 'city56', '4', 23, 5.0),
('inv26', '10', 'mercurio brothers', 'city05', '4', 15, 5.0),
('cak01', '11', 'charlies cheesecake works', 'city57', '1', 780, 4.7),
('cak02', '11', 'cream', 'city11', '1', 642, 4.8),
('cak03', '11', 'cake a bakin', 'city44', '1', 94, 3.7),
('cak04', '11', 'mitraartcake', 'city08', '2', 86, 4.8),
('cak05', '11', 'poore man bakery', 'city10', '2', 1, 4.8),
('cak06', '11', 'birdie bakery', 'city04', '2', 1, 5.0),
('cak07', '11', 'inticing creations', 'city49', '2', 75, 5.0),
('cak08', '11', 'tonys cakes', 'city64', '2', 268, 4.6),
('cak09', '11', 'camishas cakes', 'city47', '2', 22, 4.5),
('cak10', '11', 'the fortune cookie factory', 'city46', '2', 73, 5.0),
('cak11', '11', 'anas bakery', 'city46', '2', 304, 4.6),
('cak12', '11', 'cups and cakes bakery', 'city44', '2', 1, 4.3),
('cak13', '11', 'two chicks in the mix', 'city32', '2', 66, 5.0),
('cak14', '11', 'alexanders patisserie', 'city24', '2', 1313, 4.9),
('cak15', '11', 'fauxcakes by katie', 'city31', '2', 7, 3.9),
('cak16', '11', 'batch pastries', 'city28', '2', 110, 5.0),
('cak17', '11', 'gerhard michler fine european desserts', 'city37', '2', 80, 4.1),
('cak18', '11', '" le gateau elegang"', 'city54', '3', 223, 4.9),
('cak19', '11', '"renaissance specialty cakes and desserts "', 'city17', '3', 24, 4.2),
('cak20', '11', 'migoodies bakesale', 'city14', '3', 58, 4.8),
('cak21', '11', 'revelry cakes', 'city44', '3', 29, 5.0),
('cak22', '11', 'ashley nicole cakes', 'city35', '3', 4, 5.0),
('cak23', '11', 'live love bake', 'city36', '3', 23, 4.3),
('cak24', '11', 'marleys treats', 'city30', '3', 435, 4.9),
('cak25', '11', 'cake expressions', 'city36', '3', 309, 4.4),
('cak26', '11', 'daniel saravia cakes', 'city28', '3', 28, 4.6),
('cak27', '11', 'lemoon zest allergen savvy patisserie', 'city26', '3', 2, 5.0),
('cak28', '11', 'jens cakes', 'city26', '3', 420, 5.0),
('cak29', '11', 'sf candy bar', 'city08', '3', 39, 4.4),
('cak30', '11', 'dulce mia cakes', 'city04', '4', 9, 5.0),
('cak31', '11', 'elegant cheese cakes llc', 'city35', '4', 122, 5.0),
('wed01', '12', 'mooi weddings', 'city02', '1', 36, 4.7),
('wed02', '12', 'taylor rae weddings', 'city10', '3', 21, 5.0),
('wed03', '12', 'perfectly bubbly events', 'city20', '2', 37, 5.0),
('wed04', '12', 'simply lovely events', 'city29', '2', 47, 4.8),
('wed05', '12', 'a monique affair', 'city45', '4', 74, 5.0),
('wed06', '12', 'jl events', 'city45', '3', 63, 4.9),
('wed07', '12', 'events by martha', 'city45', '1', 30, 5.0),
('wed08', '12', 'leticias confections and events', 'city49', '1', 70, 5.0),
('wed09', '12', 'simply events', 'city50', '1', 16, 4.9),
('wed10', '12', 'allora event designs', 'city62', '2', 33, 5.0),
('wed11', '12', 'ar wedding n events', 'city72', '2', 26, 5.0),
('wed12', '12', 'sugar rush events', 'city72', '2', 27, 4.5),
('wed13', '12', 'your event by erin', 'city72', '3', 31, 5.0),
('wed14', '12', 'studio dbi', 'city56', '2', 64, 5.0),
('wed15', '12', 'mandy scott', 'city56', '4', 39, 5.0),
('wed16', '12', 'queens creative events', 'city56', '1', 27, 4.9),
('wed17', '12', 'ybarra events', 'city56', '3', 55, 4.9),
('wed18', '12', 'nicole taylor events', 'city56', '3', 20, 5.0),
('wed19', '12', 'hand heart weddings and events', 'city56', '1', 22, 5.0),
('wed20', '12', 'hitch perfect', 'city56', '2', 28, 5.0),
('wed21', '12', 'riley loves lulu', 'city56', '3', 37, 5.0),
('wed22', '12', 'swc consultants', 'city56', '1', 21, 5.0),
('wed23', '12', 'denise lillie engagements', 'city69', '4', 67, 4.7),
('wed24', '12', 'queens creative events', 'city69', '1', 27, 5.0),
('wed25', '12', 'entwine events', 'city63', '1', 29, 4.9),
('wed26', '12', 'two perfect events', 'city47', '3', 66, 5.0),
('wed27', '12', 'a day to remenber', 'city30', '2', 21, 5.0),
('wed28', '12', 'pili lani events', 'city59', '2', 26, 4.9),
('wed29', '12', '2 friends events', 'city57', '1', 20, 4.8),
('wed30', '12', 'amazae|events', 'city57', '3', 32, 5.0),
('wed31', '12', 'a cup of tea events', 'city57', '1', 20, 5.0),
('wed32', '12', 'signiture events by christina romero', 'city57', '3', 30, 5.0),
('wed33', '12', 'cc events', 'city40', '3', 42, 5.0),
('wed34', '12', 'off the beaten path weddings', 'city40', '2', 20, 5.0),
('wed35', '12', 'under the vine events', 'city40', '2', 23, 5.0),
('wed36', '12', 'sean dempsy and associates', 'city40', '1', 37, 5.0),
('wed37', '12', 'initmate weddings', 'city40', '3', 47, 5.0),
('wed38', '12', 'joellen pope weddings', 'city40', '2', 28, 5.0),
('wed39', '12', 'ces weddings and events', 'city64', '3', 24, 5.0),
('wed40', '12', 'lauren miller events', 'city64', '2', 85, 5.0),
('wed41', '12', 'katelynn jessen events', 'city64', '1', 27, 5.0),
('wed42', '12', 'elsa vera payuctions', 'city64', '1', 24, 5.0),
('wed43', '12', 'ali diluvio events', 'city64', '2', 52, 5.0),
('wed44', '12', 'cambria events', 'city64', '1', 25, 5.0),
('wed45', '12', 'enchanted weddings', 'city64', '1', 29, 4.9),
('wed46', '12', 'jaime tosti events', 'city64', '2', 31, 5.0),
('wed47', '12', 'alyssa bray events', 'city64', '2', 64, 5.0),
('wed48', '12', 'seven oh seven events', 'city68', '2', 56, 5.0),
('wed49', '12', 'bravo weddings and events', 'city68', '2', 24, 5.0),
('wed50', '12', 'orchard avenue events', 'city68', '3', 66, 5.0);

-- Filling companies
INSERT INTO companies (cmp_id, company) VALUES 
('cmp01', 'derco fine jewelers'),
('cmp02', 'brilliant earth'),
('cmp03', 'geoffreys diamonds and goldsmith'),
('cmp04', 'shane co'),
('cmp05', 'yadav diamonds and jewelry'),
('cmp06', 'la bijouterie'),
('cmp07', 'barons'),
('cmp08', 'appelblom jewelry'),
('cmp09', 'just bands'),
('cmp10', 'oaks jewelry'),
('cmp11', 'design jewelers'),
('cmp12', 'heller jewelers'),
('cmp13', 'pavé fine jewelry'),
('cmp14', 'spitz jewelers'),
('cmp15', 'vardys jewelers'),
('cmp16', 'newark jewelry center'),
('cmp17', 'neil dahl jewelers of california'),
('cmp18', 'sausalito jewelers'),
('cmp19', 'willow glen diamond company'),
('cmp20', 'joe escobar'),
('cmp21', 'jin wang'),
('cmp22', 'topper fines jewelry'),
('cmp23', 'the love of ganesha'),
('cmp24', 'master fix jewelers'),
('cmp25', 'general bead'),
('cmp26', 'louis vuitton'),
('cmp27', 'tiffany and co'),
('cmp28', 'chanel'),
('cmp29', 'psprint'),
('cmp30', 'mikes camera'),
('cmp31', 'hyegraph invitations and calligraphy'),
('cmp32', 'fedex office print and ship center'),
('cmp33', 'pine press printing binding and copying'),
('cmp34', 'mikes camera pleasant hill'),
('cmp35', 'coffee n cream press'),
('cmp36', '123weddingcards'),
('cmp37', 'minted'),
('cmp38', 'paper culture'),
('cmp39', 'catprint'),
('cmp40', 'jp stationery'),
('cmp41', 'raoul martinez calligraphy'),
('cmp42', 'gooseberry designs'),
('cmp43', 'zazzle invitations'),
('cmp44', 'lemon leaf prints'),
('cmp45', 'tknotes'),
('cmp46', 'pro digital photos'),
('cmp47', 'people ive loved'),
('cmp48', 'reb peters press'),
('cmp49', 'mercurio brothers');

-- filling store_cmp
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl01', 'cmp01');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl02', 'cmp02');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl03', 'cmp03');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl04', 'cmp04');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl05', 'cmp05');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl06', 'cmp06');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl07', 'cmp07');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl08', 'cmp08');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl09', 'cmp09');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl10', 'cmp10');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl11', 'cmp04');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl12', 'cmp04');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl13', 'cmp11');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl14', 'cmp12');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl15', 'cmp13');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl16', 'cmp14');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl17', 'cmp15');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl18', 'cmp16');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl19', 'cmp17');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl20', 'cmp18');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl21', 'cmp19');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl22', 'cmp20');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl23', 'cmp21');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl24', 'cmp22');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl25', 'cmp23');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl26', 'cmp24');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl27', 'cmp25');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl28', 'cmp26');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl29', 'cmp27');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('jwl30', 'cmp28');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv01', 'cmp29');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv02', 'cmp30');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv03', 'cmp30');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv04', 'cmp31');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv05', 'cmp32');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv06', 'cmp33');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv07', 'cmp34');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv08', 'cmp32');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv09', 'cmp32');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv10', 'cmp32');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv11', 'cmp32');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv12', 'cmp35');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv13', 'cmp36');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv14', 'cmp37');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv15', 'cmp38');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv16', 'cmp39');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv17', 'cmp40');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv18', 'cmp41');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv19', 'cmp42');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv20', 'cmp43');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv21', 'cmp44');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv22', 'cmp45');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv23', 'cmp46');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv24', 'cmp47');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv25', 'cmp48');
INSERT INTO store_cmp (store_id, cmp_id) VALUES ('inv26', 'cmp49');

-- Filling sources table
INSERT INTO sources (url_id, url) VALUES ('cak01', 'https://www.yelp.com/biz/charlies-cheesecake-works-san-jose');
INSERT INTO sources (url_id, url) VALUES ('cak02', 'https://www.yelp.com/biz/cream-san-francisco-4');
INSERT INTO sources (url_id, url) VALUES ('cak03', 'https://www.yelp.com/biz/cakeabakin-pacifica');
INSERT INTO sources (url_id, url) VALUES ('cak04', 'https://www.yelp.com/biz/mitra-art-cake-concord-5');
INSERT INTO sources (url_id, url) VALUES ('cak05', 'https://www.theknot.com/marketplace/poore-man-bakery-danville-ca-2075151');
INSERT INTO sources (url_id, url) VALUES ('cak06', 'https://www.theknot.com/marketplace/birdie-bakery-castro-valley-ca-2075867');
INSERT INTO sources (url_id, url) VALUES ('cak07', 'https://www.yelp.com/biz/inticing-creations-san-francisco');
INSERT INTO sources (url_id, url) VALUES ('cak08', 'https://www.yelp.com/biz/tonys-cakes-vallejo');
INSERT INTO sources (url_id, url) VALUES ('cak09', 'https://www.yelp.com/biz/camishas-cakes-san-francisco-6');
INSERT INTO sources (url_id, url) VALUES ('cak10', 'https://www.yelp.com/biz/golden-gate-fortune-cookie-factory-san-francisco');
INSERT INTO sources (url_id, url) VALUES ('cak11', 'https://www.yelp.com/biz/anas-bakery-san-jose');
INSERT INTO sources (url_id, url) VALUES ('cak12', 'https://www.theknot.com/marketplace/cups-and-cakes-bakery-san-francisco-ca-434118');
INSERT INTO sources (url_id, url) VALUES ('cak13', 'https://www.yelp.com/biz/two-chicks-in-the-mix-oakland-3');
INSERT INTO sources (url_id, url) VALUES ('cak14', 'https://www.yelp.com/biz/alexanders-patisserie-mountain-view-3');
INSERT INTO sources (url_id, url) VALUES ('cak15', 'https://www.theknot.com/marketplace/fauxcakes-by-katie-palo-alto-ca-869549');
INSERT INTO sources (url_id, url) VALUES ('cak16', 'https://www.yelp.com/biz/batch-pastries-oakland');
INSERT INTO sources (url_id, url) VALUES ('cak17', 'https://www.yelp.com/biz/gerhard-michler-fine-european-desserts-san-francisco');
INSERT INTO sources (url_id, url) VALUES ('cak18', 'https://www.yelp.com/biz/le-gateau-elegant-walnut-creek');
INSERT INTO sources (url_id, url) VALUES ('cak19', 'https://www.yelp.com/biz/renaissance-specialty-cakes-and-desserts-emeryville-2');
INSERT INTO sources (url_id, url) VALUES ('cak20', 'https://www.yelp.com/biz/migoodies-bakesale-daly-city');
INSERT INTO sources (url_id, url) VALUES ('cak21', 'https://www.yelp.com/biz/revelry-cakes-sausalito');
INSERT INTO sources (url_id, url) VALUES ('cak22', 'https://www.theknot.com/marketplace/ashley-nicole-cakes-san-mateo-ca-2014543');
INSERT INTO sources (url_id, url) VALUES ('cak23', 'https://www.yelp.com/biz/live-love-bake-san-rafael');
INSERT INTO sources (url_id, url) VALUES ('cak24', 'https://www.yelp.com/biz/marleys-streats-san-francisco');
INSERT INTO sources (url_id, url) VALUES ('cak25', 'https://www.yelp.com/biz/cake-expressions-santa-clara');
INSERT INTO sources (url_id, url) VALUES ('cak26', 'https://www.yelp.com/biz/daniel-saravia-cakes-san-francisco');
INSERT INTO sources (url_id, url) VALUES ('cak27', 'https://www.theknot.com/marketplace/lemoon-zest-allergen-savvy-patisserie-la-honda-ca-2054471');
INSERT INTO sources (url_id, url) VALUES ('cak28', 'https://www.yelp.com/biz/jens-cakes-san-jose-3');
INSERT INTO sources (url_id, url) VALUES ('cak29', 'https://www.yelp.com/biz/sf-candy-bar-san-francisco-2');
INSERT INTO sources (url_id, url) VALUES ('cak30', 'https://www.theknot.com/marketplace/dulce-mia-cakes-modesto-ca-2060350');
INSERT INTO sources (url_id, url) VALUES ('cak31', 'https://www.yelp.com/biz/elegant-cheese-cakes-sonoma-2');

-- INSERT planner_prices
INSERT INTO planner_prices VALUES ('wed01',1, 2500, 2500, 12000);
INSERT INTO planner_prices VALUES ('wed02', 1, 3500, 8500, 10000);
INSERT INTO planner_prices VALUES ('wed03', 0, 3000, 6000, 9000);
INSERT INTO planner_prices VALUES ('wed04', 0, 2800, 3200, 4000);
INSERT INTO planner_prices VALUES ('wed05', 1, 8500, 10000, 18000);
INSERT INTO planner_prices VALUES ('wed06', 0, 3800, 8000, 9000);
INSERT INTO planner_prices VALUES ('wed07', 1, 1800, 2000, 3000);
INSERT INTO planner_prices VALUES ('wed08', 0, 1500, 2000, 2600);
INSERT INTO planner_prices VALUES ('wed09', 1, 800, 800, 1900);
INSERT INTO planner_prices (wed_id, hourly, `partial`, `full`) VALUES ('wed10', 0, 7000, 10000);
INSERT INTO planner_prices VALUES ('wed11', 1, 1250, 3500, 6500);
INSERT INTO planner_prices (wed_id, hourly, `partial`, `full`) VALUES ('wed12', 0, 4000, 4000);
INSERT INTO planner_prices (wed_id, hourly, `partial`, `full`) VALUES ('wed13', 1, 8000, 12000);
INSERT INTO planner_prices VALUES ('wed14', 0, 3095, 5523, 8258);
INSERT INTO planner_prices VALUES ('wed15', 0, 3499, 12000, 12000);
INSERT INTO planner_prices VALUES ('wed16', 0, 3900, 2900, 5800);
INSERT INTO planner_prices VALUES ('wed17', 1, 3000, 8000, 14000);
INSERT INTO planner_prices VALUES ('wed18', 0, 3500, 7000, 10000);
INSERT INTO planner_prices VALUES ('wed19', 0, 1800, 2000, 6000);
INSERT INTO planner_prices VALUES ('wed20', 1, 2200, 4000, 6000);
INSERT INTO planner_prices VALUES ('wed21', 0, 4000, 8000, 12000);
INSERT INTO planner_prices VALUES ('wed22', 0, 1000, 1000, 5000);
INSERT INTO planner_prices VALUES ('wed23', 0, 5500, 12000, 25000);
INSERT INTO planner_prices VALUES ('wed24', 0, 3900, 2900, 5800);
INSERT INTO planner_prices VALUES ('wed25', 0, 3000, 3000, 5000);
INSERT INTO planner_prices VALUES ('wed26', 1, 5275, 6875, 9275);
INSERT INTO planner_prices VALUES ('wed27', 1, 2000, 3200, 5400);
INSERT INTO planner_prices VALUES ('wed28', 1, 3000, 5500, 10000);
INSERT INTO planner_prices VALUES ('wed29', 1, 1500, 500, 2000);
INSERT INTO planner_prices (wed_id, hourly, `partial`, `full`) VALUES ('wed30', 0, 6500, 20500);
INSERT INTO planner_prices (wed_id, hourly, `partial`, `full`) VALUES ('wed31', 1, 2000, 2000);
INSERT INTO planner_prices VALUES ('wed32', 1, 2800, 6500, 15000);
INSERT INTO planner_prices VALUES ('wed33', 1, 4500, 6500, 10000);
INSERT INTO planner_prices VALUES ('wed34', 1, 3300, 4300, 6300);
INSERT INTO planner_prices VALUES ('wed35', 1, 3500, 5500, 8500);
INSERT INTO planner_prices VALUES ('wed36', 0, 1250, 2500, 6600);
INSERT INTO planner_prices (wed_id, hourly, `partial`, `full`) VALUES ('wed37', 1, 7500, 20000);
INSERT INTO planner_prices VALUES ('wed38', 0, 3500, 5000, 7000);
INSERT INTO planner_prices (wed_id, hourly, `partial`, `full`)VALUES ('wed39', 0, 6500, 9000);
INSERT INTO planner_prices VALUES ('wed40', 0, 4000, 4000, 7000);
INSERT INTO planner_prices VALUES ('wed41', 0, 2400, 2400, 5800);
INSERT INTO planner_prices VALUES ('wed42', 1, 500, 500, 6500);
INSERT INTO planner_prices VALUES ('wed43', 0, 2512, 4204, 9480);
INSERT INTO planner_prices VALUES ('wed44', 1, 1900, 3000, 6500);
INSERT INTO planner_prices (wed_id, hourly, `partial`) VALUES ('wed45', 0, 2750);
INSERT INTO planner_prices VALUES ('wed46', 0, 3500, 5500, 12000);
INSERT INTO planner_prices (wed_id, hourly, daily, `partial`) VALUES ('wed47', 1, 2650, 3500);
INSERT INTO planner_prices VALUES ('wed48', 1, 3500, 5500, 7500);
INSERT INTO planner_prices VALUES ('wed49', 0, 3000, 4000, 6000);
INSERT INTO planner_prices VALUES ('wed50', 1, 4000, 7500, 10000);

-- filling photo_prices
INSERT INTO photo_prices VALUES
	('pho01',1,33.00),
	('pho02',1,27.00),
	('pho03',1,49.99),
	('pho04',1,37.50),
	('pho05',1,30.00),
	('pho06',1,39.95),
	('pho07',1,60.00),
	('pho08',1,50.00),
	('pho09',1,30.00),
	('pho10',1,10.00),
	('pho11',1,60.00),
	('pho12',1,19.99),
	('pho13',1,37.50),
	('pho14',1,39.00),
	('pho15',1,49.50),
	('pho16',1,28.00),
	('pho17',1,45.00),
	('pho18',1,50.00),
	('pho19',1,55.50),
	('pho20',1,80.00),
	('pho21',1,40.00),
	('pho22',1,19.99),
	('pho23',1,32.00),
	('pho24',1,36.00),
	('pho25',1,54.00),
	('pho26',1,28.00),
	('pho27',0,55.00),
	('pho28',0,35.00),
	('pho29',0,65.00),
	('pho30',0,23.50),
	('pho31',0,39.00),
	('pho32',0,60.00),
	('pho33',0,55.00),
	('pho34',0,58.83),
	('pho35',0,55.00),
	('pho36',0,150.00),
	('pho37',0,45.00),
	('pho38',0,65.00),
	('pho39',0,50.00),
	('pho40',0,40.00),
	('pho41',0,58.80),
	('pho42',0,26.50),
	('pho43',0,25.00),
	('pho44',0,25.00),
	('pho45',0,17.50),
	('pho46',0,27.50);

-- filling music_type
INSERT INTO music_type (type_id, `type`) VALUES
(1, 'wedding bands'),
(2, 'djs'),
(3, 'soloists and ensembles');

-- filling music_match
INSERT INTO music_match (mus_id, type_id) VALUES
('mus01', 1),
('mus02', 2),
('mus03', 1),
('mus04', 2),
('mus05', 2),
('mus06', 2),
('mus07', 2),
('mus08', 2),
('mus09', 2),
('mus10', 2),
('mus11', 2),
('mus12', 2),
('mus13', 1),
('mus14', 1),
('mus15', 1),
('mus16', 2),
('mus17', 1),
('mus18', 1),
('mus19', 1),
('mus20', 2),
('mus21', 1),
('mus22', 2),
('mus23', 2),
('mus24', 2),
('mus25', 1),
('mus26', 2),
('mus27', 2),
('mus28', 1),
('mus29', 1),
('mus30', 2),
('mus31', 1),
('mus32', 2),
('mus33', 2),
('mus34', 1),
('mus35', 2),
('mus36', 1),
('mus37', 3),
('mus38', 2),
('mus39', 1),
('mus40', 2),
('mus41', 1),
('mus42', 1),
('mus43', 2),
('mus44', 1),
('mus45', 1),
('mus46', 2),
('mus47', 2),
('mus48', 3),
('mus49', 3),
('mus50', 3);

-- filling addresses
INSERT INTO addresses VALUES('cak01', '1179 redmond ave');
INSERT INTO addresses VALUES('cak02', '19501 stevens creek blvd 102');
INSERT INTO addresses VALUES('cak04', '3654 sunview way');
INSERT INTO addresses VALUES('cak07', '436 clementina st');
INSERT INTO addresses VALUES('cak08', '1833 springs rd');
INSERT INTO addresses VALUES('cak09', '255 mendell st');
INSERT INTO addresses VALUES('cak10', '56 ross alley');
INSERT INTO addresses VALUES('cak11', '1175 redmond ave');
INSERT INTO addresses VALUES('cak12', '451 9th st');
INSERT INTO addresses VALUES('cak13', '2353 e 12th st');
INSERT INTO addresses VALUES('cak14', '209 castro st');
INSERT INTO addresses VALUES('cak15', '2165 dartmouth st');
INSERT INTO addresses VALUES('cak16', '2220 mountain blvd');
INSERT INTO addresses VALUES('cak17', '950 illinois st');
INSERT INTO addresses VALUES('cak18', '1479 newell ave');
INSERT INTO addresses VALUES('cak19', '1327 61st st');
INSERT INTO addresses VALUES('cak21', '201 3rd st');
INSERT INTO addresses VALUES('cak22', '123 n eldorado st');
INSERT INTO addresses VALUES('cak24', '601 mission bay blvd north');
INSERT INTO addresses VALUES('cak25', '2325 de la cruz blvd');
INSERT INTO addresses VALUES('cak28', '1053 lincoln ave');
INSERT INTO addresses VALUES('cak29', '1350 old bayshore hwy st 520');
INSERT INTO addresses VALUES('cat01', '150 w portal ave');
INSERT INTO addresses VALUES('cat02', '178 clinton st');
INSERT INTO addresses VALUES('cat03', '28316 cubberley st');
INSERT INTO addresses VALUES('cat04', '2565 3rd st suite 236');
INSERT INTO addresses VALUES('cat05', '1555 s novato blvd');
INSERT INTO addresses VALUES('cat06', '3840 alhambra ave');
INSERT INTO addresses VALUES('cat07', '1233 preservation park way');
INSERT INTO addresses VALUES('cat08', '201 adrian rd millbrae');
INSERT INTO addresses VALUES('cat09', '1141 catalina dr');
INSERT INTO addresses VALUES('cat10', '35 dillon ave');
INSERT INTO addresses VALUES('cat11', '1400 ca- 1 bodega bay');
INSERT INTO addresses VALUES('cat12', '416 east d st petaluma');
INSERT INTO addresses VALUES('cat13', '1909 el camino real');
INSERT INTO addresses VALUES('cat14', '20 enterprise ct');
INSERT INTO addresses VALUES('cat15', '1605 sir francis drake blvd');
INSERT INTO addresses VALUES('cat16', '3295 castro valley blvd ste 114');
INSERT INTO addresses VALUES('cat17', '591 mercantile dr');
INSERT INTO addresses VALUES('cat18', '201 seminary dr');
INSERT INTO addresses VALUES('cat19', '776 technology way');
INSERT INTO addresses VALUES('cat20', '827 arnold dr');
INSERT INTO addresses VALUES('cat21', '837 texas st');
INSERT INTO addresses VALUES('cat22', '8210 capwell dr');
INSERT INTO addresses VALUES('cat23', '1750 harrison st');
INSERT INTO addresses VALUES('cat24', '1050 22nd ave');
INSERT INTO addresses VALUES('cat25', '201 spear st 1100');
INSERT INTO addresses VALUES('cat26', '372 24th st');
INSERT INTO addresses VALUES('cat27', '2096 burroughs ave');
INSERT INTO addresses VALUES('cat28', '73 rickenbacker cir');
INSERT INTO addresses VALUES('cat29', '1700 green hills rd');
INSERT INTO addresses VALUES('cat30', '1798 bryant st');
INSERT INTO addresses VALUES('cat31', '700 terry a francois blvd');
INSERT INTO addresses VALUES('cat32', '1 santa barbara rd');
INSERT INTO addresses VALUES('cat33', '60 spear st');

-- filling tasting_cities
INSERT INTO tasting_cities (cat_id, city_id) VALUES
('cat01', 'city51'),
('cat02', 'city51'),
('cat03', 'city51'),
('cat04', 'city51'),
('cat05', 'city63'),
('cat07', 'city02'),
('cat08', 'city54'),
('cat09', 'city02'),
('cat10', 'city51'),
('cat11', 'city63'),
('cat12', 'city63'),
('cat13', 'city51'),
('cat14', 'city36'),
('cat15', 'city51'),
('cat16', 'city02'),
('cat17', 'city36'),
('cat18', 'city29'),
('cat19', 'city63'),
('cat21', 'city63'),
('cat22', 'city02'),
('cat23', 'city02'),
('cat24', 'city02'),
('cat25', 'city51'),
('cat26', 'city02'),
('cat27', 'city02'),
('cat28', 'city02'),
('cat29', 'city51'),
('cat30', 'city51'),
('cat31', 'city51'),
('cat33', 'city51');
 
-- filling hair_experience
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai01', 11 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai02', 14 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai03', 22 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai04', 8 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai05', 16 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai06', 16 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai07', 10 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai08', 5 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai09', 12 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai10', 14 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai11', 11 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai12', 14 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai13', 15 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai14', 8 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai15', 11 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai16', 7 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai17', 12 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai18', 5 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai19', 18 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai20', 7 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai21', 4 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai22', 7 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai23', 9 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai24', 7 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai25', 10 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai26', 20 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai27', 11 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai28', 11 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai29', 17 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai30', 12 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai31', 7 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai32', 10 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai33', 11 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai34', 11 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai35', 9 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai36', 15 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai37', 15 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai38', 9 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai39', 23 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai40', 15 );
  INSERT INTO hair_experience(hai_id, years) VALUES ( 'hai41', 24 );

-- filling hair_services
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai01', 1, 1, 0 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai02', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai03', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai04', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai05', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai06', 1, 0, 0 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai07', 0, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai08', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai09', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai10', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai11', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai12', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai13', 0, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai14', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai15', 1, 0, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai16', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai17', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai18', 1, 1, 0 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai19', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai20', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai21', 1, 1, 0 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai22', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai23', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai24', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai25', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai26', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai27', 1, 1, 0 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai28', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai29', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai30', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai31', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai32', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai33', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai34', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai35', 1, 1, 0 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai36', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai37', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai38', 1, 1, 0 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai39', 1, 1, 0 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai40', 1, 1, 1 );
INSERT INTO hair_services(hai_id, hair, makeup, pre_wedding) VALUES ( 'hai41', 1, 1, 1 );

-- filling catering_services
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat01', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat02', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat03', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat04', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat05', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat06', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat07', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat08', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat09', 1, 0);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat10', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat11', 1, 0);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat12', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat13', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat14', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat15', 0, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat16', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat17', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat18', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat19', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat20', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat21', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat22', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat23', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat24', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat25', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat26', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat27', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat28', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat29', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat30', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat31', 1, 1);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat32', 1, 0);
INSERT INTO catering_services (cat_id, buffet, plate) VALUES ('cat33', 1, 0);

-- filling rental_services
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren01',1,1,1,1,1,1,1,0,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren02',1,1,0,1,1,0,1,0,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren03',1,0,1,1,0,0,1,0,0,1,1,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren04',1,0,1,1,0,0,0,0,0,1,1,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren05',1,1,1,0,0,0,1,1,0,1,0,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren06',1,0,1,1,0,0,0,1,0,1,1,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren07',1,1,1,1,1,0,1,0,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren08',1,0,0,0,0,0,0,0,0,1,1,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren09',1,1,1,1,1,0,0,0,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren10',1,1,1,0,0,0,0,0,1,1,0,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren11',1,1,1,1,1,0,1,0,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren12',0,1,1,0,0,0,1,1,0,1,1,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren13',0,0,1,1,0,0,1,1,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren14',0,1,1,1,1,1,1,1,1,1,0,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren15',1,1,1,1,0,0,1,1,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren16',1,1,1,1,0,0,1,1,1,1,0,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren17',0,1,0,0,0,0,1,1,0,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren18',1,1,1,1,1,0,1,1,1,1,0,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren19',0,0,0,0,0,0,0,0,0,1,0,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren20',1,1,1,0,0,0,1,1,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren21',1,0,1,0,0,0,0,0,0,1,1,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren22',1,0,1,0,0,0,0,1,1,1,0,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren23',0,0,1,0,0,0,0,1,1,0,0,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren24',1,1,1,1,1,0,0,0,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren25',1,1,0,1,1,0,1,0,0,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren26',0,0,0,1,0,0,1,0,0,1,0,0);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren27',0,0,0,0,0,0,1,0,0,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren28',1,0,1,1,1,0,0,1,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren29',1,1,1,1,1,0,1,1,1,1,1,1);
INSERT INTO rental_services(ren_id,decor,heating,lighting,linen,lounge,restroom,shade,speaker,stage,table_chair,tableware,tent) VALUES ('ren30',1,0,0,0,1,0,0,0,0,1,0,0);

-- filling cake_services
INSERT INTO cake_services VALUES
('cak01', 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1),
('cak02', 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak03', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak04', 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1),
('cak06', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak07', 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1),
('cak08', 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
('cak09', 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0),
('cak10', 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1),
('cak11', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak12', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak13', 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
('cak14', 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0),
('cak15', 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0),
('cak16', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak17', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak18', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak19', 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
('cak20', 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1),
('cak21', 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0),
('cak22', 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0),
('cak23', 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1),
('cak24', 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1),
('cak25', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0),
('cak26', 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0),
('cak27', 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0),
('cak28', 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1),
('cak29', 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
('cak30', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0),
('cak31', 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1);

-- filling cakes
INSERT INTO cakes VALUES
('cak01', 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak02', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak03', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak04', 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0),
('cak06', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak07', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak08', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak09', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak10', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak11', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak12', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0),
('cak13', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak14', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak16', 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
('cak17', 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0),
('cak18', 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1),
('cak19', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak20', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak21', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak22', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak23', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak24', 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak25', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak26', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak27', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak28', 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
('cak29', 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1),
('cak30', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak31', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
;

-- filling diets
INSERT INTO diets VALUES
('cak01', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1),
('cak02', 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1),
('cak03', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak04', 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1),
('cak06', 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1),
('cak07', 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0),
('cak08', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak09', 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1),
('cak10', 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0),
('cak11', 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1),
('cak12', 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0),
('cak13', 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0),
('cak14', 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0),
('cak15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak16', 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1),
('cak17', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak18', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak19', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak20', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
('cak21', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak22', 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1),
('cak23', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
('cak24', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cak25', 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
('cak26', 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0),
('cak27', 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1),
('cak28', 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1),
('cak29', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
('cak30', 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1),
('cak31', 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0);

-- filling invitations
INSERT INTO invitations (inv_id, min_quantity) VALUES 
('inv01', 50),
('inv02', 12),
('inv03', 12),
('inv04', 25),
('inv05', 20),
('inv06', 50),
('inv07', 12),
('inv08', 20),
('inv09', 20),
('inv10', 20),
('inv11', 20),
('inv12', 50),
('inv13', 10),
('inv14', 15),
('inv15', 10),
('inv16', 100),
('inv17', 25),
('inv18', 10),
('inv19', 1),
('inv20', 24),
('inv21', 10),
('inv22', 1),
('inv23', 24),
('inv24', 1),
('inv25', 25),
('inv26', 20);

-- filling venues
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven01', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven02', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven03', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven04', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven05', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven06', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven07', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven08', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven09', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven10', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven11', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven12', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven13', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven14', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven15', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven16', '0', '0', '0', '0', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven17', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven18', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven19', '1', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven20', '1', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven21', '1', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven23', '0', '1', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven24', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven25', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven26', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven27', '1', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven28', '1', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven29', '1', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven30', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven31', '0', '0', '0', '0', '0', '1', '0', '0', '1', '0', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven32', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO venues (ven_id, ballroom, barn, club_house, country_club, gallery, garden, golf_club, hotel, mansion, museum, private_club, private_estate, terrace, winery) VALUES ('ven33', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1');

-- filling venue_capacities
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven01', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven02', 250);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven03', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven04', 250);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven05', 200);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven06', 200);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven07', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven08', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven09', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven10', 250);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven11', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven12', 200);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven13', 250);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven14', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven15', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven16', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven17', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven18', 200);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven19', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven20', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven21', 250);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven22', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven23', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven24', 200);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven25', 250);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven26', 150);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven27', 250);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven28', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven29', 200);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven30', 250);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven31', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven32', 300);
INSERT INTO venue_capacities (ven_id, capacity) VALUES ('ven33', 300);

-- filling venue_locations
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven01', 0, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven02', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven03', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven04', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven05', 1, 0);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven06', 1, 0);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven07', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven08', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven09', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven10', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven11', 0, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven12', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven13', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven14', 0, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven15', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven16', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven17', 1, 0);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven18', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven19', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven20', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven21', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven22', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven23', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven24', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven25', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven26', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven27', 0, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven28', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven29', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven30', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven31', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven32', 1, 1);
INSERT INTO venue_locations (ven_id, indoor, outdoor) VALUES ('ven33', 1, 1);