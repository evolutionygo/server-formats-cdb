--ブリザード・サンダーバード
function c50920465.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc50920465(c50920465,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,c50920465)
	e1:SetCost(c50920465.cost)
	e1:SetTarget(c50920465.target)
	e1:SetOperation(c50920465.operation)
	c:RegisterEffect(e1)
end
c50920465.listed_names={c50920465}
function c50920465.cfilter(c,e,tp)
	return c:IsDiscardable() and Duel.IsExistingMatchingCard(c50920465.filter,tp,LOCATION_HAND,0,1,c,e,tp)
end
function c50920465.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50920465.cfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.DiscardHand(tp,c50920465.cfilter,1,1,REASON_COST+REASON_DISCARD,nil,e,tp)
end
function c50920465.filter(c,e,tp)
	return c:IsRace(RACE_WINGEDBEAST) and c:IsAttribute(ATTRIBUTE_WATER)
		and not c:IsCode(c50920465) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c50920465.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c50920465.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c50920465.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g1=Duel.GetMatchingGroup(c50920465.filter,tp,LOCATION_HAND,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(aux.NecroValleyFilter(c50920465.filter),tp,LOCATION_GRAVE,0,nil,e,tp)
	if #g1==0 or #g2==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg2=g2:Select(tp,1,1,nil)
	sg1:Merge(sg2)
	Duel.SpecialSummon(sg1,0,tp,tp,false,false,POS_FACEUP)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.BreakEffect()
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	end
end