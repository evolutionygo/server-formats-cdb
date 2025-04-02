--ドラゴンレーザー
--Dragon Laser
function c29228350.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c29228350.target)
	e1:SetOperation(c29228350.activate)
	c:RegisterEffect(e1)
end
c29228350.listed_names={48568432,12079734}
function c29228350.filter(c,tp)
	local ec=c:GetEquipTarget()
	return ec and ec:IsControler(tp) and c:IsCode(48568432) and ec:IsCode(12079734)
end
function c29228350.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_SZONE) and c29228350.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c29228350.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil,tp)
		and Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c29228350.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	local sg=Duel.GetFieldGroup(1-tp,LOCATION_MZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,#sg,0,0)
end
function c29228350.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
	local sg=Duel.GetFieldGroup(1-tp,LOCATION_MZONE,0)
	Duel.Destroy(sg,REASON_EFFECT)
end