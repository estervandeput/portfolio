/*  Team's rationale: 
Wedding_size and budget_level: 

For the budget level category, we based it on the 'affordability' in our database, which we deducted from TheKnot.com dollar-sign pricing filter, 
which varies from 1$('inexpensive') to 4\$('luxury') (TheKnot, n.d.).

Regarding the wedding size, we deducted the wedding capacity from 'capacity' in the dataset. We proportionally removed 'capacity' from the 
available capacity the venues were offering, as some space will be taken by the tables, seats, dancefloor, buffet, bars, and other rentals. We assumed 
small venues would have less space (hence a more significant proportion taken out) than larger venues. 

Assumptions and special cases: 

Since the Wedding theme is a mix of Garden (primary) and Fairytale (secondary), most venues are gardens, private estates, and wineries that offer both inside and outside accommodation and can, therefore, accommodate parties of all sizes. The main price difference is in the quality of 
vendors chosen and the number of plates/cocktails/seats and rentals. 

For small-size weddings, we have only found a venue that could accommodate a small party and would align with our client's expectations: The Argonaut Hotel in San Francisco. This venue option emphasizes the 'Fairytale' theme aspect, but it could still work if we decorated it with flowers and other decorations. 

We picked venues in locations all around the Bay Area with their respective vendors; jewelry, flowers, and cake would be from the same place as we are looking for 
a specific option (macaron cake/dessert buffet, flower arrangements/wedding arch).

*/

USE weddings;

DROP TABLE IF EXISTS temp_wedding_db_team2;

Create TABLE temp_wedding_db_team2 AS

SELECT
	#department and vendors
	d.functions AS department,
    v.vendor, v.vendor_id, v.avg_stars, v.reviews,
    
    #photo/video
    MAX(pp.is_photographer) AS photographer, 
    pp.package_price,
    
    # location 
	c.city,
	CASE
		WHEN c.city IN ('santa rosa', 'foresthill','sonoma') THEN 'Sonoma County'
        WHEN c.city IN ('napa','winters') THEN 'Napa County'
        WHEN c.city IN ('sausalito', 'san rafael', 'novato', 'marin', 'nicasio','fairfax') THEN 'Marin County'
        WHEN c.city IN ('alamo', 'antioch', 'brentwood', 'concord', 'danville', 'lafayette', 'martinez', 
						'pinole', 'pleasant hill', 'pleasanton', 'san pablo', 'san ramon', 'walnut creek') THEN 'Contra Costa County'
        WHEN c.city IN ('alameda', 'berkeley', 'castro valley', 'dublin', 'emeryville', 'fremont', 'hayward', 'livermore', 
						'newark', 'oakland', 'san leandro' ,'sunol') THEN 'Alameda County'
		WHEN c.city IN ('burlingame', 'daly city', 'half moon bay', 'menlo park', 'milbrae', 'pacifica', 'redwood', 
						'san bruno', 'san carlos', 'san mateo', 'woodside') THEN 'San Mateo County'
		WHEN c.city IN ('san francisco', 'harbor village', 'lakeshore', 'telegraph hill') THEN 'San Francisco County'
        WHEN c.city IN ('campbell', 'cupertino', 'gilroy', 'los altos', 'saratoga','los gatos', 'milpitas', 'morgan hill', 'mountain view',
						'palo alto', 'san jose', 'santa clara', 'hollister', 'sunnyvale') THEN 'Santa Clara County'
		ELSE 'Solano County'
	END AS 'county', 
    
    CASE
		WHEN MAX(vc.capacity) - (MAX(vc.capacity) * 0.6) <= 62.5 THEN 'small'
		WHEN MAX(vc.capacity) - (MAX(vc.capacity) * 0.2) > 62.5 AND MAX(vc.capacity) - (MAX(vc.capacity) * 0.2) <= 187.5 THEN 'medium'
		WHEN MAX(vc.capacity) - (MAX(vc.capacity) * 0.1) > 187.5 THEN 'large'
        ELSE 'others'
	END AS 'wedding_size',
    
    # venue type - indoor/outdoor
	CASE
        WHEN MAX(vl.indoor) = 1 AND MAX(vl.outdoor) = 1 THEN 'hybrid'
        ELSE 'other'
	END AS 'hybrid_venue',
    
    #venue type
	MAX(vv.barn) AS barn, 
    MAX(vv.ballroom) AS ballroom, 
    MAX(vv.club_house) AS club_house, 
    MAX(vv.country_club) AS country_club, 
    MAX(vv.garden) AS garden, 
    MAX(vv.golf_club) AS golf_club, 
    MAX(vv.hotel) AS hotel, 
    MAX(vv.mansion) AS mansion, 
    MAX(vv.private_club) AS private_club,
    MAX(vv.private_estate) AS private_estate,
    MAX(vv.winery) AS winery,
    
    #hair and makeup services
    hs.hair, 
    hs.makeup,
    
    #reviews/ratings and price
    v.avg_stars AS avg_reviews,
    v.price_id,
    p.affordability AS budget_level,
    
    #catering services
    MAX(cat.buffet) AS catering_buffet,
	
    #invitation table
    i.min_quantity,
    #rental services
    MAX(rs.table_chair) AS rent_table_and_chairs, 
    MAX(rs.decor) AS rent_decor, 
    MAX(rs.lighting) AS rent_lighting, 
    MAX(rs.speaker) AS rent_speaker, 
    MAX(rs.tableware) AS rent_tableware, 
    MAX(rs.tent) AS rent_tent, 
    MAX(rs.restroom) AS rent_restroom, 
    
    # cake type
    MAX(cs.other_desserts) AS other_desert, 
    MAX(cs.cake_delivery_and_setup) AS cake_delivery_and_setup,
	MAX(cs.cake_stands) AS cake_stands, 
    MAX(cs.custom_orders) AS cake_custom_orders,
    MAX(cs.buffet_style) AS cake_buffet_style,
    
    # add wedding planner
    MAX(pl.hourly) AS wedding_planner_hourly,
    pl.daily AS wedding_planner_daily,
	pl.`partial` AS wedding_planner_partial,
    pl.`full` AS wedding_planner_full
    
FROM vendors AS v

#join catering service table
LEFT JOIN catering_services AS cat
	ON v.vendor_id = cat.cat_id
    
#join city table
LEFT JOIN cities AS c
	ON v.city_id = c.city_id
    
#join venue capacity table
LEFT JOIN venue_capacities AS vc
	ON v.vendor_id = vc.ven_id

#join price table
LEFT JOIN prices AS p
	ON v.price_id = p.price_id

# join department table 
LEFT JOIN departments AS d
	ON v.function_id = d.function_id

# join venue table
LEFT JOIN venues AS vv 
	ON v.vendor_id = vv.ven_id

# join venue location
LEFT JOIN venue_locations AS vl
	ON v.vendor_id = vl.ven_id

# join invitation table
LEFT JOIN invitations AS i
	ON v.vendor_id = i.inv_id

# join photo table
LEFT JOIN photo_prices AS pp 
	ON v.vendor_id = pp.pho_id

#join cake tableS
LEFT JOIN cake_services AS cs 
	ON v.vendor_id = cs.cak_id
    
LEFT JOIN cakes AS ck 
	ON v.vendor_id = ck.cak_id

# Join planner table
LEFT JOIN planner_prices AS pl 
	ON v.vendor_id = pl.wed_id

# join rental tables 
LEFT JOIN rental_services AS rs 
	ON v.vendor_id = rs.ren_id

# join hair/makeup table
LEFT JOIN hair_services AS hs
	ON v.vendor_id = hs.hai_id

# GROUP BY so SQL knows what to generates
GROUP BY v.city_id, v.price_id, p.affordability, v.avg_stars, v.vendor, d.functions, pp.package_price, i.inv_id, i.min_quantity,hs.hair, hs.makeup,v.price_id,pl.daily,
	pl.`partial`,pl.`full`, v.vendor_id, v.avg_stars, v.reviews; 

# Shows the temporary table 
SELECT * FROM temp_wedding_db_team2;

################################
## Options Table

DROP temporary table vendor_options; 

### Create the Options Table 
Create temporary table vendor_options AS 

# OPTION 1: Row SMALL CAP and INEXPENSIVE 
# San Francisco Wedding at the Argonaut Hotel - only small capacity venue we have, would be fitting if couple decide to go more towards the 'Fairytale' Theme

/* Code Comments/Explanation for the vendor Options table:
The following is SELECT statements with unions in order to create a table for the vendor options that have the columns needed to give the client the best option within
the anticipated wedding size and budget level. 
Essentially there are 17 columns for each row. Options are nummerated and wedding size and budget level with their respective vendor option are on one row, added with the estimated cost and theme for the wedding.
How the vendor options were found: 
Using Select statements with the MAX function to find the best possible fit for a specific wedding size, budget level, also taking the price_id (budget level) and reviews for the vendor, as well as the location into account. 
This concept was used to create each row and repeated throughout this table. 
*/

SELECT  
	'1' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'small' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'inexpensive' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 1 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### needs tweak
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'small' THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 1 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 1 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 1 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 1 AND county = 'Contra Costa County' and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 1 AND county = 'Santa Clara County' THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 1 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 1 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, 
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 1 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 1 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$17,325' AS est_cost, 
    'Fairytale' AS wedding_theme

    
FROM temp_wedding_db_team2

## Add next row(option)
UNION

# OPTION 2: Row SMALL CAP and AFFORDABLE
# San Francisco Wedding at the Argonaut Hotel - only small capacity venue we have, would be fitting if couple decide to go more towards the 'Fairytale' Theme

SELECT 
    '2' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'small' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'affordable' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 2 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### needs tweak
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'small' THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 2 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 2 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 2 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 2 AND county = 'Contra Costa County' and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 2 AND county = 'Santa Clara County' THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 2 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 2 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, 
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 2 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 2 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
	'$24,550' AS est_cost, 
    'Fairytale' AS wedding_theme
FROM temp_wedding_db_team2

# add next row (option)
UNION

# OPTION 3: Row SMALL CAP and MODERATE
# San Francisco Wedding at the Argonaut Hotel - only small capacity venue we have, would be fitting if couple decide to go more towards the 'Fairytale' Theme
SELECT  
    '3' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'small' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'moderate' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 2 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### needs tweak
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'small' THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 3 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 3 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 3 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 3 and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 3 AND county = 'Santa Clara County' THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 3 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 3 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, 
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 3 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 3 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$28,225' AS est_cost, 
    'Fairytale' AS wedding_theme
FROM temp_wedding_db_team2

# add next row (option)
UNION

# OPTION 4: Row SMALL  CAP and LUXURY 
# San Francisco Wedding at the Argonaut Hotel - only small capacity venue we have, would be fitting if couple decide to go more towards the 'Fairytale' Theme

SELECT  
    '4' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'small' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'luxury' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 2 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### no 
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'small'  THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 4 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 3 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, # only bad jewlery in category 4 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 4 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 4 and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 4 AND avg_reviews > 4 THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 4 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 3 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, #  
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 4 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 4 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$35,400' AS est_cost, 
    'Fairytale' AS wedding_theme
FROM temp_wedding_db_team2

# add next row (option
UNION

# OPTION 5: Row MED CAP and INEXPENSIVE 
# Hollister Wedding at Leal Vineyard - medium capacity if reception inside, possibility of having larger wedding with tent outsides. 
# Offers catering, drinks, decor, rental, and hotel room for guest if needed (but we picked our own vendor because was less expensive)

SELECT  
	'5' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'medium' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'inexpensive' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 1 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### needs tweak
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'medium' AND price_id = 1 or price_id = 2  AND (barn = 1 OR garden =1 OR mansion =1  OR private_estate=1 OR winery = 1)  THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 1 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 1 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 1 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 1 AND county = 'Contra Costa County' and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 1 AND county = 'Santa Clara County' THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 1 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 1 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, 
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 1 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 1 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$35,320' AS est_cost, 
    'Garden/Fairytale' AS wedding_theme

    
FROM temp_wedding_db_team2

## Add next row(option)
UNION

# OPTION 6: Row MED CAP and AFFORDABLE
# Wedding in Novato at StoneTree Estate (Golf/Country Club/Vineyard)
# Offers services: invitation, dj, wine tour, appetizers, champagne & cocktails, seats/tables but picked our own vendors to make it cheaper

SELECT 
    '6' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'medium' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'affordable' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 2 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### needs tweak
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'medium' AND price_id = 2 OR price_id = 1 AND (barn = 1 OR garden =1 OR mansion =1  OR private_estate=1 OR winery = 1)  THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 2 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 2 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 2 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 2 AND county = 'Contra Costa County' and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 2 AND county = 'Santa Clara County' THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 2 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 2 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, 
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 2 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 2 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
	'$45,217' AS est_cost, 
    'Garden/Fairytale' AS wedding_theme
FROM temp_wedding_db_team2

# add next row (option)
UNION

# OPTION 7: Row MED CAP and MODERATE
# Wedding in Los Gatos at Nestldown (Vineyard/Garden) - capacity of 125-150 besides tables, buffet, band, and dancefloor 
# price vary depending on wkend/weekdays : 18,000 - 22,000 (weekdays) and 22,000 - 38,000 (weekends)

SELECT  
    '7' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'medium' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'moderate' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 2 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### needs tweak
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'medium' AND price_id = 3 AND (barn = 1 OR garden =1 OR mansion =1  OR private_estate=1 OR winery = 1)  THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 3 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 3 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 3 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 3 and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 3 AND county = 'Santa Clara County' THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 3 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 3 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, 
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 3 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 3 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$56,438' AS est_cost, 
    'Garden/Fairytale' AS wedding_theme
FROM temp_wedding_db_team2

# add next row (option)
UNION

# OPTION 8: Row MED CAP and LUXURY 
# Wedding in Winters at Park Winters (Barn/Garden/Private Estate/Trees/Hotel) - Perfect for the Wedding theme but a bit further, the venue is also an hotel so guest could stay there!
# price vary depending on days and seasons. 

SELECT  
    '8' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'medium' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'luxury' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 2 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### no 
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'medium' AND price_id = 4 OR price_id = 3 AND (barn = 1 OR garden =1 OR mansion =1  OR private_estate=1 OR winery = 1)  THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 4 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 3 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, # only bad jewlery in category 4 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 4 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 4 and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 4 AND avg_reviews > 4 THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 4 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 3 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, #  
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 4 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 4 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$68,350' AS est_cost, 
    'Garden/Fairytale' AS wedding_theme
FROM temp_wedding_db_team2

#OPTION 9: LARGE SIZE and INEXPENSIVE 
# Wedding in Acampo  at Viaggo Estate and Winery (Winery/Estate/Garden/Barn) 
# Offers own services for food/catering/etc, but picked our own vendors. 

UNION
SELECT  
    '9' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'large' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'inexpensive' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 1 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### needs tweak
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'large' AND price_id = 1 And county = 'Solano County' AND (barn = 1 OR garden =1 OR mansion =1  OR private_estate=1 OR winery = 1)  THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 1 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 1 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 1 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 1 AND county = 'Contra Costa County' and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 1 AND county = 'Santa Clara County' THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 1 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 1 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, 
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 1 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 1 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$56,842' AS est_cost, 
    'Garden/Fairytale' AS wedding_theme
FROM temp_wedding_db_team2

# add next row (option)
UNION

# OPTION 10: Row LARGE SIZE and AFFORDABLE
# Hollister Wedding at Leal Vineyard - large capacity wedding if using tent (inside: buffet dancefloor; outside : seating and ceremony) 
# Offers catering, drinks, decor, rental, and hotel room for guest if needed (but we picked our own vendor because was less expensive)

SELECT  
    '10' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'large' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'affordable' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 2 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### needs tweak
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'large' AND price_id = 2 AND (barn = 1 OR garden =1 OR mansion =1  OR private_estate=1 OR winery = 1)  THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 2 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 2 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 2 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 2 AND county = 'Contra Costa County' and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 2 AND county = 'Santa Clara County' THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 2 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 2 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, 
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 2 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 2 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$47,692' AS est_cost, 
    'Fairytale/Garden' AS wedding_theme
FROM temp_wedding_db_team2

# add next row (option)
UNION

# OPTION 11: LARGE SIZE and MODERATE 
# Wedding in Winters at Park Winters (Barn/Garden/Private Estate/Trees/Hotel) - Perfect for the Wedding theme but a bit further, the venue is also an hotel so guest could stay there!
# price vary depending on days and seasons; and capacity can be extended with tents outsides

SELECT  
    '11' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'large' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'moderate' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 2 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### needs tweak
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'large' AND price_id = 3 AND (barn = 1 OR garden =1 OR mansion =1  OR private_estate=1 OR winery = 1)  THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 3 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 3 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 3 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 3 and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 3 AND county = 'Santa Clara County' THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 3 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 3 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, 
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 3 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 3 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$79,873' AS est_cost, 
    'Garden/Fairytale' AS wedding_theme
FROM temp_wedding_db_team2

# add next row (option)
UNION

# OPTION 12: Row LARGE SIZE and LUXURY 
# Wedding in Saratoga, at Mountain Winery (Ballroom/Historic/Garden/Mountain/Trees) - The perfect venue to combine both the Garden and Fairytale Vibes
# Can accomodate over 300+ guest, but price will vary depending on number of seats/table - have to use their rentals services for chairs/table

SELECT  
    '12' AS 'Option', 
    MAX(CASE WHEN wedding_size = 'large' THEN wedding_size END) AS Wedding_size,
    MAX(CASE WHEN budget_level = 'luxury' THEN budget_level END) AS Budget_level,
    MAX(CASE WHEN vendor_id LIKE "flo%%" AND price_id = 2 AND avg_reviews > 4.8 AND county = 'Contra Costa County' THEN vendor_id END) AS Flowers, #### no 
    MAX(CASE WHEN vendor_id LIKE "ven%%" AND wedding_size = 'large' AND price_id = 4 AND (barn = 1 OR garden =1 OR mansion =1  OR private_estate=1 OR winery = 1)  THEN vendor_id END) AS Venue, 
    MAX(CASE WHEN vendor_id LIKE "mus%%" AND price_id = 4 AND avg_reviews >4.5 THEN vendor_id END) AS Music, 
    MAX(CASE WHEN vendor_id LIKE "jwl%%" AND price_id = 3 AND avg_reviews >4.5 THEN vendor_id END) AS Jewlery, # only bad jewlery in category 4 
    MAX(CASE WHEN vendor_id LIKE "pho%%" AND price_id = 4 AND photographer = 1 AND avg_reviews > 4.5 THEN vendor_id END) AS Photo_and_Video,
    MAX(CASE WHEN vendor_id LIKE "hai%%" AND price_id = 4 and avg_reviews > 4.8 THEN vendor_id END) AS Hair_and_Makeup, 
    MAX(CASE WHEN vendor_id LIKE "dre%%" AND price_id = 4 AND avg_reviews > 4 THEN vendor_id END) AS Attire, 
    MAX(CASE WHEN vendor_id LIKE "cat%%" AND price_id = 4 OR price_id= 2 AND county = 'San Francisco' AND avg_reviews >4.5 THEN vendor_id END) AS Catering, ## change 
    MAX(CASE WHEN vendor_id LIKE "ren%%" AND price_id = 3 AND rent_decor =1 AND rent_table_and_chairs =1 AND rent_tableware =1 AND rent_lighting = 1 THEN vendor_id END) AS Rentals, #  
    MAX(CASE WHEN vendor_id LIKE "inv%%" AND price_id = 4 AND avg_reviews > 4.9 THEN vendor_id END) AS Invitations, 
    MAX(CASE WHEN vendor_id LIKE "cak%%" AND other_desert = 1 OR cake_delivery_and_setup=1 OR cake_stands=1 OR cake_custom_orders =1 OR cake_buffet_style =1 THEN vendor_id END) AS Cake, 
    MAX(CASE WHEN vendor_id LIKE "wed%%" AND price_id = 4 AND avg_reviews = 5 AND reviews >30 THEN vendor_id END) AS Planner,
    '$85,478' AS est_cost, 
    'Garden Fairytale' AS wedding_theme
FROM temp_wedding_db_team2;

select* from vendor_options;
