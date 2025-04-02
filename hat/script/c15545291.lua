--剛地帝グランマーグ
function c15545291.initial_effect(c)
	--summon with 1 tribute
	local e2=aux.AddNormalSummonProcedure(c,true,true,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc15545291(c15545291,0),c15545291.otfilter)
	local e2a=aux.AddNormalSetProcedure(c,true,true,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringc15545291(c15545291,0),c15545291.otfilter)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc15545291(c15545291,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c15545291.descon)
	e3:SetTarget(c15545291.destg)
	e3:SetOperation(c15545291.desop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MATERIAL_CHECK)
	e4:SetValue(c15545291.valcheck)
	e4:SetLabelObject(e3)
	c:RegisterEffect(e4)
end
function c15545291.otfilter(c)
	return c:IsSummonType(SUMMON_TYPE_TRIBUTE)
end
function c15545291.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_TRIBUTE)
end
function c15545291.desfilter(c)
	return c:IsFacedown()
end
function c15545291.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c15545291.desfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c15545291.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	if e:GetLabel()==1 then
		e:SetLabel(0)
		e:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end
end
function c15545291.dfilter(c,e)
	return c:IsFacedown() and c:IsRelateToEffect(e)
end
function c15545291.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c15545291.dfilter,nil,e)
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
	if Duel.GetOperationInfo(0,CATEGORY_DRAW) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c15545291.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_EARTH) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end