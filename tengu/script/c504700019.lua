--トラップ処理班 Aチーム
--A-Team: Trap Disposal Unit (GOAT)
--Usable in the damage step only if it doesn't relate to battle
function c504700019.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc504700019(c504700019,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c504700019.condition)
	e1:SetCost(c504700019.cost)
	e1:SetTarget(c504700019.target)
	e1:SetOperation(c504700019.activate)
	c:RegisterEffect(e1)
	aux.DoubleSnareValc504700019ity(c,LOCATION_MZONE)
end
function c504700019.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not (Duel.GetCurrentPhase()==PHASE_DAMAGE and (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c))
		and not c:IsStatus(STATUS_BATTLE_DESTROYED) and rp~=tp
		and re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c504700019.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c504700019.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c504700019.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end