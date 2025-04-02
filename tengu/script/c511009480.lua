--ギャラクシーアイズ ＦＡ・フォトン・ドラゴン (Manga)
--Galaxy Eyes Full Armor Photon Dragon (Manga)
Duel.EnableGlobalFlag(GLOBALFLAG_DETACH_EVENT)
function c511009480.initial_effect(c)
	aux.AddXyzProcedure(c,nil,8,3)
	c:EnableReviveLimit()
	--xyz summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511009480(c511009480,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511009480.xyzcon)
	e1:SetTarget(c511009480.xyztg)
	e1:SetOperation(c511009480.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511009480(c511009480,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c511009480.descon)
	e2:SetCost(c511009480.descost)
	e2:SetTarget(c511009480.destg)
	e2:SetOperation(c511009480.desop)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
	--material
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511009480(c511009480,2))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511009480.mtcon)
	e3:SetTarget(c511009480.mttg)
	e3:SetOperation(c511009480.mtop)
	c:RegisterEffect(e3)
	--banish
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc511009480(c511009480,3))
	e4:SetCategory(CATEGORY_DISABLE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c511009480.rmcon)
	e4:SetCost(c511009480.rmcost)
	e4:SetTarget(c511009480.rmtg)
	e4:SetOperation(c511009480.rmop)
	c:RegisterEffect(e4)
	aux.GlobalCheck(s,function()
		local ge=Effect.CreateEffect(c)
		ge:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge:SetCode(EVENT_DETACH_MATERIAL)
		ge:SetOperation(c511009480.checkop)
		Duel.RegisterEffect(ge,0)
	end)
end
c511009480.listed_names={CARD_GALAXYEYES_P_DRAGON}
function c511009480.ovfilter(c,tp,xyz)
	return c:IsFaceup() and c:IsCode(CARD_GALAXYEYES_P_DRAGON) and c:GetEquipCount()==2
		and Duel.GetLocationCountFromEx(tp,tp,c,xyz)>0
end
function c511009480.xyzcon(e,c)
	if c==nil then return true end
	if og then return false end
	local tp=c:GetControler()
	local mg=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local mustg=aux.GetMustBeMaterialGroup(tp,Group.CreateGroup(),tp,c,mg,REASON_XYZ)
	if #mustg>0 or (min and min>1) then return false end
	return Duel.CheckReleaseGroup(c:GetControler(),c511009480.ovfilter,1,false,1,true,c,c:GetControler(),nil,false,nil,tp,c)
end
function c511009480.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.SelectReleaseGroup(tp,c511009480.ovfilter,1,1,false,true,true,c,nil,nil,false,nil,tp,c)
	if g then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function c511009480.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	local eqg=g:GetFirst():GetEquipGroup()
	e:GetHandler():SetMaterial(eqg)
	Duel.Overlay(e:GetHandler(),eqg)
	Duel.Release(g,REASON_COST)
	g:DeleteGroup()
 end
function c511009480.descon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c511009480.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c511009480.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511009480.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511009480.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0 and e:GetHandler():GetFlagEffect(c511009480)~=0
end
function c511009480.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipCount()>0 end
end
function c511009480.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(aux.NOT(Card.IsImmuneToEffect),nil,e)
	if not c:IsRelateToEffect(e) or c:IsFacedown() or #g==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACH)
	local tg=g:Select(tp,1,#g,nil)
	if #tg>0 then
		Duel.Overlay(c,tg)
	end
end
function c511009480.rmcon(e,tp,eg,ep,ev,re,r,rp,chk)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp
end
function c511009480.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,e:GetHandler():GetOverlayGroup():GetCount(),e:GetHandler():GetOverlayGroup():GetCount(),REASON_COST)
end
function c511009480.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511009480.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) and c:IsAbleToRemove() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
	g:AddCard(c)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,0,0)
end
function c511009480.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local g=Group.FromCards(c,tc)
	local mcount=0
	if tc:IsFaceup() then mcount=tc:GetOverlayCount() end
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local og=Duel.GetOperatedGroup()
		if not og:IsContains(tc) then mcount=0 end
		for tc in aux.Next(og) do
			tc:RegisterFlagEffect(CARD_GALAXYEYES_P_DRAGON,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END,0,1)
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE|PHASE_END)
		e1:SetLabel(mcount)
		e1:SetCountLimit(1)
		e1:SetLabelObject(og)
		e1:SetOperation(c511009480.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511009480.retfilter(c)
	return c:GetFlagEffect(CARD_GALAXYEYES_P_DRAGON)~=0
end
function c511009480.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(c511009480.retfilter,nil)
	g:DeleteGroup()
	for tc in aux.Next(sg) do
		 Duel.ReturnToField(tc)
	end
end
function c511009480.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg and #eg>0 then
		for tc in aux.Next(eg) do
			if tc:IsFaceup() and (r&REASON_COST)==REASON_COST then
				tc:RegisterFlagEffect(c511009480,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END,0,1)
			end
		end
	end
end