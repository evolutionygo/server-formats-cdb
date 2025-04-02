--インフェルニティ・ブレイク
--Infernity Break
function c51717541.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc51717541(c51717541,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END|TIMINGS_CHECK_MONSTER_E)
	e1:SetCondition(function(e,tp) return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 end)
	e1:SetTarget(c51717541.target)
	e1:SetOperation(c51717541.activate)
	c:RegisterEffect(e1)
end
c51717541.listed_series={SET_INFERNITY}
function c51717541.rmfilter(c,tp)
	return c:IsSetCard(SET_INFERNITY) and c:IsAbleToRemove() and aux.SpElimFilter(c,true) 
end
function c51717541.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.IsExistingTarget(c51717541.rmfilter,tp,LOCATION_MZONE|LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectTarget(tp,c51717541.rmfilter,tp,LOCATION_MZONE|LOCATION_GRAVE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,rg,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,1,tp,0)
end
function c51717541.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetCards(e)
	if #tg==0 then return end
	local rg,dg=tg:Split(Card.IsControler,nil,tp)
	if #rg>0 and Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)>0 and #dg>0 then
		Duel.Destroy(dg,REASON_EFFECT)
	end
end