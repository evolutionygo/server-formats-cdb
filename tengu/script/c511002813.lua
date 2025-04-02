--異次元からの埋葬
function c511002813.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002813.target)
	e1:SetOperation(c511002813.activate)
	c:RegisterEffect(e1)
end
function c511002813.filter(c)
	return c:IsFaceup() and c:IsMonster()
end
function c511002813.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511002813.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,#g,PLAYER_ALL,LOCATION_REMOVED)
end
function c511002813.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002813.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_RETURN)
	end
end