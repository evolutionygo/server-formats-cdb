--ゲットライド！
--Roll Out!
function c91597389.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc91597389(c91597389,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END|TIMINGS_CHECK_MONSTER_E)
	e1:SetTarget(c91597389.target)
	e1:SetOperation(c91597389.activate)
	c:RegisterEffect(e1)
end
c91597389.listed_card_types={TYPE_UNION}
function c91597389.tgfilter(c,tp)
	return c:IsType(TYPE_UNION) and Duel.IsExistingMatchingCard(c91597389.eqfilter,tp,LOCATION_MZONE,0,1,nil,c)
end
function c91597389.eqfilter(c,ec)
	return c:IsFaceup() and ec:CheckUnionTarget(c) and aux.CheckUnionEquip(ec,c)
end
function c91597389.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c91597389.tgfilter(chkc,tp) end
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if e:GetHandler():IsLocation(LOCATION_HAND) then ft=ft-1 end
	if chk==0 then return ft>0 and Duel.IsExistingTarget(c91597389.tgfilter,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c91597389.tgfilter,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,tp,0)
end
function c91597389.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local sc=Duel.SelectMatchingCard(tp,c91597389.eqfilter,tp,LOCATION_MZONE,0,1,1,nil,tc):GetFirst()
	if not sc then return end
	Duel.HintSelection(sc)
	if Duel.Equip(tp,tc,sc) then
		aux.SetUnionState(tc)
	end
end