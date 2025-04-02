--エレメント・ドラゴン
--Element Dragon (GOAT)
--Battle destroyed registers while the mosnter is on field
function c504700053.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetCondition(c504700053.atkcon)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc504700053(c504700053,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c504700053.atcon)
	e2:SetOperation(c504700053.atop)
	c:RegisterEffect(e2)
end
function c504700053.atkcon(e)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsAttribute,ATTRIBUTE_FIRE),0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c504700053.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local attg=Duel.GetAttackTarget()
	return attg and Duel.GetAttacker()==c and attg:IsControler(1-tp) and attg:IsBattleDestroyed() and c:CanChainAttack()
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsAttribute,ATTRIBUTE_WIND),tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c504700053.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end