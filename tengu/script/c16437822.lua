--フリント・アタック
--Flint Missile
function c16437822.initial_effect(c)
	--Destroy a monster equipped with "Flint"
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c16437822.target)
	e1:SetOperation(c16437822.activate)
	c:RegisterEffect(e1)
	--Register label before leaving the field
	local e2a=Effect.CreateEffect(c)
	e2a:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2a:SetCode(EVENT_LEAVE_FIELD_P)
	e2a:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2a:SetOperation(function(e) e:SetLabel(e:GetHandler():IsStatus(STATUS_LEAVE_CONFIRMED) and 1 or 0) end)
	c:RegisterEffect(e2a)
	--Return itself to the Deck instead of being sent to the GY
	local e2b=Effect.CreateEffect(c)
	e2b:SetDescription(aux.Stringc16437822(c16437822,0))
	e2b:SetCategory(CATEGORY_TODECK)
	e2b:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2b:SetCode(EVENT_TO_GRAVE)
	e2b:SetCondition(function(e) return e:GetLabelObject():GetLabel()==1 end)
	e2b:SetTarget(c16437822.rettg)
	e2b:SetOperation(c16437822.retop)
	e2b:SetLabelObject(e2a)
	c:RegisterEffect(e2b)
end
c16437822.listed_names={75560629}
function c16437822.filter(c)
	return c:GetEquipCount()>0 and c:GetEquipGroup():IsExists(Card.IsCode,1,nil,75560629)
end
function c16437822.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c16437822.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c16437822.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c16437822.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c16437822.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c16437822.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeck() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c16437822.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end