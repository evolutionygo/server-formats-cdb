--乾燥機塊ドライドレイク (Anime)
--Appliancer Dryer Drake (Anime)
--Scripted by pyrQ
function c511030061.initial_effect(c)
	c:EnableReviveLimit()
	--Link Summon
	Link.AddProcedure(c,c511030061.matfilter,1)
	--Cannot be used as Link Material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetCondition(c511030061.lkcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Increase ATK
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511030061.colinkcon)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	--Move monsters
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511030061.mvcon)
	e3:SetTarget(c511030061.mvtg)
	e3:SetOperation(c511030061.mvop)
	c:RegisterEffect(e3)
	--Negate attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BE_BATTLE_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(aux.NOT(c511030061.colinkcon))
	e4:SetOperation(function() Duel.NegateAttack() end)
	c:RegisterEffect(e4)
end
c511030061.listed_series={SET_APPLIANCER}
function c511030061.matfilter(c,lc,sumtype,tp)
	return c:IsSetCard(SET_APPLIANCER,fc,sumtype,tp) and c:IsLink(1)
end
function c511030061.lkcon(e)
	local c=e:GetHandler()
	return c:IsStatus(STATUS_SPSUMMON_TURN) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c511030061.colinkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMutualLinkedGroupCount()>0
end
function c511030061.mvcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(tp) and Duel.IsBattlePhase() and e:GetHandler():GetMutualLinkedGroupCount()>0
end
function c511030061.mvfilter(c)
	return c:IsSetCard(SET_APPLIANCER) and c:IsLinkMonster() and c:IsLink(1)
end
function c511030061.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc~=c and c511030061.mvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511030061.mvfilter,tp,LOCATION_MMZONE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511030061.mvfilter,tp,LOCATION_MMZONE,0,1,1,c)
end
function c511030061.mvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not (c:IsRelateToEffect(e) and tc:IsRelateToEffect(e)) then return end
	Duel.SwapSequence(c,tc)
	--Can make a 2nd attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
end