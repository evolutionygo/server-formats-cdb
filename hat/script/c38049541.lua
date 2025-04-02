--Ａ・ジェネクス・ケミストリ
--Genex Ally Chemister
function c38049541.initial_effect(c)
	--Change the Attribute of 1 "Genex" monster you control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc38049541(c38049541,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c38049541.attrcost)
	e1:SetTarget(c38049541.attrtg)
	e1:SetOperation(c38049541.attrop)
	c:RegisterEffect(e1)
end
c38049541.listed_series={SET_GENEX}
function c38049541.attrcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c38049541.attrtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() and chkc:IsSetCard(SET_GENEX) and chkc:IsAttributeExcept(e:GetLabel()) end
	if chk==0 then return Duel.IsExistingTarget(aux.FaceupFilter(Card.IsSetCard,SET_GENEX),tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(aux.AND(Card.IsCanBeEffectTarget,aux.FaceupFilter(Card.IsSetCard,SET_GENEX)),tp,LOCATION_MZONE,0,nil,e)
	local att=Duel.AnnounceAnotherAttribute(g,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local sel=g:FilterSelect(tp,Card.IsAttributeExcept,1,1,nil,att)
	Duel.SetTargetCard(sel)
	e:SetLabel(att)
end
function c38049541.attrop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		--Change Attribute
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end