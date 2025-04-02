--燃え上がる大海
--High Tc32542011e on Fire Island
function c32542011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc32542011(c32542011,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c32542011.condition)
	e1:SetTarget(c32542011.target)
	e1:SetOperation(c32542011.activate)
	c:RegisterEffect(e1)
end
function c32542011.cfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(7) and c:IsAttribute(ATTRIBUTE_WATER|ATTRIBUTE_FIRE)
end
function c32542011.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32542011.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c32542011.cfilter2(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c32542011.spfilter(c,tc32542011,e,tp)
	local re=c:GetReasonEffect()
	return c:GetTurnID()==tc32542011 and c:IsReason(REASON_COST) and re and re:IsActivated() and re:IsMonsterEffect()
		and c:IsAttribute(ATTRIBUTE_WATER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c32542011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local b1=Duel.IsExistingMatchingCard(c32542011.cfilter2,tp,LOCATION_MZONE,0,1,nil,ATTRIBUTE_WATER)
		and ft>0 and Duel.IsExistingMatchingCard(c32542011.spfilter,tp,LOCATION_GRAVE,0,1,nil,Duel.GetTurnCount(),e,tp)
	local b2=Duel.IsExistingMatchingCard(c32542011.cfilter2,tp,LOCATION_MZONE,0,1,nil,ATTRIBUTE_FIRE)
		and Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
	if chk==0 then return b1 or b2 end
	local loc=b2 and LOCATION_MZONE or 0
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,loc,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,tp,0)
	Duel.SetPossibleOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
	Duel.SetPossibleOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c32542011.activate(e,tp,eg,ep,ev,re,r,rp)
	local break_chk=false
	--WATER: Special Summon from the GY
	if Duel.IsExistingMatchingCard(c32542011.cfilter2,tp,LOCATION_MZONE,0,1,nil,ATTRIBUTE_WATER) then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local ct=Duel.GetMatchingGroupCount(aux.NecroValleyFilter(c32542011.spfilter),tp,LOCATION_GRAVE,0,nil,Duel.GetTurnCount(),e,tp)
		ft=math.min(ft,ct)
		if ft>0 then
			if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then ft=1 end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c32542011.spfilter),tp,LOCATION_GRAVE,0,ft,ft,nil,Duel.GetTurnCount(),e,tp)
			if #g>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
				break_chk=true
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
				local dg=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,0,1,1,nil)
				if #dg>0 then
					Duel.HintSelection(dg,true)
					Duel.BreakEffect()
					Duel.Destroy(dg,REASON_EFFECT)
				end
			end
		end
	end
	--FIRE: Destroy 1 monster on the field
	if Duel.IsExistingMatchingCard(c32542011.cfilter2,tp,LOCATION_MZONE,0,1,nil,ATTRIBUTE_FIRE) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		if #g>0 then
			Duel.HintSelection(g,true)
			if break_chk then Duel.BreakEffect() end
			if Duel.Destroy(g,REASON_EFFECT)>0 and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 then
				Duel.BreakEffect()
				Duel.DiscardHand(tp,nil,1,1,REASON_DISCARD+REASON_EFFECT)
			end
		end
	end
end