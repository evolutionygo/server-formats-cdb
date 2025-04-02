--Ａ・Ｏ・Ｊ サウザンド・アームズ
--Ally of Justice Thousand Arms
function c85876417.initial_effect(c)
	--Can attack all face-up LIGHT monsters your opponent controls
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(function(_,c) return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT) end)
	c:RegisterEffect(e1)
	--Destroy this card if it battles a non-LIGHT monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc85876417(c85876417,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_CONFIRM)
	e2:SetCondition(c85876417.descon)
	e2:SetTarget(c85876417.destg)
	e2:SetOperation(c85876417.desop)
	c:RegisterEffect(e2)
end
function c85876417.descon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsAttributeExcept(ATTRIBUTE_LIGHT)
end
function c85876417.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c85876417.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Destroy(c,REASON_EFFECT)
	end
end