--女教皇の錫杖 (Anime)
--Empress's Staff (Anime)
function c513000097.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c513000097.condition)
	e1:SetTarget(c513000097.target)
	e1:SetOperation(c513000097.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c513000097.handcon)
	e2:SetDescription(aux.Stringc513000097(c513000097,0))
	c:RegisterEffect(e2)
end
function c513000097.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()~=nil
end
function c513000097.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local p=Duel.GetAttacker():GetControler()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,p,500)
end
function c513000097.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		local p=Duel.GetAttacker():GetControler()
		Duel.SkipPhase(p,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
		Duel.BreakEffect()
		Duel.Damage(p,500,REASON_EFFECT)
	end
end
function c513000097.handcon(e)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)==0
end