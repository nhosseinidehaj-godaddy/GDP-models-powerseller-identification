
--- get all US and CA active shoppers (this query gives shopper level features including gcr, tenure, and all the products that shoppers have with GD)---
drop table if exists GD_data;
create temp table GD_data as
select shopper_id,
total_gcr_usd_amt,
--case when shopper_id in ( select distinct shopper_id
--                             from bi.ba_commerce.cohort_combine_final) then 'identifed_PS' else 'not_identifed_PS' end as Identified_PS_flg,
-- case when shopper_id in (select distinct godaddy_shopper_id
--                                   from bi.poynt_spectrum.payfac_application_cln
--                                   where  snap_date = current_date - 1
--                                   and application_level = 'FULL'
--                                   and original_intent = 'CREATE_BUSINESS'
--                                   and risk_decision = 'APPROVED'
--                                   and business_uuid is not null) then 'GDP Customer' else 'Not a GDP cutsomer' end as GDP_flg,   
-- case when shopper_id  in ( select distinct shopper_id from bi.dna_approved.uds_order
--                             where pf_id in(1339765,1339759, 1339761)
--                             and exclude_reason_desc is null
--                             and order_fraud_flag = False
--                             and LENGTH(shopper_id) > 3) then 'Hardware Purchased' else 'NA' end as Hardware_flg,
datediff(month, acq_bill_mst_date, current_date) as tenure_with_GD_months,
datediff(year, acq_bill_mst_date, current_date) as tenure_with_GD_years,
case when product_ownership_name_list like '%Advertising Revenue%' then 1 else 0 end  as Advertising_Revenue_flg ,
case when product_ownership_name_list like '%Domain Alert%' then 1 else 0 end  as Domain_Alert_flg ,
case when product_ownership_name_list like '%Domain Buy Services%' then 1 else 0 end  as Domain_Buy_Services_flg ,
case when product_ownership_name_list like '%Domain Marketplace%' then 1 else 0 end  as Domain_Marketplace_flg ,
case when product_ownership_name_list like '%Conversations%' then 1 else 0 end  as Conversations_flg ,
case when product_ownership_name_list like '%Express Email Marketing%' then 1 else 0 end  as Express_Email_Marketing_flg ,
case when product_ownership_name_list like '%Commerce Enabled%' then 1 else 0 end  as Commerce_Enabled_flg ,
case when product_ownership_name_list like '%Commerce Hardware%' then 1 else 0 end  as Commerce_Hardware_flg ,
case when product_ownership_name_list like '%Quick Shopping Cart%' then 1 else 0 end  as Quick_Shopping_Cart_flg ,
case when product_ownership_name_list like '%Cashparking%' then 1 else 0 end  as Cashparking_flg ,
case when product_ownership_name_list like '%Consolidation%' then 1 else 0 end  as Consolidation_flg ,
case when product_ownership_name_list like '%Domain Buyers Club%' then 1 else 0 end  as Domain_Buyers_Club_flg ,
case when product_ownership_name_list like '%Domain Ownership Protection%' then 1 else 0 end  as Domain_Ownership_Protection_flg ,
case when product_ownership_name_list like '%Domain Services%' then 1 else 0 end  as Domain_Services_flg ,
case when product_ownership_name_list like '%Domains by Proxy%' then 1 else 0 end  as Domains_by_Proxy_flg ,
case when product_ownership_name_list like '%Premium DNS%' then 1 else 0 end  as Premium_DNS_flg ,
case when product_ownership_name_list like '%Domain Name Auction%' then 1 else 0 end  as Domain_Name_Auction_flg ,
case when product_ownership_name_list like '%Domain Name Premium%' then 1 else 0 end  as Domain_Name_Premium_flg ,
case when product_ownership_name_list like '%Domain Name Registration%' then 1 else 0 end  as Domain_Name_Registration_flg ,
case when product_ownership_name_list like '%Domain Name Transfer%' then 1 else 0 end  as Domain_Name_Transfer_flg ,
case when product_ownership_name_list like '%Redemption%' then 1 else 0 end  as Redemption_flg ,
case when product_ownership_name_list like '%DIFY Social%' then 1 else 0 end  as DIFY_Social_flg ,
case when product_ownership_name_list like '%Paid Services%' then 1 else 0 end  as Paid_Services_flg ,
case when product_ownership_name_list like '%Search Engine Visibility%' then 1 else 0 end  as Search_Engine_Visibility_flg ,
case when product_ownership_name_list like '%Paid IT%' then 1 else 0 end  as Paid_IT_flg ,
case when product_ownership_name_list like '%Miscellaneous Fees and Other%' then 1 else 0 end  as Miscellaneous_Fees_and_Other_flg ,
case when product_ownership_name_list like '%Reseller%' then 1 else 0 end  as Reseller_flg ,
case when product_ownership_name_list like '%cPanel Business Hosting%' then 1 else 0 end  as cPanel_Business_Hosting_flg ,
case when product_ownership_name_list like '%Dedicated Hosting%' then 1 else 0 end  as Dedicated_Hosting_flg ,
case when product_ownership_name_list like '%Dedicated IP%' then 1 else 0 end  as Dedicated_IP_flg ,
case when product_ownership_name_list like '%Virtual Hosting%' then 1 else 0 end  as Virtual_Hosting_flg ,
case when product_ownership_name_list like '%Web Pro%' then 1 else 0 end  as Web_Pro_flg ,
case when product_ownership_name_list like '%InstantPage%' then 1 else 0 end  as InstantPage_flg ,
case when product_ownership_name_list like '%Website Builder%' then 1 else 0 end  as Website_Builder_flg ,
case when product_ownership_name_list like '%Websites and Marketing%' then 1 else 0 end  as Websites_and_Marketing_flg ,
case when product_ownership_name_list like '%SSL%' then 1 else 0 end  as SSL_flg ,
case when product_ownership_name_list like '%Website Protection%' then 1 else 0 end  as Website_Protection_flg ,
case when product_ownership_name_list like '%Professional Web Services%' then 1 else 0 end  as Professional_Web_Services_flg ,
case when product_ownership_name_list like '%SmartLine%' then 1 else 0 end  as SmartLine_flg ,
case when product_ownership_name_list like '%Unknown%' then 1 else 0 end  as Unknown_flg ,
case when product_ownership_name_list like '%CnP Hosting%' then 1 else 0 end  as CnP_Hosting_flg ,
case when product_ownership_name_list like '%Grid%' then 1 else 0 end  as Grid_flg ,
case when product_ownership_name_list like '%Paid Support%' then 1 else 0 end  as Paid_Support_flg ,
case when product_ownership_name_list like '%Shared Hosting%' then 1 else 0 end  as Shared_Hosting_flg ,
case when product_ownership_name_list like '%WordPress Managed Plans%' then 1 else 0 end  as WordPress_Managed_Plans_flg ,
case when product_ownership_name_list like '%Email%' then 1 else 0 end  as Email_flg ,
case when product_ownership_name_list like '%MS Office 365%' then 1 else 0 end  as MS_Office_365_flg ,
case when product_ownership_name_list like '%Online Calendar%' then 1 else 0 end  as Online_Calendar_flg ,
case when product_ownership_name_list like '%Online Storage%' then 1 else 0 end  as Online_Storage_flg ,
case when product_ownership_name_list like '%Open XChange%' then 1 else 0 end  as Open_XChange_flg ,
case when product_ownership_name_list like '%Value Adds%' then 1 else 0 end  as Value_Adds_flg, 

active_product_cnt, 
acq_report_region_2_name,
--hvc_customer_tier, active_venture_count, domain_portfolio_qty, 
acq_isc_channel_name

from bi.dna_approved.shopper_360_current a 
where 
acq_report_region_2_name in ('United States', 'Canada')
and 
shopper_status = 'Active'
;

--select count(shopper_id), count(distinct shopper_id) from GD_data ;

------------------------------------------------------------------------------------------------------------------------

--- adding all domains held by US and CA active shoppers (this query gives domain level features) ---
drop table if exists GD_domains;
create temp table GD_domains as
select a.*, b.domain_name,

--b.tld,
b.primary_hosting_product_type_code,
-- b.primary_hosting_provider_code, b.primary_email_provider_code, 
b.primary_email_product_type_code, 
--b.primary_ssl_provider_code, 
--b.site_published_flag, 
b.hosting_detected_flag, b.email_detected_flag, b.ssl_detected_flag, b.domain_type_code,
b.domain_activation_flag, b.email_activated_only_flag, 
--b.website_likelihood_code, 
--b.industry_classification_code, b.industry_classification_score, b.industry_classification_rollup_code, b.industry_classification_civic_community_commercial_code,
b.industry_classification_brick_and_mortar_business_flag,
b.industry_classification_service_area_business_flag


--row_number() over (partition by a.shopper_id order by billing_create_utc_ts desc ) rows1
from bi.venture_mart.domain_footprint_history b
inner join GD_data a   
on a.shopper_id = b.shopper_id
where load_utc_date in (select max(load_utc_date) from bi.venture_mart.domain_footprint_history)
;


--select count(domain_name), count(distinct domain_name) , count(shopper_id), count(distinct shopper_id) from GD_domains 

-------------------------------------------------------------------------------------------------------------------------

-- all domains held by US and CA active shoppers (found in DataProvider) (this query gives website level features if website available in DataProvider) ---
drop table if exists dp_data ;
create temp table dp_data as
select a.shopper_id, a.domain_name ,
      DATEDIFF(year,  b.first_found_utc_ts, current_date) AS Years_online, 
      b.sic_major_group,
      --b.first_found_utc_ts,
      b.top_level_domain,  
      b.website_type, 
      --b.adsense_id,
      b.web_analytics_program_list,
      --b.brick_and_mortar_flag,
      --b.industry_classification_code,
      b.content_management_system_name,
      --b.crm_name,
      b.ecommerce_certainty_score,
      b.email_service_list,
      --b.generator_tag_info,
      --b.google_ads_count,
      b.live_chat_software,
      --b.multi_language_flag,
      --b.page_type_list,
      b.payment_provider_list,
      b.shopping_cart_system,
      --b.site_traffic_estimation,
      b.ssl_domain_type,
      --b.ssl_issuer_organization,
      b.delivery_service_list,
     --b.zip_code,
      
      
      b.average_load_time_ms, b.brick_and_mortar_probability, b.change_count, b.contact_type_list, b.economic_footprint_score, facebook_follower_count, b.website_update_score_code,
      b.html_size_kb, b.legal_entity_name, b.geographical_map_presence_list, b.mobile_version_flag, b.new_generic_top_level_domain_category, b.online_store_flag,
      b.page_indexed_count, b.page_count, b.payment_method_list, b.phone_number_certainty_score, b.product_count, b.seo_score, 
      b.social_media_platform_list, b.ssl_certificate_flag, b.traffic_index, b.instagram_follower_count, b.twitter_follower_count, b.word_count,
      
      b.ad_network_name, b.forwarding_domain_count, b.security_score, ssl_type 
      
--       case when a.domain_name in (select distinct(entitlement_common_name)
-- from bi.dna_approved.wam_websitebuilder_session 
-- where 
-- (auto_publish_flag=True and airo_flag=True) 
-- ) then 1 else 0 end as airo_flg,

-- case when a.domain_name in (select distinct(entitlement_common_name)
-- from bi.dna_approved.wam_websitebuilder_session 
-- where 
-- current_template_type = 'coming_soon'
-- ) then 1 else 0 end as coming_soon_flg
      
      
      --ROW_NUMBER() OVER() AS num_row
from bi.venture_mart.dataprovider_monthly_cln b
inner join GD_domains a  on UPPER(b.domain_name) = UPPER(a.domain_name) 
and year = '2025' and month = '05' -- last month
;


--select count(domain_name), count(distinct domain_name) , count(shopper_id), count(distinct shopper_id)  from dp_data

------------------------------------------------------------------------------------------------------------------------

-- all domains with their corresponding Industry Classification (IC) model score and domain_based identified industry (industry2)   ---
drop table if exists temp_ic_model ;
create temp table temp_ic_model as
select domain_name, 
model_prediction_score as IC_model_score,
partition_prediction_run_pst_date as IC_model_run_date, 
industry_name as Industry2  
from bi.ml_batch_predictions_cln_spectrum.domain_industry_classification_prediction_history_cln
where partition_prediction_run_pst_date in (select max(partition_prediction_run_pst_date) 
                                          from bi.ml_batch_predictions_cln_spectrum.domain_industry_classification_prediction_history_cln )
                                          

;

--select count(domain_name), count(distinct domain_name)  from temp_ic_model;

------------------------------------------------------------------------------------------------------------------------

-- all domains held by US and CA active shoppers with/without website (with all shopper-level, domain-level, and website-level features) and removing investors and pros ---

drop table if exists data_gd_dp ;
create temp table data_gd_dp as
select a.*,
      b.Years_online, 
      b.sic_major_group,
      --b.first_found_utc_ts,
      b.top_level_domain,  
      b.website_type, 
      --b.adsense_id,
      b.web_analytics_program_list,
      --b.brick_and_mortar_flag,
      --b.industry_classification_code,
      b.content_management_system_name,
      --b.crm_name,
      b.ecommerce_certainty_score,
      b.email_service_list,
      --b.generator_tag_info,
      --b.google_ads_count,
      b.live_chat_software,
      --b.multi_language_flag,
      --b.page_type_list,
      b.payment_provider_list,
      b.shopping_cart_system,
      --b.site_traffic_estimation,
      b.ssl_domain_type,
      --b.ssl_issuer_organization,
      b.delivery_service_list,
     --b.zip_code,
      
      
      b.average_load_time_ms, b.brick_and_mortar_probability, b.change_count, b.contact_type_list, b.economic_footprint_score, facebook_follower_count, b.website_update_score_code,
      b.html_size_kb, b.legal_entity_name, b.geographical_map_presence_list, b.mobile_version_flag, b.new_generic_top_level_domain_category, b.online_store_flag,
      b.page_indexed_count, b.page_count, b.payment_method_list, b.phone_number_certainty_score, b.product_count, b.seo_score, 
      b.social_media_platform_list, b.ssl_certificate_flag, b.traffic_index, b.instagram_follower_count, b.twitter_follower_count, b.word_count,
      
      b.ad_network_name, b.forwarding_domain_count, b.security_score, ssl_type
      
      --b.airo_flg
      --, b.coming_soon_flg
      
      
from GD_domains a 
left join dp_data b 
on lower(a.domain_name) = lower(b.domain_name)

where a.shopper_id not in (select distinct shopper_id from (select count(distinct domain_name) as domains,
                               shopper_id 
                               from GD_domains 
                               group by shopper_id 
                               having count(distinct domain_name) > 50) );-- removing investors and pros
                               
                               
--select count(domain_name), count(distinct domain_name) , count(shopper_id), count(distinct shopper_id) from data_gd_dp ; 

------------------------------------------------------------------------------------------------------------------------

-- all domains held by US and CA active shoppers with/without website (with all shopper-level, domain-level, and website-level features) and their corresponding IC model score and domain-based identified industry (industry2) ---                               


drop table if exists data_gd_dp_IC ;
create temp table data_gd_dp_IC as
select distinct a.*,
b.Industry2 ,
b.IC_model_score,
b.IC_model_run_date
--ROW_NUMBER() OVER(partition by shopper_id order by  IC_model_score desc ) as rows2,
--ROW_NUMBER() OVER(partition by shopper_id order by  IC_model_run_date desc ) as rows3
from data_gd_dp a 
left  join temp_ic_model  b
on a.domain_name = b.domain_name ;


--select count(domain_name), count(distinct domain_name) , count(shopper_id), count(distinct shopper_id) from data_gd_dp_IC;

------------------------------------------------------------------------------------------------------------------------

-- here based on sic_major_group (website_based industry), and industry2 (domain_based identified industry), we define a new industry (indystry3) 

drop table if exists data_gd_Industry ;
create temp table data_gd_Industry  as
select a.*,
case when sic_major_group = 'Agricultural Production - Crops' or sic_major_group = 'Agricultural Production - Crops' or industry2 = 'FARMING' then 'Agricultural Production - Crops'
when sic_major_group = 'Agricultural Services'  or  sic_major_group = 'Agricultural Services'  
or  industry2 in ('ARBORISTS_LUMBER_TRIMMING','DOG_TRAINING','EQUESTRIAN','HOME_LAWNGARDEN_AND_EQUIPMENT','LANDSCAPING','PET_GROOMING_SERVICES','PET_SITTING','PETS') then 'Agricultural Services'
when sic_major_group = 'Amusement and Recreation Services' or sic_major_group = 'Amusement and Recreation Services' 
or industry2 in ('AUTO_RACING_MOTORSPORTS','COMPUTER_SOFTWARE_RELATED','ENTERTAINERS_LOCAL','ENTERTAINMENT','FISHING','FITNESS','FITNESS_GYMS','FITNESS_TRAINERS','GOLF_RELATED','LIFESTYLE_ACTIVE','MUSIC_DJ','MUSIC_MUSICIAN_GROUPS','MUSIC_VENUES_CONCERTS','PERFORMING_ARTS_THEATERS','SOCIAL_CLUBS','SPORTS','SPORTS_BASEBALL','SPORTS_BASKETBALL','SPORTS_LOCAL_ATHLETICS','TICKETS_PROMOTIONS','YOGA') then 'Amusement and Recreation Services'
when sic_major_group = 'Apparel and Accessory Stores'  or sic_major_group = 'Apparel and Accessory Stores'
or industry2 in ('BOUTIQUE_SHOPS','CHILD_BABY_CLOTHING_ACCESSORIES','CLOTHES_ATHLETIC_GEAR','CLOTHES_TSHIRTS','CLOTHING','CLOTHING_MENS','CLOTHING_SHOES','FASHION_DESIGN','FASHION_STYLE_RELATED','FASHION_WOMENS_CLOTHING') then 'Apparel and Accessory Stores'
when  sic_major_group = 'Automotive Dealers and Gasoline Service Stations' or sic_major_group = 'Automotive Dealers and Gasoline Service Stations'
or industry2 in ('AUTO_DEALERS','AUTO_SALES_ACCESSORIES_INFORMATIONAL') then 'Automotive Dealers and Gasoline Service Stations'
when sic_major_group = 'Automotive Repair, Services, and Parking'or sic_major_group = 'Automotive Repair, Services, and Parking'
or industry2 in ('AUTO_BODY_REPAIR','AUTO_CLEANING_DETAIL_WASH','AUTO_PARTS','AUTO_RELATED','AUTO_REPAIR', 'TOWING_SERVICES') then 'Automotive Repair, Services, and Parking'
when sic_major_group = 'Building Construction General Contractors and Operative Builders' or sic_major_group = 'Building Construction General Contractors and Operative Builders'
or industry2 in ('CONSTRUCTION','HOME_CONSTRUCTION_RELATED','HOME_CONTRACTORS') then 'Building Construction General Contractors and Operative Builders'
when sic_major_group = 'Building Materials, Hardware, Garden Supply, and Mobile Home Dealers'  or sic_major_group = 'Building Materials, Hardware, Garden Supply, and Mobile Home Dealers' 
or industry2 in ('ART') then 'Building Materials, Hardware, Garden Supply, and Mobile Home Dealers' 
when sic_major_group in  ('Business Services', 'Business services') or sic_major_group in ('Business Services', 'Business services')
or industry2 in ('ADULT_ENTERTAINMENT','ADVERTISING','AERIAL_DRONE_PHOTOGRAPHY_VIDEOGRAPHY','ARTISTS','AUTO_SALES_SERVICE_ACCESSORIES','BLOGS','BOOKS_AND_BOOK_REVIEWS','BUSINESS_ADVERTISING','BUSINESS_GENERAL','BUSINESS_JANITORIAL_SERVICES','BUSINESS_SERVICES','CARDS_STATIONARY_PLAYING_TRADE','CAREER_COACHING_DEVELOPMENT','CLEANING_SERVICES','COMPUTER_RELATED','COMPUTER_SECURITY','CREDIT_DEBT_SOLUTIONS','CRYPTO_AND_CURRENCY_RELATED','EMPLOYMENT_STAFFING_RECRUITING','EVENTS','FINANCIAL_SERVICES','GAMES','GRAPHIC_DESIGN','HEALTH_CONSULTANT','HOME_CLEANING','HOME_INSPECTION','HOME_INTERIOR_DESIGN','HOME_RELATED','HOME_SERVICES','INFORMATION_LIFESTYLE','INFORMATION_RELATED','INFORMATION_TECHNOLOGY','INTERNET_MARKETING','IT_SERVICES','JOBS_RELATED','MEDIA','MEDIA_ARTS_PODCASTS_TORRENTS','MEDIA_RELATED','MODELS_TALENT','MUSIC_MUSICIANS_INSTRUMENTSTORES','MUSIC_PRODUCTION_SERVICES','NOTARIES','OUTDOOR_GEAR_ACTIVITIES','PARTY_RENTALS','PERSONAL','PERSONAL_ADMIN_ASSISISTANTS','PERSONAL_FAMILY','PERSONAL_PORTFOLIO_SHOWCASE_RELATED','PEST_CONTROL','PHONE_RELATED','PRIVATE_INVESTIGATORS','PROFESSIONAL','PROMOTIONAL_SERVICES','PSYCHIC_ASTROLOGY','PUBLIC_SPEAKING_MOTIVATIONAL','REAL_ESTATE','RETAIL_ECOMMERCE_RELATED','SCIENCE_TECHNOLOGY','SECURITY_SERVICES','SECURITY_SYSTEMS_PRODUCTS','SHOPPING_RELATED','SOFTWARE_APPLICATION_RELATED','VIDEO_GAMES','WEB_DESIGN') then 'Business Services'
when sic_major_group = 'Communications' or sic_major_group = 'Communications'
or industry2 in ('RADIO_AND_PODCASTS','TELECOM_RELATED') then 'Communications'
when sic_major_group = 'Construction Special Trade Contractors' or sic_major_group = 'Construction Special Trade Contractors'
or industry2 in ('ELECTRICAL_ELECTRICIANS','HOME_PAINTERS_AND_SUPPLIES','HOME_REPAIR_AND REMODELING','HOME_ROOFING_COMPANIES','HVAC_PLUMBING_HEATING_RELATED','HVAC_PLUMBING_SERVICES','SOLAR_RELATED') 
then 'Construction Special Trade Contractors'
when sic_major_group = 'Depository Institutions' or sic_major_group = 'Depository Institutions'
or industry2 in ('FINANCIAL_SERVICES_BANKS') then 'Depository Institutions'
when sic_major_group = 'Eating and Drinking Places' or sic_major_group in ('Eating and Drinking Places', 'Eating Place', 'Eating place', 'Drinking place')
or industry2 in  ('COFFEE_TEA','FOOD','FOOD_CHEFS_CATERING','FOOD_DRINK_INFORMATIONAL','FOOD_RELATED','FOOD_TRUCKS','RESTAURANTS','RESTAURANTS_CAFE','RESTAURANTS_PIZZA')
then 'Eating and Drinking Places'
when sic_major_group = 'Educational Services' or sic_major_group = 'Educational Services'
or industry2 in ('EDUCATION','EDUCATION_DISABILITIES_HELP','EDUCATION_SCHOOLS','MUSIC','TUTORS') then 'Educational Services'
when sic_major_group = 'Engineering, Accounting, Research, Management, and Related Services'
or sic_major_group = 'Engineering, Accounting, Research, Management, and Related Services'
or industry2 in ('ARCHITECTS_RELATED','BUSINESS_DEVELOPMENT_SERVICES','BUSINESS_SERVICES_BOOKKEEPING','CONSTRUCTION_MANAGEMENT','EDUCATION_CONSULTANTS_SERVICES','ENERGY_POWER_UTILITY_RELATED','ENGINEERING_RELATED','FINANCE_CONSULTING_INFORMATIONAL','FINANCIAL_INVESTING','GENERAL_BUSINESS_CONSULTING','HUMAN_RESOURCES','MARKETING_RELATED','PUBLIC_RELATIONS_COMMUNICATIONS') then 'Engineering, Accounting, Research, Management, and Related Services'
when sic_major_group = 'Executive, Legislative, and General Government, except Finance'
or sic_major_group = 'Executive, Legislative, and General Government, except Finance'
or industry2 in ('GOVERNMENT_LOCAL_SERVICES_POLITICS') then 'Executive, Legislative, and General Government, except Finance'
when sic_major_group = 'Fabricated Metal Products, except Machinery and Transportation Equipment'
or sic_major_group = 'Fabricated Metal Products, except Machinery and Transportation Equipment'
or industry2 in ('MANUFACTURING') then 'Fabricated Metal Products, except Machinery and Transportation Equipment'
when sic_major_group = 'Food Stores' or sic_major_group = 'Food Stores'
or industry2 in ('BAKERIES','GROCERY') then 'Food Stores'
when sic_major_group = 'Health Services' or sic_major_group in ('Health Services', 'Health/allied services')
or industry2 in ('DENTIST_ORTHODONTISTS','HEALTH','HEALTH_CARE','HEALTH_WEIGHT_LOSS','HEALTH_WELLNESS','MEDICAL','MEDICAL_ALTERNATIVE','NUTRITIONISTS','PYSCHOLOGY_THERAPY') then 'Health Services'
when sic_major_group = 'Home Furniture, Furnishings, and Equipment Stores' or sic_major_group = 'Home Furniture, Furnishings, and Equipment Stores'
or industry2 in ('FURNITURE_SALES_MANUFACTURING', 'HOME_DECOR', 'HOME_FURNISHINGS_CABINETS_STAIRS') then 'Home Furniture, Furnishings, and Equipment Stores'
when sic_major_group = 'Hotels, Rooming Houses, Camps, and other Lodging Places' or sic_major_group = 'Hotels, Rooming Houses, Camps, and other Lodging Places'
or industry2 in ('HOTELS','VACATION_RENTALS') then 'Hotels, Rooming Houses, Camps, and other Lodging Places'
when sic_major_group = 'Insurance Agents, Brokers and Service' or sic_major_group = 'Insurance Agents, Brokers and Service'
or industry2 in ('INSURANCE') then 'Insurance Agents, Brokers and Service'
when sic_major_group = 'Justice, Public Order, and Safety' or sic_major_group = 'Justice, Public Order, and Safety'
or industry2 in ('VOLUNTEER_ORGANIZATIONS') then 'Justice, Public Order, and Safety'
when sic_major_group = 'Miscellaneous Retail' or sic_major_group = 'Miscellaneous Retail'
or industry2 in ('ACCESSORIES','ANTIQUES_SALVAGE_COLLECTIBLES','ARTS_CRAFTS','BEER_WINE_SPIRITS','BOOKS_STORES','CANDLES_SCENTS','CANNABIS_RELATED','COSMETICS','FLORISTS','FLOWERS','GIFTS','GUNS_KNIVES','JEWELRY','JEWELRY_METALS_GEMS','MOTORCYCLE_MODEL_SCOOTER_RELATED','PET_DOGS_STORE_SERVICES','STORES_CONSIGNMENT_VINTAGE_ANTIQUE','TOBACCO_VAPING_PRODUCTS_SHOPS','TOY_STORES') then 'Miscellaneous Retail'
when sic_major_group = 'Personal Services' or sic_major_group = 'Personal Services'
or industry2 in ('ADULT_DATING','BARBERS','BEAUTY_HAIR','BEAUTY_RELATED','BEAUTY_SALON_SPA','CARPET_CLEANING','COSMETICS_RELATED','FINANCIAL_TAX_SERVICES_RELATED','HOME_REPAIR','LIFECOACH','MASSAGE','PHOTOGRAPHY','SKIN_CARE_PRODUCTS_INFORMATION','TATTOOS_PIERCING','WEDDING_SERVICES','WEDDINGS_SERVICES_PLANNING') then 'Personal Services'
when sic_major_group = 'Real Estate' or sic_major_group in ('Real Estate', 'Real estate agent/manager')
or industry2 in ('REAL_ESTATE_AGENTS','REAL_ESTATE_COMMERCIAL','REAL_ESTATE_DEVELOPMENT','REAL_ESTATE_INFORMATIONAL','REAL_ESTATE_SERVICES') then 'Real Estate'
when sic_major_group = 'Wholesale Trade-Nondurable Goods' or sic_major_group in  ('Wholesale Trade-Nondurable Goods', 'Whol nondurable goods')
or industry2 in ('AGRICULTURE_GOODS_SERVICES','BUSINESS_FINANCIAL_TRADE','EXPORTS_IMPORTS_PRODUCTS','FOOD_PRODUCTS','HEALTH_PRODUCTS','HEALTH_PRODUCTS_VITAMINS_SUPPLEMENTS','OIL_PETROLEUM_GAS_INDUSTRIES','WHOLESALE_STORES') then 'Wholesale Trade-Nondurable Goods'
when sic_major_group = 'Membership Organizations' or sic_major_group in ('Membership Organizations', 'Membership organization')
or industry2 in ('BUSINESS_TRADE','CHARITABLE_ORGANIZATIONS','COMMUNITY_ORGANIZATIONS','COMMUNITY_ORGANIZATIONS_CLUBS','FUNDRAISING_RELATED','NONPROFIT','POLITICS','RELIGION','RELIGION_ORGANIZATIONS','RELIGION_PLACES','VETERANS_CLUBS_CAUSES_RELATED','YOUTH_ORGANIZATIONS') then 'Membership Organizations'
when sic_major_group = 'Legal Services' or sic_major_group = 'Legal Services'
or industry2 in ('LAWYERS','LEGAL_SERVICES') then 'Legal Services'
when sic_major_group = 'Local and Suburban Transit and Interurban Highway Passenger Transportation'
or sic_major_group = 'Local and Suburban Transit and Interurban Highway Passenger Transportation'
or industry2 in ('TRANSPORTATION_RELATED','TRANSPORTATION_TAXI') then 'Local and Suburban Transit and Interurban Highway Passenger Transportation'
when sic_major_group = 'Lumber and Wood Products, except Furniture' or sic_major_group = 'Lumber and Wood Products, except Furniture'
or industry2 in ('WOODWORKING') then 'Lumber and Wood Products, except Furniture'
when sic_major_group = 'Miscellaneous Repair Services' or sic_major_group = 'Miscellaneous Repair Services'
or industry2 in ('HOME_APPLIANCE','LOCKSMITHS','MOBILE_CELLULAR_WIRELESS','REPAIR_SERVICES_ELECTRONICS') then 'Miscellaneous Repair Services'
when sic_major_group = 'Miscellaneous Manufacturing Industrie' or sic_major_group = 'Miscellaneous Manufacturing Industrie'
or industry2 in ('SIGNAGE_DISPLAY_DESIGN') then 'Miscellaneous Manufacturing Industrie'
when sic_major_group = 'Motion Pictures' or sic_major_group = 'Motion Pictures'
or industry2 in ('VIDEO_FILM_PRODUCTIONS','VIDEO_PRODUCTION_SERVICES') then 'Motion Pictures'
when sic_major_group = 'Motor Freight Transportation and Warehousing'
or sic_major_group = 'Motor Freight Transportation and Warehousing'
or industry2 in ('DELIVERY_SERVICES','MOVING_STORAGE','TRANSPORTATION_SHIPPING_TRUCKING') then 'Motor Freight Transportation and Warehousing'
when sic_major_group = 'Museums, Art Galleries, and Botanical and Zoological Gardens'
or sic_major_group = 'Museums, Art Galleries, and Botanical and Zoological Gardens'
or industry2 in ('GALLERIES') then 'Museums, Art Galleries, and Botanical and Zoological Gardens'
when sic_major_group = 'Non-Depository Credit Institutions' or sic_major_group = 'Non-Depository Credit Institutions'
or industry2 in ('FINANCIAL_LOANS','MORTGAGE_LENDING') then 'Non-Depository Credit Institutions'
when sic_major_group = 'Printing, Publishing, and Allied Industries'
or sic_major_group = 'Printing, Publishing, and Allied Industries'
or industry2 in ('CLOTHES_TSHIRTS_PRINTING_EMBROIDERY','COPY_PRINTING_RELATED','MAGAZINES_NEWSPAPERS_PERIODICALS','PUBLISHING') then 'Printing, Publishing, and Allied Industries'
when sic_major_group = 'Social Services' or sic_major_group = 'Social Services'
or industry2 in ('CHILDCARE_RELATED','COUNSELING_THERAPY') then 'Social Services'
when sic_major_group = 'Transportation Services' or sic_major_group = 'Transportation Services'
or industry2 in ('LOGISTICS','TRAVEL','TRAVEL_RELATED') then 'Transportation Services'
when sic_major_group = 'Wholesale Trade-Durable Goods' or sic_major_group in  ('Wholesale Trade-Durable Goods', 'Whol durable goods')
or industry2 in ('ELECTRONICS_RELATED','INDUSTRIAL_RELATED') then 'Wholesale Trade-Durable Goods' 
when sic_major_group is null or sic_major_group is null then 'Unknown' 
else 'Others'
end as industry3
from data_gd_dp_IC  a ;
--where rows2 = 1;


--select count(domain_name), count(distinct domain_name) , count(shopper_id), count(distinct shopper_id) from data_gd_Industry;

------------------------------------------------------------------------------------------------------------------------

-- now we need to pick one domain for each shopper
-- for shoppers with at least one website we choose domain with the best website (in terms of website_type, word_count, years_online)
-- for shoppers with no website we choose domain with the highest IC score

drop table if exists data_final ;
create temp table data_final  as

WITH website_biz AS (
    -- Identify shoppers that have at least one website (or non-null 'word_count'), or you can just choose all shoppers found in dp_data
    SELECT DISTINCT shopper_id
    FROM data_gd_Industry
    WHERE word_count IS NOT NULL
),

filtered_1 AS (
    -- Select only those shoppers from website_biz table
    SELECT *
    FROM data_gd_Industry
    WHERE shopper_id IN (SELECT shopper_id FROM website_biz)
),

filtered_2 AS (
    -- Select shoppers NOT in website_biz table
    SELECT *
    FROM data_gd_Industry
    WHERE shopper_id NOT IN (SELECT shopper_id FROM website_biz)
),

selected_1 AS (
    -- for shoppers from website_biz table, select domain with the best website (with website type business or ecommerce then highest  'word_count', then highest 'years_online', then highest 'ic_model_score')
    SELECT * 
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY shopper_id 
                                  ORDER BY 
                                  
                                  --case
                                  --when airo_flg=0 then 0
                                  --when airo_flg=1 then 1
                                  --else 2
                                  --end,

                                  CASE 
                                  WHEN website_type = 'Business' THEN 1  -- Highest priority
                                  WHEN website_type = 'eCommerce' THEN 2  -- Second priority
                                  ELSE 3  -- All other types
                                  END,
                                  COALESCE(word_count, -1) DESC, 
                                  COALESCE(years_online, -1) DESC, 
                                  COALESCE(ic_model_score, -1) DESC) AS rn
        FROM filtered_1
    ) ranked
    WHERE rn = 1
),

selected_2 AS (
--    -- for shoppers NOT in website_biz, select the domain with highest 'ic_model_score' 
    SELECT * 
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY shopper_id 
                                   ORDER BY COALESCE(ic_model_score, -1) DESC) AS rn
        FROM filtered_2
    ) ranked
    WHERE rn = 1
)

-- Step 4: Union both selections
SELECT * FROM selected_1
UNION ALL
SELECT * FROM selected_2;

--select count(domain_name), count(distinct domain_name) , count(shopper_id), count(distinct shopper_id) from data_final;

------------------------------------------------------------------------------------------------------------------------

-- add num_row to each row of the final table, this table has about 10.5M records
drop table if exists data_final_2 ;
create temp table data_final_2  as

select a.*, ROW_NUMBER() OVER() AS num_row
from data_final a ;

--select count(domain_name), count(distinct domain_name) , count(shopper_id), count(distinct shopper_id) from data_final_2;

------------------------------------------------------------------------------------------------------------------------


-- download the final table in 1M batches
SELECT * FROM data_final_2
WHERE num_row > 0
ORDER BY num_row
LIMIT 1000000;














