# Terraform PANOS Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform PANOS).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFPAN_001 | resource | panos | Verify that PAN-OS credentials are not hardcoded in the provider configuration | checker/terraform/rules/pan/panos_no_hardcoded_in_provider.rego |
| CB_TFPAN_002 | resource | panos_management_profile | Verify that Interface Management Profiles do not have plain-text management HTTP activated | checker/terraform/rules/pan/panos_management_profile_http_disabled.rego |
| CB_TFPAN_003 | resource | panos_management_profile | Verify that Interface Management Profiles do not have plain-text management Telnet activated | checker/terraform/rules/pan/panos_management_profile_telnet_disabled.rego |
| CB_TFPAN_004 | resource | panos_security_policy | Verify that the Disable Server Response Inspection (DSRI) is not activated in security policies | checker/terraform/rules/pan/panos_security_policy_dsri_disabled.rego |
| CB_TFPAN_004 | resource | panos_security_rule_group | Verify that the Disable Server Response Inspection (DSRI) is not activated in security policies | checker/terraform/rules/pan/panos_security_policy_dsri_disabled.rego |
| CB_TFPAN_005 | resource | panos_security_policy | Verify that security rules do not utilize 'any' for the 'applications' attribute | checker/terraform/rules/pan/panos_security_policy_apps_any_restricted.rego |
| CB_TFPAN_005 | resource | panos_security_rule_group | Verify that security rules do not utilize 'any' for the 'applications' attribute | checker/terraform/rules/pan/panos_security_policy_apps_any_restricted.rego |
| CB_TFPAN_006 | resource | panos_security_policy | Verify that security rules do not specify 'any' for the 'services' attribute | checker/terraform/rules/pan/panos_security_policy_services_not_set_to_any.rego |
| CB_TFPAN_006 | resource | panos_security_rule_group | Verify that security rules do not specify 'any' for the 'services' attribute | checker/terraform/rules/pan/panos_security_policy_services_not_set_to_any.rego |
| CB_TFPAN_007 | resource | panos_security_policy | Verify that security rules do not have both 'source_addresses' and 'destination_addresses' set to 'any' | checker/terraform/rules/pan/panos_security_policy_source_destination_add_restrict_any.rego |
| CB_TFPAN_007 | resource | panos_security_rule_group | Verify that security rules do not have both 'source_addresses' and 'destination_addresses' set to 'any' | checker/terraform/rules/pan/panos_security_policy_source_destination_add_restrict_any.rego |
| CB_TFPAN_008 | resource | panos_security_policy | Verify that security policies have descriptions filled in | checker/terraform/rules/pan/panos_security_policy_contains_security_policies.rego |
| CB_TFPAN_008 | resource | panos_security_rule_group | Verify that security policies have descriptions filled in | checker/terraform/rules/pan/panos_security_policy_contains_security_policies.rego |
| CB_TFPAN_009 | resource | panos_security_policy | Verify that a Log Forwarding Profile is designated for every security policy rule | checker/terraform/rules/pan/panos_security_policy_log_forwarding_profile.rego |
| CB_TFPAN_009 | resource | panos_security_rule_group | Verify that a Log Forwarding Profile is designated for every security policy rule | checker/terraform/rules/pan/panos_security_policy_log_forwarding_profile.rego |
| CB_TFPAN_010 | resource | panos_security_policy | Confirm that logging at the end of sessions is activated in security policies | checker/terraform/rules/pan/panos_security_policy_session_end_enabled.rego |
| CB_TFPAN_010 | resource | panos_security_rule_group | Confirm that logging at the end of sessions is activated in security policies | checker/terraform/rules/pan/panos_security_policy_session_end_enabled.rego |
| CB_TFPAN_011 | resource | panos_ipsec_crypto_profile | Verify that IPsec profiles do not indicate the utilization of vulnerable encryption algorithms | checker/terraform/rules/pan/panos_ipsec_crypto_profile_insecure_encryption.rego |
| CB_TFPAN_011 | resource | panos_panorama_ipsec_crypto_profile | Verify that IPsec profiles do not indicate the utilization of vulnerable encryption algorithms | checker/terraform/rules/pan/panos_ipsec_crypto_profile_insecure_encryption.rego |
| CB_TFPAN_012 | resource | panos_ipsec_crypto_profile | Guarantee that IPsec profiles do not employ insecure authentication algorithms | checker/terraform/rules/pan/panos_ipsec_crypto_profile_insecure_authentication.rego |
| CB_TFPAN_012 | resource | panos_panorama_ipsec_crypto_profile | Guarantee that IPsec profiles do not employ insecure authentication algorithms | checker/terraform/rules/pan/panos_ipsec_crypto_profile_insecure_authentication.rego |
| CB_TFPAN_013 | resource | panos_ipsec_crypto_profile | Guarantee that IPsec profiles do not indicate the utilization of vulnerable protocols | checker/terraform/rules/pan/panos_ipsec_crypto_profile_insecure_protocols.rego |
| CB_TFPAN_013 | resource | panos_panorama_ipsec_crypto_profile | Guarantee that IPsec profiles do not indicate the utilization of vulnerable protocols | checker/terraform/rules/pan/panos_ipsec_crypto_profile_insecure_protocols.rego |
| CB_TFPAN_014 | resource | panos_panorama_zone | Guarantee that Security Zones have Zone Protection Profiles specified | checker/terraform/rules/pan/panos_panorama_zone_protection_profile.rego |
| CB_TFPAN_014 | resource | panos_zone | Guarantee that Security Zones have Zone Protection Profiles specified | checker/terraform/rules/pan/panos_panorama_zone_protection_profile.rego |
| CB_TFPAN_014 | resource | panos_zone_entry | Guarantee that Security Zones have Zone Protection Profiles specified | checker/terraform/rules/pan/panos_panorama_zone_protection_profile.rego |
| CB_TFPAN_015 | resource | panos_panorama_zone | Guarantee that a Zone has an Include ACL specified when User-ID is activated | checker/terraform/rules/pan/panos_panorama_zone_acl_defined.rego |
| CB_TFPAN_015 | resource | panos_zone | Guarantee that a Zone has an Include ACL specified when User-ID is activated | checker/terraform/rules/pan/panos_panorama_zone_acl_defined.rego |