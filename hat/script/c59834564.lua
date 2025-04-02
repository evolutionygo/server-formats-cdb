--嚇灼の魔神
--Bonfire Colossus
function c59834564.initial_effect(c)
	--Special Summon this card (from your hand)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc59834564(c59834564,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c59834564.spcon)
	c:RegisterEffect(e1)
	--Destroy 2 FIRE monsters you control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc59834564(c59834564,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c59834564.destg)
	e2:SetOperation(c59834564.desop)
	c:RegisterEffect(e2)
end
function c59834564.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsAttribute,ATTRIBUTE_FIRE),tp,LOCATION_MZONE,0,1,nil)
end
function c59834564.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c59834564.filter(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(aux.FaceupFilter(Card.IsAttribute,ATTRIBUTE_FIRE),tp,LOCATION_MZONE,0,2,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,aux.FaceupFilter(Card.IsAttribute,ATTRIBUTE_FIRE),tp,LOCATION_MZONE,0,2,2,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,tp,0)
	end
end
function c59834564.desopfilter(c,tp)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsFaceup() and c:IsControler(tp)
end
function c59834564.desop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetCards(e)
	if not tg then return end
	tg:Match(c59834564.desopfilter,nil,tp)
	if #tg>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end