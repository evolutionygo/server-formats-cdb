--道連れ
--Michizure (GOAT)
--Cannot be activated during the damage step
function c504700059.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c504700059.condition)
	e1:SetTarget(c504700059.target)
	e1:SetOperation(c504700059.activate)
	c:RegisterEffect(e1)
end
function c504700059.filter(c,tp)
	return c:IsMonster() and c:IsControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c504700059.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c504700059.filter,1,nil,tp)
end
function c504700059.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c504700059.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end