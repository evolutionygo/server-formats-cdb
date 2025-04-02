--地縛神の咆哮
--Roar of the Earthbound Immortal
function c56339050.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Destroy the attacking monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc56339050(c56339050,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1)
	e2:SetCondition(c56339050.condition)
	e2:SetTarget(c56339050.target)
	e2:SetOperation(c56339050.operation)
	c:RegisterEffect(e2)
end
c56339050.listed_series={SET_EARTHBOUND_IMMORTAL}
function c56339050.cfilter(c,atk)
	return c:IsFaceup() and c:IsSetCard(SET_EARTHBOUND_IMMORTAL) and c:GetAttack()>atk
end
function c56339050.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return Duel.IsTurnPlayer(1-tp) and Duel.IsExistingMatchingCard(c56339050.cfilter,tp,LOCATION_MZONE,0,1,nil,tc:GetAttack())
end
function c56339050.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetAttacker()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
	local dam=tc:GetAttack()/2
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c56339050.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not Duel.IsExistingMatchingCard(c56339050.cfilter,tp,LOCATION_MZONE,0,1,nil,tc:GetAttack()) then return end
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:CanAttack() then
		local atk=tc:GetAttack()/2
		if Duel.Destroy(tc,REASON_EFFECT)>0 and atk>0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end