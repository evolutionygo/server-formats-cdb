--ハウスダストン
--House Duston
function c40343749.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc40343749(c40343749,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c40343749.condition)
	e1:SetTarget(c40343749.target)
	e1:SetOperation(c40343749.operation)
	c:RegisterEffect(e1)
end
c40343749.listed_series={0x80}
function c40343749.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_BATTLE) then
		return c:GetReasonPlayer()~=tp and c:GetBattlePosition()&POS_FACEUP~=0
	end
	return rp~=tp and c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp)
end
function c40343749.filter1(c,e,tp)
	return c:IsSetCard(0x80) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c40343749.filter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,c,e,tp)
end
function c40343749.filter2(c,e,tp)
	return c:IsSetCard(0x80) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function c40343749.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		and Duel.IsExistingMatchingCard(c40343749.filter1,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK+LOCATION_HAND)
end
function c40343749.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then return end
	local g1=Duel.GetMatchingGroup(c40343749.filter1,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(c40343749.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)<=0
		or #g1<=0 or #g2<=0 then return end
	local sg1
	local sg2
	local tc
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringc40343749(c40343749,1))
		sg1=Duel.SelectMatchingCard(tp,c40343749.filter1,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
		tc=sg1:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringc40343749(c40343749,2))
		sg2=Duel.SelectMatchingCard(tp,c40343749.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
		tc=sg2:GetFirst()
		Duel.SpecialSummon(tc,0,tp,1-tp,false,false,POS_FACEUP)
		g1=Duel.GetMatchingGroup(c40343749.filter1,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
		g2=Duel.GetMatchingGroup(c40343749.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
	until not (Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		and #g1>0 and #g2>0
		and Duel.SelectYesNo(tp,aux.Stringc40343749(c40343749,3)))
end