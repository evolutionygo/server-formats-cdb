--氷結界の神精霊
--Sacred Spirit of the Ice Barrier
function c44877690.initial_effect(c)
	local sme,soe=Spirit.AddProcedure(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--Mandatory return
	sme:SetDescription(aux.Stringc44877690(c44877690,0))
	sme:SetCondition(c44877690.mretcon)
	sme:SetTarget(c44877690.mrettg)
	sme:SetOperation(c44877690.mretop)
	--Optional return
	soe:SetCondition(aux.AND(aux.NOT(c44877690.icecon),Spirit.OptionalReturnCondition))
	--Cannot be Special Summoned
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
end
c44877690.listed_series={SET_ICE_BARRIER}
function c44877690.icecon(e,tp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,SET_ICE_BARRIER),tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c44877690.mretcon(e,tp,eg,ep,ev,re,r,rp)
	return Spirit.CommonCondition(e) and (c44877690.icecon(e,tp) or Spirit.MandatoryReturnCondition(e))
end
function c44877690.mrettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c44877690.icecon(e,tp) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:GetHandler():ResetFlagEffect(FLAG_SPIRIT_RETURN)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,#g,0,0)
	else
		e:SetProperty(0)
		Spirit.MandatoryReturnTarget(e,tp,eg,ep,ev,re,r,rp,1)
	end
end
function c44877690.mretop(e,tp,eg,ep,ev,re,r,rp)
	if not e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return Spirit.ReturnOperation(e,tp,eg,ep,ev,re,r,rp) end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end