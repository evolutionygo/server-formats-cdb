--王虎ワンフー
--King Tiger Wanghu (GOAT)
--Triggers on its own summon
function c504700143.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700143(c504700143,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c504700143.condition)
	e1:SetTarget(c504700143.target)
	e1:SetOperation(c504700143.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c504700143.filter(c,e)
	return c:IsFaceup() and c:IsAttackBelow(1400) and (not e or c:IsRelateToEffect(e))
end
function c504700143.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c504700143.filter,1,nil) and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
end
function c504700143.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c504700143.filter,nil)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c504700143.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=eg:Filter(c504700143.filter,nil,e)
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end