--カウンター・ジェム
--Counter Gem
function c11136371.initial_effect(c)
	--Place as many "Crystal Beast" monsters as possible from your GY face-up in your S/Trap Zone
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc11136371(c11136371,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c11136371.plcost)
	e1:SetTarget(c11136371.pltg)
	e1:SetOperation(c11136371.plop)
	c:RegisterEffect(e1)
end
c11136371.listed_series={SET_CRYSTAL_BEAST}
function c11136371.plcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_STZONE,0,e:GetHandler())
	if chk==0 then return #g>0 and #g==g:FilterCount(Card.IsAbleToGraveAsCost,nil) end
	g:Filter(Card.IsAbleToGraveAsCost,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c11136371.plfilter(c)
	return c:IsSetCard(SET_CRYSTAL_BEAST) and not c:IsForbc11136371den()
end
function c11136371.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11136371.plfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE)
end
function c11136371.plop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c11136371.plfilter,tp,LOCATION_GRAVE,0,ft,ft,nil)
	if #g>0 then
		for tc in g:Iter() do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT|(RESETS_STANDARD&~RESET_TURN_SET))
			e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
			tc:RegisterEffect(e1)
		end
		Duel.RaiseEvent(g,EVENT_CUSTOM+47408488,e,0,tp,0,0)--Event used by Crystal Tree
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c11136371.descon)
	e1:SetOperation(c11136371.desop)
	e1:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c11136371.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,SET_CRYSTAL_BEAST),tp,LOCATION_ONFIELD,0,1,nil)
end
function c11136371.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsSetCard,SET_CRYSTAL_BEAST),tp,LOCATION_ONFIELD,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
end