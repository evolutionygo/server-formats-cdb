--墓守の暗殺者
function c25262697.initial_effect(c)
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc25262697(c25262697,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c25262697.poscon)
	e1:SetTarget(c25262697.postg)
	e1:SetOperation(c25262697.posop)
	c:RegisterEffect(e1)
end
c25262697.listed_names={CARD_NECROVALLEY}
function c25262697.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(CARD_NECROVALLEY)
end
function c25262697.filter(c)
	return c:IsFaceup() and c:IsCanChangePosition()
end
function c25262697.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c25262697.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c25262697.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c25262697.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c25262697.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end