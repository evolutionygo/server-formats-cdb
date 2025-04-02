--ダイナレスラー・バーリオニクス (Anime)
--Dinowrestler Valeonyx (Anime)
--Scripted by Larry126
function c511600361.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600361(c511600361,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511600361.target)
	e1:SetOperation(c511600361.operation)
	c:RegisterEffect(e1)
end
c511600361.listed_series={0x11a}
function c511600361.filter(c)
	return c:IsType(TYPE_LINK) and c:IsSetCard(0x11a)
end
function c511600361.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511600361.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511600361.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511600361.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511600361.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c511600361.efilter)
		e1:SetOwnerPlayer(tp)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c511600361.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() and re:IsActiveType(TYPE_MONSTER)
		and re:IsActivated() and re:GetOwner():IsLinkBelow(8) and re:GetOwner():GetLink()<=e:GetHandler():GetLink()
end