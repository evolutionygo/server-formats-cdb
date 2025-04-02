-- Fire Ant Ascator (anime)
function c511009950.initial_effect(c)
	-- shuffle
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511009950(c511009950,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511009950.target)
	e1:SetOperation(c511009950.operation)
	c:RegisterEffect(e1)
end
c511009950.listed_names={78275321}
function c511009950.filter(c)
	return c:IsCode(78275321) and c:IsAbleToDeck()
end
function c511009950.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009950.filter,tp,LOCATION_GRAVE,0,2,nil) end
	local g=Duel.GetMatchingGroup(c511009950.filter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,#g,0,0)
end
function c511009950.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009950.filter,tp,LOCATION_GRAVE,0,nil)
	if #g>0 then
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end