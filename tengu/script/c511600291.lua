--ハンマー・シャーク (Anime)
--Hammer Shark (Anime)
--Scripted by Larry126
function c511600291.initial_effect(c)
	--reduce level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c511600291.target)
	e1:SetOperation(c511600291.operation)
	c:RegisterEffect(e1)
end
function c511600291.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(2)
end
function c511600291.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and not chkc:IsControler(tp) and c511600291.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511600291.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511600291.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511600291.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(-1)
		tc:RegisterEffect(e1)
	end
end