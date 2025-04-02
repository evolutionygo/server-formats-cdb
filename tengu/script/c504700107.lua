--エレメント・マジシャン
--Element Magician (GOAT)
--Battle destroyed registers while the mosnter is on field
function c504700107.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	e1:SetCondition(c504700107.ctlcon)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc504700107(c504700107,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c504700107.atcon)
	e2:SetOperation(c504700107.atop)
	c:RegisterEffect(e2)
end
function c504700107.filter(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c504700107.ctlcon(e)
	return Duel.IsExistingMatchingCard(c504700107.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_WATER)
end
function c504700107.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local attg=Duel.GetAttackTarget()
	return attg and Duel.GetAttacker()==c and attg:IsControler(1-tp) and attg:IsBattleDestroyed()
		and c:CanChainAttack() and Duel.IsExistingMatchingCard(c504700107.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_WIND)
end
function c504700107.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end