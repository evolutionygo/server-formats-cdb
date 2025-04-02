--黒炎弾
--Inferno Fire Blast (GOAT)
--If effect is negated, restriction doesn't apply
--If monsters are immuned, restruction doesn't apply
function c504700085.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c504700085.cost)
	e1:SetTarget(c504700085.target)
	e1:SetOperation(c504700085.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(c504700085,ACTIVITY_ATTACK,c504700085.counterfilter)
end
c504700085.listed_names={CARD_REDEYES_B_DRAGON}
function c504700085.counterfilter(c)
	return not c:IsCode(CARD_REDEYES_B_DRAGON)
end
function c504700085.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(c504700085,tp,ACTIVITY_ATTACK)==0 end
end
function c504700085.filter(c)
	return c:IsFaceup() and c:IsCode(CARD_REDEYES_B_DRAGON)
end
function c504700085.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c504700085.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c504700085.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c504700085.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c504700085.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,CARD_REDEYES_B_DRAGON))
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end