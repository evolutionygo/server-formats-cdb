--アマゾネス転生術
--Amazoness Shamanism
function c6459419.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc6459419(c6459419,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c6459419.target)
	e1:SetOperation(c6459419.activate)
	c:RegisterEffect(e1)
end
c6459419.listed_series={SET_AMAZONESS}
function c6459419.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsSetCard,SET_AMAZONESS),tp,LOCATION_MZONE,0,nil)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	Duel.SetPossibleOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c6459419.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(SET_AMAZONESS) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c6459419.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsSetCard,SET_AMAZONESS),tp,LOCATION_MZONE,0,nil)
	if #dg==0 then return end
	local ct=Duel.Destroy(dg,REASON_EFFECT)
	local ft=math.min(ct,Duel.GetLocationCount(tp,LOCATION_MZONE))
	if ft==0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then ft=1 end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c6459419.spfilter),tp,LOCATION_GRAVE,0,nil,e,tp)
	if #g>0 and Duel.SelectYesNo(tp,aux.Stringc6459419(c6459419,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,ft,nil)
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end