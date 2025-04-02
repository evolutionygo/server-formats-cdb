--リチュアの写魂鏡
--Gishki Photomirror
function c9236985.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9236985.target)
	e1:SetOperation(c9236985.activate)
	c:RegisterEffect(e1)
	if not c9236985.ritual_matching_function then
		c9236985.ritual_matching_function={}
	end
	c9236985.ritual_matching_function[c]=aux.FilterEqualFunction(Card.IsSetCard,0x3a)
end
c9236985.listed_series={0x3a}
function c9236985.filter(c,e,tp,lp)
	if not c:IsRitualMonster() or not c:IsSetCard(0x3a) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false) then
		return false
	end
	return lp>c:GetLevel()*500
end
function c9236985.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local lp=Duel.GetLP(tp)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c9236985.filter,tp,LOCATION_HAND,0,1,nil,e,tp,lp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c9236985.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local lp=Duel.GetLP(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c9236985.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,lp)
	local tc=tg:GetFirst()
	if tc then
		mustpay=true
		Duel.PayLPCost(tp,tc:GetLevel()*500)
		mustpay=false
		tc:SetMaterial(nil)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end