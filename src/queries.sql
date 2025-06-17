--- getting all US and CA active shoppers---
drop table if exists GD_data;
create temp table GD_data as
select shopper_id,
total_gcr_usd_amt,
case when shopper_id in ( select distinct shopper_id
                             from bi.ba_commerce.cohort_combine_final) then 'identifed_PS' else 'not_identifed_PS' end as Identified_PS_flg,
case when shopper_id in (select distinct godaddy_shopper_id
                                  from bi.poynt_spectrum.payfac_application_cln
                                  where  snap_date = current_date - 1
                                   and application_level = 'FULL'
                                  and original_intent = 'CREATE_BUSINESS'
                                  and risk_decision = 'APPROVED'
                                  and business_uuid is not null) then 'GDP Customer' else 'Not a GDP cutsomer' end as GDP_flg,   
case when shopper_id  in ( select distinct shopper_id from bi.dna_approved.uds_order
                            where pf_id in(1339765,1339759, 1339761)
                            and exclude_reason_desc is null
                            and order_fraud_flag = False
                            and LENGTH(shopper_id) > 3) then 'Hardware Purchased' else 'NA' end as Hardware_flg,
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

hvc_customer_tier, active_venture_count, domain_portfolio_qty, acq_isc_channel_name

from bi.dna_approved.shopper_360_current a 
where 
acq_report_region_2_name in ('United States', 'Canada')
and 
shopper_status = 'Active'
;