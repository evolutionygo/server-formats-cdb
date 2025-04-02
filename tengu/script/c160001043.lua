--闇の訪れ
--Darkness Approaches (Rush Duel)
function c160001043.initial_effect(c)
	--Change 1 monster on the field to face-down defense
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c160001043.cost)
	e1:SetTarget(c160001043.target)
	e1:SetOperation(c160001043.activate)
	c:RegisterEffect(e1)
end
function c160001043.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,e:GetHandler()) end
end
function c160001043.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet() and c:IsCanChangePositionRush()
end
function c160001043.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c160001043.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.GetMatchingGroup(c160001043.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #g>0 then
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	end
end
function c160001043.activate(e,tp,eg,ep,ev,re,r,rp)
	--Requirement
	Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST+REASON_DISCARD)
	--Effect
	local tc=Duel.SelectMatchingCard(tp,c160001043.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil):GetFirst()
	Duel.HintSelection(Group.FromCards(tc))
	if tc and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end