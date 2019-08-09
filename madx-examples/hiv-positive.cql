

parameter "Measurement Period" Interval<DateTime>

context Patient


;; The Patient should have an associated Condition resource that indicates that the patient is HIV+
;;
;; Requires:
;; * Condition.code is the  SNOMED code 165816005
;; * Condition.verificationStatus, if present should be one of confirmed or provisional



define "HIV Positive":
       with distinct (
       		[ "Condition, code"  :  "165816005" ] HIVConditions
		  where verificationStatus is "confirmed"
		union
		[ "Condition, code"  :  "165816005" ] HIVConditions
		  where verificationStatus is "provisional"
		union
		[ "Condition, code"  :  "165816005" ] HIVConditions
		  where verificationStatus is not set
		)

define "Cohort":
       exists ("HIV Positive")


